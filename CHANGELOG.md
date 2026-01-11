## [0.4.0] - 2026-01-11

### Bug Fixes

- *(provider)* Calculate range_bits from actual bounds

### Refactor

- [**breaking**] Remove Criterion benchmarks in favor of built-in --benchmark
- Change CpuKangarooSolver to accept full 256-bit start value

### Documentation

- Add AGENTS.md and fix README architecture section

### Performance

- Implement parallel batch inversion using Blelloch scan (#21)
## [0.3.0] - 2026-01-10

### Features

- Add --benchmark flag and BENCHMARK.md (#16)
- Add affine batch addition mode (~30% faster) (#18)

### Bug Fixes

- Correct misleading comments about Jacobian vs affine coordinates

### Miscellaneous Tasks

- *(release)* V0.3.0
## [0.2.0] - 2026-01-08

### Features

- Add GPU auto-calibration
- *(provider)* Add data provider system (#5)

### Other

- *(wgpu)* Upgrade to v28

### Refactor

- Move GPU solver to dedicated module

### Documentation

- Add AUR installation instructions

### Miscellaneous Tasks

- Remove unused shaders
- Add AUR packaging and CI workflow
- Add `deepwiki` badge
- Add `context7.json`
- Add crates.io publish workflow (#7)
- Add autofix.ci workflow for auto-formatting (#10)
- Add build and clippy workflow (#12)
- Add justfile (#14)
- *(release)* V0.2.0
## [0.1.0] - 2025-12-12

### Features

- Initial release
