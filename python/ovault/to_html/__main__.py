"""
Convert an obsidian vault to a simple static HTML site.
"""

__util__ = True

import argparse
import sys
import os
from pathlib import Path

import ovault

import ovault.to_html.html as html

with open(os.path.dirname(__file__) + "/style.css", 'r') as f:
    CSS = f.readlines()

def vault_path_to_site_path(note_path: str, site_dir: str = "") -> str:
    note_path = Path(note_path)

    if note_path.suffix == ".md":
        note_path = Path(note_path).with_suffix(".html")

    if site_dir == "": return note_path
    return os.path.join(site_dir, note_path)

def token_to_html(vault: ovault.Vault, w: html.HtmlWriter, token: ovault.Token) -> str:
    match token:
        case token.Frontmatter():
            pass

        case token.Text():
            for line in token.text.splitlines():
                w.write_line(line)

        case token.Tag():
            w.write_line(f'<span class="tag">#{token.tag}</span>')

        case token.InternalLink():
            link = token.link

            if link.render:
                print("WARNING: InternalLink with render=True not implemented yet.")

            if link.position: raise NotImplementedError("InternalLink with position")
            if link.options: raise NotImplementedError("InternalLink with option")

            dest = None

            dest_note = vault.note(link.dest)
            if dest_note: dest = dest_note.path

            dest_attachment = vault.attachment(link.dest)
            if dest_attachment: dest = dest_attachment.path

            if dest is None:
                print(f"WARNING: Internal link to '{link.dest}' not found in vault.")
                dest = link.dest
            else:
                dest = vault_path_to_site_path(dest)

            text = Path(dest).with_suffix("").name
            if link.show_how: text = link.show_how

            w.write_line(html.a(dest, text))

        case token.ExternalLink():
            link = token.link

            if link.render: print("WARNING: ExternalLink with render=True not implemented yet.")
            if link.position: raise NotImplementedError("ExternalLink with position")
            if link.options: raise NotImplementedError("ExternalLink with option")

            w.write_line(html.a(link.url, link.show_how))

        case token.Header():
            w.write_line(html.h(token.level, token.heading))

        case token.List():

            w.write_line('<ul>', indent=True)
            for item in token.items:
                assert(item.indent == 0)  # TODO: Implement nested lists
                w.write_line('<li>', indent=True)
                tokens_to_html(vault, w, item.tokens)
                w.write_line('</li>', dedent=True)

            w.write_line('</ul>', dedent=True)

        case token.CheckList():
            w.write_line('<div class="checklist">', indent=True)
            for item in token.items:
                assert(item.indent == 0)  # TODO: Implement nested lists

                extra = '';
                if item.checked: extra = 'checked'
                w.write_line(f'<input type="checkbox" onclick="return false;" {extra}>');

                w.write_line('<label>', indent=True)
                tokens_to_html(vault, w, item.tokens)
                w.write_line('</label><br>', dedent=True)

            w.write_line('</div>', dedent=True)

        case token.Callout():
            clases = ["callout", f'callout-kind-{token.callout.kind}']

            if token.callout.foldable: clases.append("foldable")

            w.write_line(f'<details class="{' '.join(clases)}">', indent=True)
            w.write_line(f'<summary class="callout-title">{token.callout.title}</summary>')

            w.write_line('<div class="callout-content">', indent=True)
            tokens_to_html(vault, w, token.callout.tokens)
            w.write_line('</div>', dedent=True)

            w.write_line('</details>', dedent=True)

        case token.Quote():
            w.write_line('<blockquote>', indent=True)
            tokens_to_html(vault, w, token.tokens)
            w.write_line('</blockquote>', dedent=True)

        case token.Code():
            w.write_line('<pre><code>')
            w.indent()
            for line in token.code.splitlines():
                w.write_line(line)
            w.dedent()
            w.write_line('</code></pre>')

        case token.Divider():
            w.write_line('<hr>')

        case other:
            raise NotImplementedError(f"Unknown token type: {type(other)}")

def tokens_to_html(vault: ovault.Vault, w: html.HtmlWriter, tokens: list[ovault.Token]) -> None:
    for token in tokens:
        token_to_html(vault, w, token)

def html_head(w: html.HtmlWriter, title: str) -> None:
    w.write_line("<head>", indent=True)
    w.write_line('<meta charset="UTF-8">')
    w.write_line(f"<title>{title.title()}</title>")

    w.write_line('<style>', indent=True);
    for line in CSS: w.write_line(line)
    w.write_line('</style>', dedent=True);


    w.write_line("</head>", dedent=True)

def convert_note_to_html(vault: ovault.Vault, note: ovault.Note, site_dir: str, filename_title=False) -> str:
    output_path = vault_path_to_site_path(note.path, site_dir)

    w = html.HtmlWriter()
    w.write_line("<!DOCTYPE html>")
    w.write_line("<html>", indent=True)

    html_head(w, note.name)

    w.write_line("<body>", indent=True)

    if filename_title: w.write_line(f"<h1>{note.name}</h1>")

    tokens_to_html(vault, w, note.tokens())

    w.write_line("</body>", dedent=True)

    w.write_line("</html>", dedent=True)

    w.save_to_file(output_path)



def convert_vault_to_html(vault_path: str, site_dir: str) -> None:
    print(f"Converting vault at '{vault_path}' to HTML site in '{site_dir}'...")

    os.makedirs(site_dir, exist_ok=True)

    if not os.path.isdir(vault_path):
        print(f"ERROR: Vault path '{vault_path}' is not a directory.")
        exit(1)

    # Check that the directory os empty
    if len(os.listdir(site_dir)) > 0:
        print(f"ERROR: Output directory '{site_dir}' is not empty.")
        exit(1)

    vault = ovault.Vault(vault_path)

    for note in sorted(vault.notes()):
        convert_note_to_html(vault, note, site_dir)

    for attachment in vault.attachments():
        dest_path = vault_path_to_site_path(attachment.path, site_dir)
        os.makedirs(os.path.dirname(dest_path), exist_ok=True)

        with open(attachment.full_path(), "rb") as src_file:
            with open(dest_path, "wb") as dest_file:
                dest_file.write(src_file.read())


def main():
    parser = argparse.ArgumentParser(description=sys.modules[__name__].__doc__)

    # Arguments
    parser.add_argument("vault", type=str, help="Path to your Obsidian vault")
    parser.add_argument("--output", "-o", type=str, help="Output directory for the HTML site", default="site")

    args = parser.parse_args()

    convert_vault_to_html(args.vault, args.output)

if __name__ == "__main__":
    main()
