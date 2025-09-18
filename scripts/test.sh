#!/usr/bin/env bash

set -e

ROOT=$(git rev-parse --show-toplevel)

cd "$ROOT"

# Pull submodules
git submodule update --init --recursive

# Test all feature combinations
cargo test --release --all-features

# Run python tests
maturin develop --release --features python
pytest tests

# Check all feature combinations
cargo hack check --feature-powerset

# Check Build
cargo build --all-features
