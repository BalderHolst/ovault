#!/usr/bin/env python3

import subprocess
import os

ROOT_MARKER = "flake.nix"
def find_root(dir=None):
    if dir is None: dir = os.getcwd()
    while True:
        if os.path.isfile(os.path.join(dir, ROOT_MARKER)):
            return dir
        parent = os.path.dirname(dir)
        if parent == dir:
            raise FileNotFoundError(f"Could not find {ROOT_MARKER} in any parent directory")
        dir = parent

def main():
    root = find_root()

    for vault in os.listdir(os.path.join(root, "test-vaults")):
        vault_path = os.path.join(root, "test-vaults", vault)
        if not os.path.isdir(vault_path): continue

        print(f"Restoring test vault: '{vault}'...")
        subprocess.run(["git", "clean", "-xdf"], cwd=vault_path, check=True)
        subprocess.run(["git", "restore", "."], cwd=vault_path, check=True)

    print("DONE!")

if __name__ == "__main__":
    main()

