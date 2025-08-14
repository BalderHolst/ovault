# Example 4: Generates `dot` code for a connection graph of of the vault

# Usage:
# 1. Set the `VAULT_PATH` environment variable to your vault path.
# 2. Run the command: `python3 examples/4_graph_image.py | neato -Tpng > graph.png`

import ovault
import os

VAULT_PATH = os.environ.get("VAULT_PATH", None)
if not VAULT_PATH:
    print("Please set the VAULT_PATH environment variable to your vault path.")
    exit(1)

v = ovault.Vault(VAULT_PATH)

notes = v.notes()

print("digraph {")
print("    overlap=false;")
print('    node [shape=box, style=filled, fillcolor="#0099FF25"];')
print('    edge [color="#00000090"];')

for note in notes:
    print(f'    "{note.normalized_name()}" [label="{note.name}"]')

for note in notes:
    for link in note.links:
        link = link.replace("\\", "")
        print(f'    "{note.normalized_name()}" -> "{link}"')

print("}")
