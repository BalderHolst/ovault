# Example 5: Generates `dot` code for a connection graph of of the vault

# Usage: `python3 examples/5_graph_image.py <vault> | neato -Tpng > graph.png`

import ovault
import sys

if len(sys.argv) != 2:
    print(f"Usage: python3 {sys.argv[0]} <vault>")
    exit(1)

vault = ovault.Vault(sys.argv[1])

notes = vault.notes()

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
