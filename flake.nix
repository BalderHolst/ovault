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
                        (rust-bin.stable.latest.default.override {
                            extensions = [ "rust-src" "clippy"];
                        })
                        maturin
                        python3
                    ];

                    shellHook = ''
                        # Create venv if it doesn't exist
                        if [ ! -d venv ]; then
                            python3 -m venv venv
                        fi

                        # Activate venv
                        source venv/bin/activate

                        pip install pdoc3

                        # Install ovault in editable mode
                        maturin develop --features python
                    '';
                };
            }
    );
}
