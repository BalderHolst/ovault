# Example 3: Find all headings in the "Start Here" note in the Obsidian Sandbox vault

import ovault

# Open the sandbox vault
vault = ovault.Vault("./test_vaults/Obsidian Sandbox/")

# Find a note by name
note = vault.get_note_by_name("Start Here")

# Get all tokens in the note
tokens = note.tokens()

# Iterate through tokens and print headings
for token in tokens:
    if isinstance(token, token.Header):
        print(f"Found heading: {token.heading} at level {token.level}")
