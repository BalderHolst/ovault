# Example 1: Print an overview of the vault

import ovault
import os

VAULT_PATH = os.environ.get("VAULT_PATH", None)
if not VAULT_PATH:
    raise ValueError("Please set the VAULT_PATH environment variable to your vault path.")

v = ovault.Vault(VAULT_PATH)

print()
print("path        :", v.path)
print("notes       :", len(v.notes()))
print("attachments :", len(v.attachments()))
print("tags        :", v.tags())
