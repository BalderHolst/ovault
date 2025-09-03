# Example 1: Print an overview of the vault

# Usage: `python3 examples/1_overview.py <vault>`

import ovault
import sys
import os

if len(sys.argv) != 2:
    print(f"Usage: python3 {sys.argv[0]} <vault>")
    exit(1)

vault = ovault.Vault(sys.argv[1])

print()
print("path        :", os.path.relpath(vault.path, os.getcwd()))
print("notes       :", len(vault.notes()))
print("attachments :", len(vault.attachments()))
print("tags        :", vault.tags())
