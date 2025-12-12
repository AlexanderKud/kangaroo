// =============================================================================
// Precomputed G Tables and Helper Functions
// =============================================================================

// Precomputed table: iG for i = 1..15 (affine coordinates, little-endian)
const G1_X: array<u32, 8> = array<u32, 8>(0x16F81798u, 0x59F2815Bu, 0x2DCE28D9u, 0x029BFCDBu, 0xCE870B07u, 0x55A06295u, 0xF9DCBBACu, 0x79BE667Eu);
const G1_Y: array<u32, 8> = array<u32, 8>(0xFB10D4B8u, 0x9C47D08Fu, 0xA6855419u, 0xFD17B448u, 0x0E1108A8u, 0x5DA4FBFCu, 0x26A3C465u, 0x483ADA77u);
const G2_X: array<u32, 8> = array<u32, 8>(0x5C709EE5u, 0xABAC09B9u, 0x8CEF3CA7u, 0x5C778E4Bu, 0x95C07CD8u, 0x3045406Eu, 0x41ED7D6Du, 0xC6047F94u);
const G2_Y: array<u32, 8> = array<u32, 8>(0x50CFE52Au, 0x236431A9u, 0x3266D0E1u, 0xF7F63265u, 0x466CEAEEu, 0xA3C58419u, 0xA63DC339u, 0x1AE168FEu);
const G3_X: array<u32, 8> = array<u32, 8>(0xBCE036F9u, 0x8601F113u, 0x836F99B0u, 0xB531C845u, 0xF89D5229u, 0x49344F85u, 0x9258C310u, 0xF9308A01u);
const G3_Y: array<u32, 8> = array<u32, 8>(0x84B8E672u, 0x6CB9FD75u, 0x34C2231Bu, 0x6500A999u, 0x2A37F356u, 0x0FE337E6u, 0x632DE814u, 0x388F7B0Fu);
const G4_X: array<u32, 8> = array<u32, 8>(0xE8C4CD13u, 0x74FA94ABu, 0x0EE07584u, 0xCC6C1390u, 0x930B1404u, 0x581E4904u, 0xC10D80F3u, 0xE493DBF1u);
const G4_Y: array<u32, 8> = array<u32, 8>(0x47739922u, 0xCFE97BDCu, 0xBFBDFE40u, 0xD967AE33u, 0x8EA51448u, 0x5642E209u, 0xA0D455B7u, 0x51ED993Eu);
const G5_X: array<u32, 8> = array<u32, 8>(0xB240EFE4u, 0xCBA8D569u, 0xDC619AB7u, 0xE88B84BDu, 0x0A5C5128u, 0x55B4A725u, 0x1A072093u, 0x2F8BDE4Du);
const G5_Y: array<u32, 8> = array<u32, 8>(0xA6AC62D6u, 0xDCA87D3Au, 0xAB0D6840u, 0xF788271Bu, 0xA6C9C426u, 0xD4DBA9DDu, 0x36E5E3D6u, 0xD8AC2226u);
const G6_X: array<u32, 8> = array<u32, 8>(0x60297556u, 0x2F057A14u, 0x8568A18Bu, 0x82F6472Fu, 0x355235D3u, 0x20453A14u, 0x755EEEA4u, 0xFFF97BD5u);
const G6_Y: array<u32, 8> = array<u32, 8>(0xB075F297u, 0x3C870C36u, 0x518FE4A0u, 0xDE80F0F6u, 0x7F45C560u, 0xF3BE9601u, 0xACFBB620u, 0xAE12777Au);
const G7_X: array<u32, 8> = array<u32, 8>(0xCAC4F9BCu, 0xE92BDDEDu, 0x0330E39Cu, 0x3D419B7Eu, 0xF2EA7A0Eu, 0xA398F365u, 0x6E5DB4EAu, 0x5CBDF064u);
const G7_Y: array<u32, 8> = array<u32, 8>(0x087264DAu, 0xA5082628u, 0x13FDE7B5u, 0xA813D0B8u, 0x861A54DBu, 0xA3178D6Du, 0xBA255960u, 0x6AEBCA40u);
const G8_X: array<u32, 8> = array<u32, 8>(0xE10A2A01u, 0x67784EF3u, 0xE5AF888Au, 0x0A1BDD05u, 0xB70F3C2Fu, 0xAFF3843Fu, 0x5CCA351Du, 0x2F01E5E1u);
const G8_Y: array<u32, 8> = array<u32, 8>(0x6CBDE904u, 0xB5DA2CB7u, 0xBA5B7617u, 0xC2E213D6u, 0x132D13B4u, 0x293D082Au, 0x41539949u, 0x5C4DA8A7u);
const G9_X: array<u32, 8> = array<u32, 8>(0xFC27CCBEu, 0xC35F110Du, 0x4C57E714u, 0xE0979697u, 0x9F559ABDu, 0x09AD178Au, 0xF0C7F653u, 0xACD484E2u);
const G9_Y: array<u32, 8> = array<u32, 8>(0xC64F9C37u, 0x05CC262Au, 0x375F8E0Fu, 0xADD888A4u, 0x763B61E9u, 0x64380971u, 0xB0A7D9FDu, 0xCC338921u);
const G10_X: array<u32, 8> = array<u32, 8>(0x47E247C7u, 0x52A68E2Au, 0x1943C2B7u, 0x3442D49Bu, 0x1AE6AE5Du, 0x35477C7Bu, 0x47F3C862u, 0xA0434D9Eu);
const G10_Y: array<u32, 8> = array<u32, 8>(0x037368D7u, 0x3CBEE53Bu, 0xD877A159u, 0x6F794C2Eu, 0x93A24C69u, 0xA3B6C7E6u, 0x5419BC27u, 0x893ABA42u);
const G11_X: array<u32, 8> = array<u32, 8>(0x5DA008CBu, 0xBBEC1789u, 0xE5C17891u, 0x5649980Bu, 0x70C65AACu, 0x5EF4246Bu, 0x58A9411Eu, 0x774AE7F8u);
const G11_Y: array<u32, 8> = array<u32, 8>(0xC953C61Bu, 0x301D74C9u, 0xDFF9D6A8u, 0x372DB1E2u, 0xD7B7B365u, 0x0243DD56u, 0xEB6B5E19u, 0xD984A032u);
const G12_X: array<u32, 8> = array<u32, 8>(0x70AFE85Au, 0xC5B0F470u, 0x9620095Bu, 0x687CF441u, 0x4D734633u, 0x15C38F00u, 0x48E7561Bu, 0xD01115D5u);
const G12_Y: array<u32, 8> = array<u32, 8>(0xF4062327u, 0x6B051B13u, 0xD9A86D52u, 0x79238C5Du, 0xE17BD815u, 0xA8B64537u, 0xC815E0D7u, 0xA9F34FFDu);
const G13_X: array<u32, 8> = array<u32, 8>(0x19405AA8u, 0xDEEDDF8Fu, 0x610E58CDu, 0xB075FBC6u, 0xC3748651u, 0xC7D1D205u, 0xD975288Bu, 0xF28773C2u);
const G13_Y: array<u32, 8> = array<u32, 8>(0xDB03ED81u, 0x29B5CB52u, 0x521FA91Fu, 0x3A1A06DAu, 0x65CDAF47u, 0x758212EBu, 0x8D880A89u, 0x0AB0902Eu);
const G14_X: array<u32, 8> = array<u32, 8>(0x60E823E4u, 0xE49B241Au, 0x678949E6u, 0x26AA7B63u, 0x07D38E32u, 0xFD64E67Fu, 0x895E719Cu, 0x499FDF9Eu);
const G14_Y: array<u32, 8> = array<u32, 8>(0x03A13F5Bu, 0xC65F40D4u, 0x7A3F95BCu, 0x464279C2u, 0xA7B3D464u, 0x90F044E4u, 0xB54E8551u, 0xCAC2F6C4u);
const G15_X: array<u32, 8> = array<u32, 8>(0xE27E080Eu, 0x44ADBCF8u, 0x3C85F79Eu, 0x31E5946Fu, 0x095FF411u, 0x5A465AE3u, 0x7D43EA96u, 0xD7924D4Fu);
const G15_Y: array<u32, 8> = array<u32, 8>(0xF6A26B58u, 0xC504DC9Fu, 0xD896D3A5u, 0xEA40AF2Bu, 0x28CC6DEFu, 0x83842EC2u, 0xA86C72A6u, 0x581E2872u);

