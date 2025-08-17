# Example 2: Print all files with a specific tag

import ovault
import sys

if len(sys.argv) != 3:
    print(f"Usage: python3 {sys.argv[0]} <vault> <tag>")
    exit(1)

vault = ovault.Vault(sys.argv[1])

tag = sys.argv[2]

print(f"\nSearching for notes with tag: {tag}")
notes = vault.get_notes_by_tag(tag)
if len(notes) == 0:
    print(f"No notes found with tag '{tag}'.")
else:
    for note in notes:
        print(f"    {note.name} ({note.length} characters)")
