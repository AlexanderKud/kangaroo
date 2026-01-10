// =============================================================================
// Pollard's Kangaroo Algorithm - GPU Kernel (Jacobian Coordinates)
// =============================================================================
// Uses Jacobian coordinates for fast point addition without modular inverse
// Optimized with Workgroup Batch Inversion (Montgomery)

// -----------------------------------------------------------------------------
// Configuration
// -----------------------------------------------------------------------------

struct Config {
    dp_mask_lo: vec4<u32>,
    dp_mask_hi: vec4<u32>,
    num_kangaroos: u32,
    steps_per_call: u32,
    jump_table_size: u32,
    _padding: u32
}

// Kangaroo state - uses Jacobian coordinates
// Must match Rust GpuKangaroo struct layout!
struct Kangaroo {
    x: array<u32, 8>,           // Jacobian X (32 bytes)
    y: array<u32, 8>,           // Jacobian Y (32 bytes)
    z: array<u32, 8>,           // Jacobian Z (32 bytes)
    dist: array<u32, 8>,        // Distance traveled (32 bytes)
    ktype: u32,                 // 0 = Tame, 1 = Wild
    is_active: u32,
    _padding: array<u32, 2>     // Align to 16 bytes
}

// AffinePoint is defined in curve_jacobian.wgsl

struct DistinguishedPoint {
    x: array<u32, 8>,           // Affine X (stored after batch normalization when Z=1)
    z: array<u32, 8>,           // Z coordinate (always 1 after normalization)
    dist: array<u32, 8>,
    ktype: u32,
    kangaroo_id: u32,
}

// -----------------------------------------------------------------------------
// Buffers
// -----------------------------------------------------------------------------

@group(0) @binding(0) var<uniform> config: Config;
@group(0) @binding(1) var<storage, read> jump_points: array<AffinePoint, 256>;
@group(0) @binding(2) var<storage, read> jump_distances: array<array<u32, 8>, 256>;
@group(0) @binding(3) var<storage, read_write> kangaroos: array<Kangaroo>;
@group(0) @binding(4) var<storage, read_write> dp_buffer: array<DistinguishedPoint>;
@group(0) @binding(5) var<storage, read_write> dp_count: atomic<u32>;

// Shared memory for batch inversion
var<workgroup> shared_z: array<array<u32, 8>, 64>;
var<workgroup> shared_prod: array<array<u32, 8>, 64>;

// -----------------------------------------------------------------------------
// Store distinguished point (already in affine after batch normalization)
// -----------------------------------------------------------------------------

fn store_dp(k: Kangaroo, kangaroo_id: u32) {
    let idx = atomicAdd(&dp_count, 1u);

    if (idx < 65536u) {
        var dp: DistinguishedPoint;
        // Store affine X (Z=1 after normalization)
        dp.x = k.x;
        dp.z = k.z;
        dp.dist = k.dist;
        dp.ktype = k.ktype;
        dp.kangaroo_id = kangaroo_id;
        dp_buffer[idx] = dp;
    }
}

// -----------------------------------------------------------------------------
// Main compute shader
// -----------------------------------------------------------------------------

