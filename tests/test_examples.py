from pathlib import Path
import os

import rere

ROOT_DIR = Path(__file__).parent.parent
EXAMPLE_DIR = Path(__file__).parent.parent / "examples"
VAULT_DIR = Path(__file__).parent.parent / "test-vaults"

VAULT_PLACEHOLDER = "<vault>"

VAULTS = [
    "Obsidian Sandbox",
    "BalderHolst_uni-notes",
    "simple_vault",
    "SoRobby_ObsidianStarterVault",
    "TheJoboReal_Noter",
]

EXPECTED_FILE = Path(__file__).parent / "test_examples_expected.bi"

SHELLS = [
    "python3 examples/1_overview.py <vault>",

    "python3 examples/2_find_tag.py <vault> math",
    "python3 examples/2_find_tag.py <vault> matematik",
    "python3 examples/2_find_tag.py <vault> frontmatter-tag1",

    "python3 examples/3_find_headings.py",

    "python3 examples/4_graph_image.py <vault>",

    "python3 examples/5_create_vault.py tmp_test_vault && rm -rf tmp_test_vault",

    "python3 examples/6_rename_note.py test-vaults/simle_vault first_note    FIRST",
    "python3 examples/6_rename_note.py test-vaults/simle_vault first_note.md FIRST.md",

    "python3 examples/7_add_frontmatter.py <vault>",

    "python3 examples/8_formatter.py test-vaults/simple_vault/first_note.md",
    "python3 examples/8_formatter.py --vault <vault>",
]

def unwrap_shells(shells: list[str]) -> list[str]:
    result = []
    for shell in shells:
        if VAULT_PLACEHOLDER in shell:
            for vault in VAULTS:
                result.append(shell.replace(VAULT_PLACEHOLDER, '"' + os.path.relpath(VAULT_DIR / vault, ROOT_DIR) + '"'))
        else:
            result.append(shell)
    return result

def restore_vault(vault_name: str):
    vault_path = VAULT_DIR / vault_name
    os.system(f"cd \"{vault_path}\" && git restore . && git clean -fd")

def restore_vaults():
    for vault in VAULTS:
        restore_vault(vault)

def test_examples():
    snapshots = rere.load_snapshots(EXPECTED_FILE)
    shells = unwrap_shells(SHELLS)

    assert len(snapshots) == len(shells), "UNEXPECTED: Amount of shell commands in test_examples.py\nNOTE: Re-run 'record.py' to assert the new output as correct." \

    for (shell, snapshot) in zip(shells, snapshots):
        restore_vaults()
        result = rere.capture(shell, cwd=ROOT_DIR)
        assert result == snapshot

    restore_vaults()