// Multiples of 16G for offset handling
const G16_X: array<u32, 8> = array<u32, 8>(0x2A6DEC0Au, 0xC44EE89Eu, 0xB87A5AE9u, 0xB2A31369u, 0x21C23E97u, 0x3011AABCu, 0xB59E9EC5u, 0xE60FCE93u);
const G16_Y: array<u32, 8> = array<u32, 8>(0x69616821u, 0xE1F32CCEu, 0x44D23F0Bu, 0x1296891Eu, 0xF5793710u, 0x9DB99F34u, 0x99E59592u, 0xF7E35073u);
const G32_X: array<u32, 8> = array<u32, 8>(0x07143E65u, 0x75D0DBD4u, 0x9904A61Du, 0xDACFFCB8u, 0xE2F378CEu, 0x47B6E054u, 0x4FB5A22Du, 0xD30199D7u);
const G32_Y: array<u32, 8> = array<u32, 8>(0x24106AB9u, 0x05B3FF1Fu, 0x64ED8196u, 0x1F760CC3u, 0xE9838065u, 0xB3D6DEC9u, 0x0AE3D5C3u, 0x95038D9Du);
const G48_X: array<u32, 8> = array<u32, 8>(0x1118E5C3u, 0x9BD870AAu, 0x452BEBC1u, 0xFC579B27u, 0xF4E65B4Bu, 0xB441656Eu, 0x9645307Du, 0x6ECA335Du);
const G48_Y: array<u32, 8> = array<u32, 8>(0x05A08668u, 0x498A2F78u, 0x3BF8EC34u, 0x3A496A3Au, 0x74B875A0u, 0x592F5790u, 0x7A7A0710u, 0xD50123B5u);
const G64_X: array<u32, 8> = array<u32, 8>(0x3B78CE56u, 0x3C7B3C19u, 0x98C9623Au, 0x2B91CF3Du, 0x6DB6BF8Fu, 0x6E84A5E2u, 0x4A59D0CDu, 0x8282263Du);
const G64_Y: array<u32, 8> = array<u32, 8>(0xB69ED0F7u, 0xD653CED3u, 0x59CDFD9Bu, 0x3E6ABD99u, 0x0C8F2FFFu, 0x8F04FA06u, 0x26BBE4D3u, 0x11F8A809u);

