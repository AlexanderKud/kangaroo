//! CPU-side utilities: collision detection and initialization

mod cpu_solver;
mod dp_table;
pub mod init;

pub use cpu_solver::CpuKangarooSolver;
pub use dp_table::DPTable;
