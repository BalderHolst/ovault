# Example 5: Generates `dot` code for a connection graph of of the vault

# Usage: `python3 examples/5_graph_image.py <vault> | neato -Tpng > graph.png`

# NOTE: Sorting is only done to make the output stable for testing purposes.

import ovault
import sys

if len(sys.argv) != 2:
    print(f"Usage: python3 {sys.argv[0]} <vault>")
    exit(1)

vault = ovault.Vault(sys.argv[1])

print("digraph {")
print("    overlap=false;")
print('    node [shape=box, style=filled, fillcolor="#0099FF25"];')
print('    edge [color="#00000090"];')
print()

notes = [
    (note.normalized_name(), note, f"{i}{note.normalized_name()}")
    for i, note in enumerate(sorted(vault.notes()))
]

map = {k: v for k, _, v in notes}

for name, note, node in notes:
    print(f'    "{node}" [label="{name}"]')

print()

for _, note, node in notes:
    for link in sorted(note.links):
        link = link.replace("\\", "")
        if link not in map:
            continue
        link_node = map[link]

        print(f'    "{node}" -> "{link_node}"')

print("}")