// Lookup precomputed point iG for i = 1..15
fn lookup_g_table(i: u32) -> array<array<u32, 8>, 2> {
    var result: array<array<u32, 8>, 2>;
    switch (i) {
        case 1u: { result[0] = G1_X; result[1] = G1_Y; }
        case 2u: { result[0] = G2_X; result[1] = G2_Y; }
        case 3u: { result[0] = G3_X; result[1] = G3_Y; }
        case 4u: { result[0] = G4_X; result[1] = G4_Y; }
        case 5u: { result[0] = G5_X; result[1] = G5_Y; }
        case 6u: { result[0] = G6_X; result[1] = G6_Y; }
        case 7u: { result[0] = G7_X; result[1] = G7_Y; }
        case 8u: { result[0] = G8_X; result[1] = G8_Y; }
        case 9u: { result[0] = G9_X; result[1] = G9_Y; }
        case 10u: { result[0] = G10_X; result[1] = G10_Y; }
        case 11u: { result[0] = G11_X; result[1] = G11_Y; }
        case 12u: { result[0] = G12_X; result[1] = G12_Y; }
        case 13u: { result[0] = G13_X; result[1] = G13_Y; }
        case 14u: { result[0] = G14_X; result[1] = G14_Y; }
        case 15u: { result[0] = G15_X; result[1] = G15_Y; }
        default: { result[0] = fe_zero(); result[1] = fe_zero(); }
    }
    return result;
}

