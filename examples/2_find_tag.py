# Example 2: Print all files with a specific tag

import ovault
import os
import sys

VAULT_PATH = os.environ.get("VAULT_PATH", None)
if not VAULT_PATH:
    print("Please set the VAULT_PATH environment variable to your vault path.")
    exit(1)

if len(sys.argv) < 2:
    print(f"Usage: python3 {sys.argv[0]} <tag>")
    exit(1)

tag = sys.argv[1]

v = ovault.Vault(VAULT_PATH)

print(f"\nSearching for notes with tag: {tag}")
notes = v.get_notes_by_tag(tag)
if len(notes) == 0:
    print(f"No notes found with tag '{tag}'.")
else:
    for note in notes:
        print(f"    {note.name} ({note.length} characters)")
