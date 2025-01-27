import ovault

VAULT_PATH = "./tests/simple_vault"

v = ovault.Vault(VAULT_PATH)

v.index()

print()
print("path        :", v.path)
print("notes       :", len(v.notes()))
print("attachments :", len(v.attachments()))
print("tags        :", v.tags())

note = v.get_note_by_name("code")

print("\n" + "-"*30)
print(note.read(), end="")
print("\n" + "-"*30)

note.insert_at(-1, "\nThis is THE END!")

print("\n" + "-"*30)
print(note.read(), end="")
print("\n" + "-"*30)
