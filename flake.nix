{
    description = "ovault project flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/25.05";
        flake-utils.url = "github:numtide/flake-utils";
        rust-overlay.url = "github:oxalica/rust-overlay";
    };

    outputs = { nixpkgs, flake-utils, ... }@inputs:
        flake-utils.lib.eachDefaultSystem (system:
            let
                pkgs = import nixpkgs {
                    inherit system;
                    overlays = [
                        inputs.rust-overlay.overlays.default
                    ];
                };
            in
            {
                devShell = pkgs.mkShell {
                    buildInputs = with pkgs; [
                        # Rust toolchain with extra components for development
                        (rust-bin.stable.latest.default.override {
                            extensions = [ "rust-src" "clippy" "rust-analyzer"];
                        })
                        cargo-hack      # run commands with all combinations of features
                        cargo-tarpaulin # code coverage reports
                        python3         # python interpreter
                    ];

                    shellHook = ''
                        # Set up git hooks
                        git config core.hooksPath .hooks

                        # Create venv if it doesn't exist
                        if [ ! -d venv ]; then
                            python3 -m venv venv
                        fi

                        # Activate venv
                        source venv/bin/activate

                        pip install -e ".[dev,util_deps]"
                    '';
                };
            }
    );
}
