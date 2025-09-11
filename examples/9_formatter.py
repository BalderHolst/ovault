# Example 9: Standardize note formatting

# Usage: python 9_formatter.py [--vault] <path>

# Supply a markdown file with the `<path>` argument.
# If `--vault` is provided, `<path>` is treated as a vault path.
# If `--tokens` is provided, the note tokens will be printed.

# NOTE: Sorting is only done to make the output stable for testing purposes.

import ovault
import sys
import os

PROGRAM = os.path.basename(__file__)

def usage(error: str = None):
    if error:
        print(f"ERROR: {error}")
        print()
    print(f"Usage: python {PROGRAM} [--tokens] [--vault] <path>")
    print()
    print("Supply a markdown file with the <path> argument.")
    print("If --vault is provided, <path> is treated as a vault path.")
    print("If --tokens is provided, the note tokens will be printed.")

    exit(1)

# Format a file by reading its content, parsing it into tokens,
# and converting the tokens back to markdown using the `ovault.to_markdown` function,
# which formats the tokens back into markdown text.
#
# To create a custom formatter, change out the `ovault.to_markdown` function
# for your own implementation.
def format_note(note: str, print_tokens: bool = False):
    print(f"Formatting note: {os.path.relpath(note, os.getcwd())}")

    if not os.path.isfile(note):
        print(f"ERROR: '{note}' is not a file.")
        exit(1)

    with open(note, 'r+', encoding='utf-8') as f:
        content = f.read()
        tokens = ovault.text_to_tokens(content)

        if print_tokens:
            for t in tokens:
                print(f"    {t}")

        formatted = ovault.to_markdown(tokens)

        # Write the formatted content back to the file
        f.seek(0)
        f.write(formatted)


# Iterate over all notes in the vault and format them
def format_vault(path: str, print_tokens: bool = False):
    if not os.path.isdir(path):
        usage(f"ERROR: Vault path '{path}' is not a directory.")
        exit(1)
    for note in sorted(ovault.Vault(path).notes()):
        format_note(note.full_path(), print_tokens=print_tokens)

# Main function to parse command-line arguments and call the appropriate formatting function
def main():
    global PROGRAM

    [PROGRAM, *args] = sys.argv

    if len(args) == 0: usage("No arguments provided.")

    is_vault = False
    print_tokens = False

    while len(args) > 1:
        [arg, *args] = args
        match arg:
            case '--vault':    is_vault     = True
            case '--tokens':   print_tokens = True
            case _:            usage(f"Unknown argument '{arg}'.")

    if len(args) != 1: usage("No vault path provided.")

    path = args[0]

    match is_vault:
        case True:  format_vault(path, print_tokens)
        case False: format_note (path, print_tokens)


if __name__ == "__main__":
    main()
