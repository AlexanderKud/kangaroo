//! Test fixtures: Known Bitcoin puzzles for regression testing
//!
//! Puzzles 20-25 (20-25 bit range) - fast enough for CI, large enough for meaningful tests

/// Test case with known solution and full verification data
#[derive(Debug, Clone)]
pub struct PuzzleTestCase {
    pub puzzle_number: u32,
    pub pubkey: &'static str,
    pub start: &'static str,
    pub range_bits: u32,
    pub expected_key: &'static str,
    pub expected_hash160: &'static str,
    pub expected_address: &'static str,
}

/// Get all test puzzles (20-25 bit range)
pub fn get_test_puzzles() -> Vec<PuzzleTestCase> {
    vec![
        // Puzzle 20: 20-bit range (0x80000 - 0xFFFFF)
        PuzzleTestCase {
            puzzle_number: 20,
            pubkey: "033c4a45cbd643ff97d77f41ea37e843648d50fd894b864b0d52febc62f6454f7c",
            start: "0x80000",
            range_bits: 20,
            expected_key: "d2c55",
            expected_hash160: "b907c3a2a3b27789dfb509b730dd47703c272868",
            expected_address: "1HsMJxNiV7TLxmoF6uJNkydxPFDog4NQum",
        },
        // Puzzle 21: 21-bit range (0x100000 - 0x1FFFFF)
        PuzzleTestCase {
            puzzle_number: 21,
            pubkey: "031a746c78f72754e0be046186df8a20cdce5c79b2eda76013c647af08d306e49e",
            start: "0x100000",
            range_bits: 21,
            expected_key: "1ba534",
            expected_hash160: "29a78213caa9eea824acf08022ab9dfc83414f56",
            expected_address: "14oFNXucftsHiUMY8uctg6N487riuyXs4h",
        },
        // Puzzle 22: 22-bit range (0x200000 - 0x3FFFFF)
        PuzzleTestCase {
            puzzle_number: 22,
            pubkey: "023ed96b524db5ff4fe007ce730366052b7c511dc566227d929070b9ce917abb43",
            start: "0x200000",
            range_bits: 22,
            expected_key: "2de40f",
            expected_hash160: "7ff45303774ef7a52fffd8011981034b258cb86b",
            expected_address: "1CfZWK1QTQE3eS9qn61dQjV89KDjZzfNcv",
        },
        // Puzzle 23: 23-bit range (0x400000 - 0x7FFFFF)
        PuzzleTestCase {
            puzzle_number: 23,
            pubkey: "03f82710361b8b81bdedb16994f30c80db522450a93e8e87eeb07f7903cf28d04b",
            start: "0x400000",
            range_bits: 23,
            expected_key: "556e52",
            expected_hash160: "d0a79df189fe1ad5c306cc70497b358415da579e",
            expected_address: "1L2GM8eE7mJWLdo3HZS6su1832NX2txaac",
        },
        // Puzzle 24: 24-bit range (0x800000 - 0xFFFFFF)
        PuzzleTestCase {
            puzzle_number: 24,
            pubkey: "036ea839d22847ee1dce3bfc5b11f6cf785b0682db58c35b63d1342eb221c3490c",
            start: "0x800000",
            range_bits: 24,
            expected_key: "dc2a04",
            expected_hash160: "0959e80121f36aea13b3bad361c15dac26189e2f",
            expected_address: "1rSnXMr63jdCuegJFuidJqWxUPV7AtUf7",
        },
        // Puzzle 25: 25-bit range (0x1000000 - 0x1FFFFFF)
        PuzzleTestCase {
            puzzle_number: 25,
            pubkey: "03057fbea3a2623382628dde556b2a0698e32428d3cd225f3bd034dca82dd7455a",
            start: "0x1000000",
            range_bits: 25,
            expected_key: "1fa5ee5",
            expected_hash160: "2f396b29b27324300d0c59b17c3abc1835bd3dbb",
            expected_address: "15JhYXn6Mx3oF4Y7PcTAv2wVVAuCFFQNiP",
        },
    ]
}

/// Get a quick smoke test puzzle (smallest, fastest)
pub fn get_smoke_test_puzzle() -> PuzzleTestCase {
    PuzzleTestCase {
        puzzle_number: 20,
        pubkey: "033c4a45cbd643ff97d77f41ea37e843648d50fd894b864b0d52febc62f6454f7c",
        start: "0x80000",
        range_bits: 20,
        expected_key: "d2c55",
        expected_hash160: "b907c3a2a3b27789dfb509b730dd47703c272868",
        expected_address: "1HsMJxNiV7TLxmoF6uJNkydxPFDog4NQum",
    }
}
