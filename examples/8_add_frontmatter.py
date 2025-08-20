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

    tags = ['added-tag', 'this-is-a-frontmatter-tag']

    note_dir = note_file.parent
    if note_dir != vault.path:
        print(f"Adding frontmatter to '{note.name}' in directory '{note_dir.name}'")
        tags = frontmatter['tags']
        print(f"Current tags: {tags}")
        tags.append(note_dir.name)
        print(f"Updated tags: {tags}")
        print(f"Frontmatter tags: {frontmatter['tags']}")

    frontmatter = ovault.Frontmatter()
    frontmatter['tags'] = tags
    frontmatter['created'] = note_file.stat().st_ctime

    note.set_frontmatter(frontmatter)

