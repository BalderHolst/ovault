# Example 4: Check that all external links in the vault are valid

# Usage: python 4_check_external_links.py <vault_path>

# NOTE: This example requires the `requests` package to be installed.

import ovault
import sys
import requests

if len(sys.argv) != 2:
    print("Usage: python 4_check_external_links.py <vault_path>")
    sys.exit(1)

vault = ovault.Vault(sys.argv[1])

# Terninal Colors
GREEN  = "\033[92m"
YELLOW = "\033[93m"
RED    = "\033[91m"
RESET  = "\033[0m"

broken_links = []

for note in vault.notes():
    for token in note.tokens():
        if not isinstance(token, token.ExternalLink): continue
        url = token.link.url
        print(f"[note: {note.name}] Checking '{url}'...", end=' ', flush=True)

        if not url.startswith("http"):
            print(f"{YELLOW}SKIPPED{RESET}")
            continue

        try:
            resp = requests.get(url, timeout=5)
        except requests.RequestException as e:
            print(f"{RED}INVALID URL{RESET} ({e})")
            continue
        if resp.status_code == 200:
            print(f"{GREEN}OK{RESET}")
        else:
            broken_links.append((note.name, url, resp.status_code))
            print(f"{RED}FAILED{RESET} ({resp.status_code})")


if not broken_links:
    print("All external links are valid!")
    exit(0)

print(f"\nBroken links found:")
for note_name, url, status in broken_links:
    print(f"- {note_name}: {url} (status code: {status})")