// Lookup precomputed 16*i*G for i = 1..4
fn lookup_16g_table(i: u32) -> array<array<u32, 8>, 2> {
    var result: array<array<u32, 8>, 2>;
    switch (i) {
        case 1u: { result[0] = G16_X; result[1] = G16_Y; }
        case 2u: { result[0] = G32_X; result[1] = G32_Y; }
        case 3u: { result[0] = G48_X; result[1] = G48_Y; }
        case 4u: { result[0] = G64_X; result[1] = G64_Y; }
        default: { result[0] = fe_zero(); result[1] = fe_zero(); }
    }
    return result;
}

// Add offset*G to a Jacobian point using precomputed tables
fn add_offset_g(p: JacobianPoint, offset: u32) -> JacobianPoint {
    if (offset == 0u) { return p; }

    var result = p;

    // For offsets 1-15, single lookup
    if (offset <= 15u) {
        let pt = lookup_g_table(offset);
        if (jac_is_infinity(result)) {
            result.x = pt[0]; result.y = pt[1]; result.z = fe_one();
        } else {
            result = jac_add_affine(result, pt[0], pt[1]);
        }
        return result;
    }

    // For offsets 16-63, decompose
    let low_nibble = offset & 0xFu;
    let high_nibble = (offset >> 4u) & 0x3u;

    if (high_nibble > 0u) {
        let pt = lookup_16g_table(high_nibble);
        if (jac_is_infinity(result)) {
            result.x = pt[0]; result.y = pt[1]; result.z = fe_one();
        } else {
            result = jac_add_affine(result, pt[0], pt[1]);
        }
    }

    if (low_nibble > 0u) {
        let pt = lookup_g_table(low_nibble);
        if (jac_is_infinity(result)) {
            result.x = pt[0]; result.y = pt[1]; result.z = fe_one();
        } else {
            result = jac_add_affine(result, pt[0], pt[1]);
        }
    }

    return result;
}

// Convert Jacobian to affine using provided z_inv (z⁻¹)
fn jac_to_affine_with_zinv(p: JacobianPoint, z_inv: array<u32, 8>) -> array<u32, 16> {
    let z2_inv = fe_square(z_inv);
    let z3_inv = fe_mul(z_inv, z2_inv);
    let x_affine = fe_mul(p.x, z2_inv);
    let y_affine = fe_mul(p.y, z3_inv);

    var result: array<u32, 16>;
    result[0] = x_affine[0]; result[1] = x_affine[1];
    result[2] = x_affine[2]; result[3] = x_affine[3];
    result[4] = x_affine[4]; result[5] = x_affine[5];
    result[6] = x_affine[6]; result[7] = x_affine[7];
    result[8] = y_affine[0]; result[9] = y_affine[1];
    result[10] = y_affine[2]; result[11] = y_affine[3];
    result[12] = y_affine[4]; result[13] = y_affine[5];
    result[14] = y_affine[6]; result[15] = y_affine[7];

    return result;
}

// Create compressed pubkey (33 bytes)
fn make_compressed_pubkey(x: array<u32, 8>, y: array<u32, 8>) -> array<u32, 9> {
    var pubkey: array<u32, 9>;
    let y_is_odd = (y[0] & 1u) == 1u;
    let prefix = select(0x02000000u, 0x03000000u, y_is_odd);

    pubkey[0] = prefix | ((x[7] >> 8u) & 0x00FFFFFFu);
    pubkey[1] = (x[7] << 24u) | ((x[6] >> 8u) & 0x00FFFFFFu);
    pubkey[2] = (x[6] << 24u) | ((x[5] >> 8u) & 0x00FFFFFFu);
    pubkey[3] = (x[5] << 24u) | ((x[4] >> 8u) & 0x00FFFFFFu);
    pubkey[4] = (x[4] << 24u) | ((x[3] >> 8u) & 0x00FFFFFFu);
    pubkey[5] = (x[3] << 24u) | ((x[2] >> 8u) & 0x00FFFFFFu);
    pubkey[6] = (x[2] << 24u) | ((x[1] >> 8u) & 0x00FFFFFFu);
    pubkey[7] = (x[1] << 24u) | ((x[0] >> 8u) & 0x00FFFFFFu);
    pubkey[8] = x[0] << 24u;

    return pubkey;
}

