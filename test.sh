#!/usr/bin/env bash

set -e

# Pull submodules
git submodule update --init --recursive

# Build all feature combinations
cargo hack build --feature-powerset

# Test all feature combinations
cargo hack test --release --feature-powerset

# Run python tests
maturin develop --release --features python
pytest tests
