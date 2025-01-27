import ovault

VAULT_PATH = "./tests/simple_vault"

v = ovault.Vault(VAULT_PATH)

print()
print("path        :", v.path)
print("notes       :", len(v.notes()))
print("attachments :", len(v.attachments()))
print("tags        :", v.tags())

note = v.get_note_by_name("quote")
quote = None
for t in note.tokens():
    if isinstance(t, t.Quote):
        quote = t

print(quote)
for c in quote.contents:
    print(f"\t{c}")

note.insert_after_token(quote.contents[1], "|-|", offset=-1)
