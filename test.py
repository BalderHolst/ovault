import ovault

VAULT_PATH = "./tests/simple_vault"

v = ovault.Vault(VAULT_PATH)

print()
print("path        :", v.path)
print("notes       :", len(v.notes()))
print("attachments :", len(v.attachments()))
print("tags        :", v.tags())

n1 = v.get_note_by_name("frontmatter")
n1.insert_at(-1, "\nLink to [[first_note]]!")

v.index()

print("\n" + "-"*50)
for note in v.notes():
    print(note.name)
    for link in note.links:
        print(f"> {link}")
