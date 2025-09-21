# Import the Rust extension as the base
from .ovault import *

def _backup_warning():
    print(
        "WARNING: OVault is a powerful tool that can modify many files in your Obsidian vault.\n"
        "MAKE SURE YOU HAVE A BACKUP of your vault before using OVault, as changes made\n"
        "by OVault may be difficult or impossible to undo."
    )
