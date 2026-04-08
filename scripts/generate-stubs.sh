#!/usr/bin/env bash

ROOT=$(git rev-parse --show-toplevel)

DYLIB_PATH="$ROOT/target/release/libovault.so"
STUB_PATH="$ROOT/ovault.pyi"

[[ -e "$DYLIB_PATH" ]] || {
    echo "ERROR: '$DYLIB_PATH' does not exist"
    exit 1
}

cargo run -q --manifest-path "$ROOT/stub-gen/Cargo.toml" -- "$DYLIB_PATH" | tee > "$STUB_PATH"
