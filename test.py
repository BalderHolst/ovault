import ovault

v = ovault.Vault("./test-vaults/simple_vault")

note = v.note("tables")

tokens = note.tokens()

table = tokens[2]

print(table)
print()

print(ovault.to_markdown(table))
