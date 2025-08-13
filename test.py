import os
import ovault

VAULT_PATH = os.path.expanduser("~/Documents/uni/notes")

v = ovault.Vault(VAULT_PATH)

print()
print("path        :", v.path)
print("notes       :", len(v.notes()))
print("attachments :", len(v.attachments()))
print("tags        :", v.tags())

print("\nNotes:")
for note in v.notes():
    for token in note.tokens():
        if isinstance(token, token.Code):
            print(f"\t{note.name}: {token.lang}")
