import ovault

VAULT_PATH = "./tests/simple_vault"

v = ovault.Vault(VAULT_PATH)

v.index()

print()
print("path        :", v.path)
print("notes       :", len(v.notes()))
print("attachments :", len(v.attachments()))
print("tags        :", v.tags())

print("\n" + "-"*30)
print(v.get_notes_by_tag("linksaregood"))

