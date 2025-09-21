"""
Visualize your Obsidian vault graph using pyvis.
"""

__util__ = True

import ovault

import argparse
import sys
import os
from pathlib import Path

from types import ModuleType as Module

def main():
    ovault._import_extra("pyvis")
    from pyvis.network import Network

    def populate_graph(net: Network, vault: ovault.Vault):
        for note in vault.notes():
            size = len(note.links) + len(note.backlinks) + 5,
            net.add_node(str(note.path),
                         size=size,
                         label=note.name,
                         title=str(note.path))

        for attachment in vault.attachments():
            size = len(note.backlinks) + 3,
            net.add_node(str(attachment.path),
                         size=size,
                         label=Path(attachment.path).name,
                         title=str(attachment.path),
                         color="#7a7a77")

        for note in vault.notes():
            for link in note.links:
                linked = vault.note(link)
                if not linked: linked = vault.attachment(link)
                if not linked: continue

                net.add_edge(str(note.path), str(linked.path))


    parser = argparse.ArgumentParser(description=sys.modules[__name__].__doc__)
    parser.add_argument("vault", type=str, help="Path to your Obsidian vault")
    parser.add_argument("--output", "-o", type=str, help="Output HTML file", default="graph")
    parser.add_argument("--buttons", "-b", default=False, action="store_true", help="Show physics buttons")

    args = parser.parse_args()

    vault = ovault.Vault(args.vault)

    net = Network(directed=True, height = "100vh", width="100vw", bgcolor="#222222", font_color="white")
    net.barnes_hut(
        gravity=-30000,
        central_gravity=2.0,
        spring_length=95,
        spring_strength=0.10,
        overlap=0.10,
        damping=0.25,
    )
    net.options.physics.stabilization.enabled = True
    net.options.physics.stabilization.iterations = min(len(vault.notes()) * 0.25, 500)

    if args.buttons:
        net.show_buttons(filter_=['physics'])

    populate_graph(net, vault)


    os.makedirs(args.output, exist_ok=True)
    index = f"{args.output}/index.html"
    net.write_html(index, notebook=False)
    print(f"Graph saved to '{index}'.")



if __name__ == "__main__":
    main()

