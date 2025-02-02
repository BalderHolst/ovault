import ovault

VAULT_PATH = "./tests/simple_vault"

v = ovault.Vault(VAULT_PATH)

print()
print("path        :", v.path)
print("notes       :", len(v.notes()))
print("attachments :", len(v.attachments()))
print("tags        :", v.tags())

print("\nNotes:")
for note in v.notes():
    print(f"\t{note.name}")

print("\nAttachments:")
for attachment in v.attachments():
    print(f"\t{attachment.path}")