// Create uncompressed pubkey (65 bytes)
fn make_uncompressed_pubkey(x: array<u32, 8>, y: array<u32, 8>) -> array<u32, 17> {
    var pubkey: array<u32, 17>;
    pubkey[0] = 0x04000000u | ((x[7] >> 8u) & 0x00FFFFFFu);
    pubkey[1] = (x[7] << 24u) | ((x[6] >> 8u) & 0x00FFFFFFu);
    pubkey[2] = (x[6] << 24u) | ((x[5] >> 8u) & 0x00FFFFFFu);
    pubkey[3] = (x[5] << 24u) | ((x[4] >> 8u) & 0x00FFFFFFu);
    pubkey[4] = (x[4] << 24u) | ((x[3] >> 8u) & 0x00FFFFFFu);
    pubkey[5] = (x[3] << 24u) | ((x[2] >> 8u) & 0x00FFFFFFu);
    pubkey[6] = (x[2] << 24u) | ((x[1] >> 8u) & 0x00FFFFFFu);
    pubkey[7] = (x[1] << 24u) | ((x[0] >> 8u) & 0x00FFFFFFu);
    pubkey[8] = (x[0] << 24u) | ((y[7] >> 8u) & 0x00FFFFFFu);
    pubkey[9] = (y[7] << 24u) | ((y[6] >> 8u) & 0x00FFFFFFu);
    pubkey[10] = (y[6] << 24u) | ((y[5] >> 8u) & 0x00FFFFFFu);
    pubkey[11] = (y[5] << 24u) | ((y[4] >> 8u) & 0x00FFFFFFu);
    pubkey[12] = (y[4] << 24u) | ((y[3] >> 8u) & 0x00FFFFFFu);
    pubkey[13] = (y[3] << 24u) | ((y[2] >> 8u) & 0x00FFFFFFu);
    pubkey[14] = (y[2] << 24u) | ((y[1] >> 8u) & 0x00FFFFFFu);
    pubkey[15] = (y[1] << 24u) | ((y[0] >> 8u) & 0x00FFFFFFu);
    pubkey[16] = y[0] << 24u;

    return pubkey;
}

// -----------------------------------------------------------------------------
// Convert Jacobian to Affine: (X, Y, Z) -> (X/Z², Y/Z³)
// Requires one modular inverse
// -----------------------------------------------------------------------------

fn jac_to_affine(p: JacobianPoint) -> AffinePoint {
    var result: AffinePoint;

    if (jac_is_infinity(p)) {
        result.x = fe_zero();
        result.y = fe_zero();
        return result;
    }

    // z_inv = 1/Z
    let z_inv = fe_inv(p.z);

    // z_inv2 = z_inv² = 1/Z²
    let z_inv2 = fe_square(z_inv);

    // z_inv3 = z_inv² * z_inv = 1/Z³
    let z_inv3 = fe_mul(z_inv2, z_inv);

    // x = X * z_inv2 = X/Z²
    result.x = fe_mul(p.x, z_inv2);

    // y = Y * z_inv3 = Y/Z³
    result.y = fe_mul(p.y, z_inv3);

    return result;
}

// -----------------------------------------------------------------------------
// Scalar multiplication: R = k * G (generator point)
// Uses double-and-add algorithm with precomputed table
// scalar is little-endian limbs
// -----------------------------------------------------------------------------

fn ec_mul_g(scalar: array<u32, 8>) -> JacobianPoint {
    var result = jac_infinity();

    // Process scalar bit by bit (MSB to LSB)
    // scalar[7] is the most significant word
    for (var word_idx = 0u; word_idx < 8u; word_idx = word_idx + 1u) {
        let word = scalar[7u - word_idx];

        for (var bit_idx = 0u; bit_idx < 32u; bit_idx = bit_idx + 1u) {
            // Double
            if (word_idx > 0u || bit_idx > 0u) {
                result = jac_double(result);
            }

            // Add if bit is set
            let bit = (word >> (31u - bit_idx)) & 1u;
            if (bit == 1u) {
                let g_point = lookup_g_table(1u);
                if (jac_is_infinity(result)) {
                    result.x = g_point[0];
                    result.y = g_point[1];
                    result.z = fe_one();
                } else {
                    result = jac_add_affine(result, g_point[0], g_point[1]);
                }
            }
        }
    }

    return result;
}
