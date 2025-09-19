# Example 6: Rename a note in an Obsidian vault

# Usage: python 6_rename_note.py <vault_name> <old_note_path> <new_note_path>

import ovault
import sys

if len(sys.argv) != 4:
    print("Usage: python 6_rename_note.py <vault_name> <old_note_name> <new_note_name>")
    sys.exit(1)

vault = ovault.Vault(sys.argv[1])

old_note_name = sys.argv[2]
new_note_name = sys.argv[3]

note = vault.rename_note(old_note_name, new_note_name)

print(f"Renamed note from '{old_note_name}' to '{new_note_name}' in vault '{vault.path}'\n")

print("Patched backlinks:")
for backlink in note.backlinks:
    print(f"  - {vault.get_note_by_name(backlink).path}")
