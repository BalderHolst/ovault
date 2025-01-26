import ovault

VAULT_PATH = "/home/balder/Documents/uni/noter/"

v = ovault.Vault(VAULT_PATH)

print()
print("path        :", v.path)
print("notes       :", len(v.notes()))
print("attachments :", len(v.attachments()))
print("tags        :", v.tags())

print("\n" + "-"*30)
print(v.get_notes_by_tag("c"))

print("\n" + "-"*30)

for subject in v.get_notes_by_tag("subject"):
    print(subject.name)
