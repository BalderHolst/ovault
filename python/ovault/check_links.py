from . import ovault
import sys
import os
import requests

def main():
    if len(sys.argv) != 2:
        submod_name = os.path.basename(__file__.rstrip(".py"))
        print(f"Usage: python -m {__package__}.{submod_name} <vault_path>")
        sys.exit(1)

    vault = ovault.Vault(sys.argv[1])

    # Set the user agent to mimic a real browser
    HEADERS = {'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64; rv:138.0) Gecko/20100101 Firefox/138.0'}

    # Terninal Colors
    GREEN  = "\033[92m"
    YELLOW = "\033[93m"
    RED    = "\033[91m"
    BLUE   = "\033[94m"
    RESET  = "\033[0m"

    broken_links = []

    notes = vault.notes()

    # Prints centered text in terminal width using '=' characters
    def label(msg, color=None):
        if color: print(color, end="")
        cols = os.get_terminal_size().columns
        left_pad = (cols - len(msg)) // 2 - 1
        right_pad = (cols - len(msg)) - left_pad - 2
        print(f"\n{'=' * left_pad} {msg} {'=' * right_pad}{RESET}")
        if color: print(RESET, end="")

    for note in notes:

        note_links = [token.link for token in note.tokens() if isinstance(token, token.ExternalLink)]

        if len(note_links) == 0: continue

        label(f"{note.name} ({str(note.path)})", color=BLUE)

        for link in note_links:
            url = link.url

            print(f"    Checking '{url}'...", end=' ', flush=True)

            if not url.startswith("http"):
                print(f"{YELLOW}SKIPPED{RESET}")
                continue

            try:
                resp = requests.get(url, headers=HEADERS, timeout=5)
            except requests.RequestException as e:
                print(f"{RED}INVALID URL{RESET} ({e})")
                continue
            if resp.status_code == 200:
                print(f"{GREEN}OK{RESET}")
            else:
                broken_links.append((note.name, url, resp.status_code))
                print(f"{RED}FAILED{RESET} ({resp.status_code})")


    if not broken_links:
        print(f"{GREEN}All external links are valid!{RESET}")
        exit(0)

    print(RED, end="")
    label(f"Broken links found", color=RED)
    for note_name, url, status in broken_links:
        print(f"- {note_name}: {url} (status code: {status})")
    print(RESET, end="")

    exit(1)


if __name__ == "__main__":
    main()
