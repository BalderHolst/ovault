# Example 5: Generate an Obsidian Vault

# This script generates an obsidian vault containing manual entries
# for common GNU/Linux utilities

# NOTE: This will only work on GNU/Linux systems with the `man` command available.

# Usage: python 5_create_vault.py <vault_name>

import ovault
import subprocess
import sys

# List of common GNU/Linux utilities to include in the vault
UTILS = [
    "ls", "pwd", "mkdir", "rm", "cp", "mv", "touch", "grep", "cat",
    "more", "less", "chmod", "ps", "top", "free", "df", "du", "uname",
    "sudo", "su", "passwd", "id", "ping", "ssh", "wget", "curl", "kill",
    "tar", "gzip", "zip", "mount", "nano", "echo", "clear", "man",
    "reboot", "date"
]

# Sort utilities for consistent order
UTILS.sort()

# Get the manual page for a utility using the `man` command
def manual(util: str) -> str:
    res = subprocess.run(["man", util], capture_output=True, text=True);
    if res.returncode != 0:
        print(f"Command `{util}` does not have a manual entry")
        exit(1)
    return res.stdout

# Extract the description from the manual page.
# The description is usually the first line after the "NAME" section.
def extract_desc(man: str) -> str:
    lines = man.split("\n")
    desc = ""
    for i, line in enumerate(lines):
        if not line.startswith("NAME"): continue
        desc_line = lines[i + 1].strip()
        if " - " in desc_line:
            desc = desc_line.split(" - ")[-1] 
            break
        else:
            desc = desc_line
            break

    if not desc:
        print("Could not extract description from manual page")
        exit(1)

    return desc.strip().capitalize() + "."

# Generate the index page for the vault
def index_page(descs: dict[str, str]) -> str:
    index_content  = "# GNU/Linux Utilities Vault\n\n"
    index_content += "This vault contains manual entries for common GNU/Linux utilities.\n\n"
    index_content += "## Utilities\n\n"

    # Fill in the index with utility names and their descriptions
    for util in UTILS:
        index_content += f"- **[[utils/{util}|{util}]]**: {descs[util]}\n"

    return index_content

if __name__ == "__main__":

    if len(sys.argv) != 2:
        print(f"Usage: python {sys.argv[0]} <vault_name>")
        exit(1)

    vault_path = sys.argv[1]

    # Open the vault, creating it if it doesn't exist
    vault = ovault.Vault(vault_path, create=True)

    print("Getting manual pages for utilities...")
    pages = {}
    for util in UTILS:
        print(f"    Getting '{util}'")
        pages[util] = manual(util)

    print("Extracting descriptions from manual pages...")
    descs = {util: extract_desc(pages[util]) for util in UTILS}

    print("Creating notes...")
    for util in UTILS:
        path = f"utils/{util}.md"
        content = f"{descs[util]}\n\n```text\n{pages[util]}\n```"
        vault.add_note(path, content)

    vault.add_note("Overview.md", index_page(descs))

    print("Re-indexing vault...")
    vault.index()

    print(f"\nVault created successfully at '{vault_path}' with {len(vault.notes())} notes!")
