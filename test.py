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

note = v.get_note_by_name("code")

token = None
for t in note.tokens():
    if isinstance(t, t.Code):
        if t.lang == "python":
            token = t

print(token)
for i in range(10):
    note.insert_after_token(token, "\nhello there " + str(i) + "!!")
