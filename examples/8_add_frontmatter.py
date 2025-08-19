# Example 8: Add frontmatter to all notes that don't have it

# Usage: python 8_add_frontmatter.py <vault_name>

import ovault
import sys
from pathlib import Path

if len(sys.argv) != 2:
    print("Usage: python 8_add_frontmatter.py <vault_name>")
    sys.exit(1)

vault = ovault.Vault(sys.argv[1])

for note in vault.notes():
    if note.frontmatter() is not None:
        print(f"'{note.name}' already has frontmatter, skipping.")
        continue

    note_file = Path(note.full_path())

    frontmatter = ovault.Frontmatter()
    frontmatter['tags'] = ['added-tag', 'this-is-a-frontmatter-tag']
    frontmatter['created'] = note_file.stat().st_ctime

    note_dir = note_file.parent
    if note_dir != vault.path:
        frontmatter['tags'].append(note_dir.name)

    note.set_frontmatter(frontmatter)