@compute @workgroup_size(64)
fn main(@builtin(global_invocation_id) global_id: vec3<u32>, @builtin(local_invocation_id) local_id_vec: vec3<u32>) {
    let kid = global_id.x;
    let lid = local_id_vec.x;

    // Load kangaroo state (if valid)
    var k: Kangaroo;
    var valid = false;
    if (kid < config.num_kangaroos) {
        k = kangaroos[kid];
        if (k.is_active != 0u) {
            valid = true;
        }
    }

    // Build Jacobian point from state
    var p: JacobianPoint;
    if (valid) {
        p.x = k.x;
        p.y = k.y;
        p.z = k.z;
    } else {
        // Initialize dummy point for inactive threads to avoid messing up batch inversion
        p.x = fe_one();
        p.y = fe_one();
        p.z = fe_one(); // Z=1 ensures safe inversion and no-op
    }

    // Track if we already stored a DP this batch (to avoid flooding)
    var dp_stored = false;

    // Perform jumps
    for (var step = 0u; step < config.steps_per_call; step++) {
        // =====================================================================
        // BATCH NORMALIZATION (Simultaneous Inversion)
        // =====================================================================
        
        // 1. Load Z into shared memory
        shared_z[lid] = p.z;
        workgroupBarrier();

        // 2. Thread 0 computes prefix products and total inverse
        // Using serial implementation for simplicity and robustness
        if (lid == 0u) {
            var prod = fe_one();
            
            // Compute prefix products: shared_prod[i] = z_0 * ... * z_i
            for (var i = 0u; i < 64u; i++) {
                prod = fe_mul(prod, shared_z[i]);
                shared_prod[i] = prod;
            }

            // Invert total product
            var inv = fe_inv(prod);

            // Compute inverses backwards
            // inv_z[i] = inv_total * L[i-1] * R[i+1] (implicitly handled)
            // Algorithm:
            // inv_acc = inv_all
            // for i = N-1 to 1:
            //   inv_z[i] = inv_acc * L[i-1]
            //   inv_acc = inv_acc * z[i]
            // inv_z[0] = inv_acc
            
            var inv_acc = inv;
            for (var i = 63u; i > 0u; i--) {
                let prev_prod = shared_prod[i - 1u];
                let val_inv = fe_mul(inv_acc, prev_prod);
                let val_z = shared_z[i];
                
                // Store result back in shared_z to save space
                // We are done with z[i] after this step
                // CAREFUL: We need shared_z[i] for the update of inv_acc
                
                // We need a temporary for z[i] because we are overwriting shared_z[i]
                // Actually we can just write to shared_prod? No, shared_prod used L[i-1].
                // We can overwrite shared_prod[i] with the result inverse!
                shared_prod[i] = val_inv;
                
                inv_acc = fe_mul(inv_acc, val_z);
            }
            shared_prod[0] = inv_acc;
        }
        workgroupBarrier();

        // 3. Read inverse Z from shared memory
        let z_inv = shared_prod[lid];
        let z_inv2 = fe_square(z_inv);
        
        // 4. Normalize X (and Y if needed, but we only need X for jump)
        // Only normalize if not already normalized
        // For batch inversion, we always run it, but if Z was 1, z_inv is 1.
        
        var x_affine: array<u32, 8>;
        
        // Check if Z was 1 (optimization)
        // Actually, we can just do the mul.
        x_affine = fe_mul(p.x, z_inv2);
        
        // Update P to affine (Optional? We need it for DP check and Jump)
        // Yes, we must update P to affine to ensure paths merge!
        // Otherwise we have (X_af, Y_jac, 1) vs (X_jac, Y_jac, Z).
        // We need to reset Z to 1.
        
        let z_inv3 = fe_mul(z_inv2, z_inv);
        p.x = x_affine;
        p.y = fe_mul(p.y, z_inv3);
        p.z = fe_one(); // Z is now 1

        // =====================================================================
        // LOGIC
        // =====================================================================

        if (valid) {
            // Check for DP
            if (!dp_stored) {
                // Check first limb against mask
                if ((p.x[0] & config.dp_mask_lo.x) == 0u) {
                    k.x = p.x;
                    k.y = p.y;
                    k.z = p.z;
                    store_dp(k, kid);
                    dp_stored = true;
                }
            }

            // Select jump
            let jump_idx = p.x[0] & 0xFFu;
            let jump_point = jump_points[jump_idx];
            let jump_dist = jump_distances[jump_idx];

            // Add jump point (affine)
            p = jac_add_affine(p, jump_point.x, jump_point.y);

            // Update distance
            k.dist = scalar_add_256(k.dist, jump_dist);
        }
    }

    // Write back updated state
    if (valid) {
        k.x = p.x;
        k.y = p.y;
        k.z = p.z;
        kangaroos[kid] = k;
    }
}
