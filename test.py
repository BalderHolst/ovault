import pyvault

VAULT_PATH = "/home/balder/Documents/uni/noter/"

v = pyvault.Vault(VAULT_PATH)

print()
print("path        :", v.path)
print("notes       :", len(v.notes()))
print("attachments :", len(v.attachments()))
print("tags        :", v.tags())

print("\n" + "-"*30)
print(v.get_notes_with_tag("include"))

print("\n" + "-"*30)
note = v.get_note_by_name("the c++ preprocessor")
for t in note.tokens:
    print(t)

