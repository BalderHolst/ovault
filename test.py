import pyvault

VAULT_PATH = "/home/balder/Documents/uni/noter/"

v = pyvault.Vault(VAULT_PATH)

print("path:\t", v.path)
print("files:\t", len(v.items()))
print("notes:\t", len(v.notes()))
print("attach:\t", len(v.attachments()))
