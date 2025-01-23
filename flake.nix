{
    description = "pyvault project flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/24.05";
        flake-utils.url = "github:numtide/flake-utils";
    };

    outputs = { nixpkgs, flake-utils, ... }:
        flake-utils.lib.eachDefaultSystem (system:
            let
                pkgs = nixpkgs.legacyPackages.${system};
            in
            {
                devShell = pkgs.mkShell {
                    buildInputs = with pkgs; [
                        cargo
                        maturin
                    ];
                };
            }
    );
}
