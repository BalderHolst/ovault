import pyvault

VAULT_PATH = "/home/balder/Documents/uni/noter/"

v = pyvault.Vault(VAULT_PATH)

print("Vault path: ", v.path)
print("Vault files: ", len(v.notes()))
