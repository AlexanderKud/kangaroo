pub mod context;
pub mod shaders;

pub use context::GpuContext;
use bytemuck::{Pod, Zeroable};

/// GPU Affine Point (x, y coordinates in 32-bit limbs)
#[repr(C)]
#[derive(Clone, Copy, Debug, Pod, Zeroable)]
pub struct GpuAffinePoint {
    pub x: [u32; 8],
    pub y: [u32; 8],
}