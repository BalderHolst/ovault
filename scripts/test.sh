#!/usr/bin/env bash

set -e

ROOT=$(git rev-parse --show-toplevel)

cd "$ROOT"

# Pull submodules
git submodule update --init --recursive

# Build all feature combinations
cargo build --all-features

# Test all feature combinations
cargo test --release --all-features

# Run python tests
maturin develop --release --features python
pytest tests
