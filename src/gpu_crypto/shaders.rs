pub const FIELD_WGSL: &str = include_str!("shaders/field.wgsl");
pub const CURVE_JACOBIAN_WGSL: &str = include_str!("shaders/curve_jacobian.wgsl");
pub const TABLES_WGSL: &str = include_str!("shaders/tables.wgsl");
pub const SHA256_WGSL: &str = include_str!("shaders/sha256.wgsl");
pub const RIPEMD160_WGSL: &str = include_str!("shaders/ripemd160.wgsl");

pub fn get_combined_source() -> String {
    // Order matters! Dependencies must come first:
    // 1. field.wgsl - primitive field operations (fe_*, constants)
    // 2. curve_jacobian.wgsl - basic EC operations (JacobianPoint, jac_double, jac_add_affine, AffinePoint)
    // 3. tables.wgsl - lookup tables + ec_mul_g + jac_to_affine (uses curve primitives)
    // 4. sha256.wgsl - hash functions
    // 5. ripemd160.wgsl - hash functions (uses sha256)
    format!(
        "{}

{}

{}

{}

{}",
        FIELD_WGSL,
        CURVE_JACOBIAN_WGSL,
        TABLES_WGSL,
        SHA256_WGSL,
        RIPEMD160_WGSL
    )
}
