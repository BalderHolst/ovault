import ovault

VAULT_PATH = "./tests/simple_vault"

v = ovault.Vault(VAULT_PATH)

print()
print("path        :", v.path)
print("notes       :", len(v.notes()))
print("attachments :", len(v.attachments()))
print("tags        :", v.tags())

note = v.get_note_by_name("callout")
callout = None
for t in note.tokens():
    if isinstance(t, t.Callout):
        callout = t
print(callout)
for c in callout.contents:
    print(f"\t{c}")

note.insert_after_token(callout.contents[1], "|-|")
