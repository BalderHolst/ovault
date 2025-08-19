import subprocess
from pathlib import Path
import pytest
import ovault

EXAMPLE_DIR = Path(__file__).parent.parent / "examples"
VAULT_DIR = Path(__file__).parent.parent / "test-vaults"

VAULTS = [
    "Obsidian Sandbox",
    "BalderHolst_uni-notes",
    "simple_vault",
    "SoRobby_ObsidianStarterVault",
    "TheJoboReal_Noter",
]

# 1_overview.py
# 2_find_tag.py
# 3_find_headings.py
# 4_check_external_links.py
# 5_graph_image.py
# 6_create_vault.py
# 7_rename_note.py

def run_example(name: str, *args) -> str:
    out = subprocess.run(['python', str(EXAMPLE_DIR / name), *args], capture_output=True, text=True)
    cmd = f"python {name} {' '.join(list(args))}"
    if out.returncode != 0:
        print(f"Error running {cmd}:")
        print(out.stderr)
        exit(1)
    out = out.stdout.strip()
    print(f"\n[CMD] {cmd}:\n{out}\n")
    return out

# ================================== TESTS ==================================

def test_1_overview():

    expected = {
            "Obsidian Sandbox":             ["path        : /home/balder/projects/ovault/test-vaults/Obsidian Sandbox",
                                             "notes       : 31",
                                             "attachments : 0",
                                             "tags        : ['tags']"],
            "BalderHolst_uni-notes":        ['path        : /home/balder/projects/ovault/test-vaults/BalderHolst_uni-notes',
                                             'notes       : 509',
                                             'attachments : 365',
                                             "tags        : ['c', 'numerical', 'ai', 'cpp', 'datacommunication', 'elektronik', 'signals', 'kinematics', 'microcontrolers', 'vektorer', 'fysik', 'excalidraw', 'computerarchitecture', 'underactuated', 'matematik', 'forstærker', 'linearalgebra', 'notag', 'differentialer', 'signalprocessing', 'integraler', 'partialdiffequations', 'funktioner', 'vectorfields', 'approximation', 'TCP', 'linux', 'python', 'controlsystems', 'multivariablemath', 'embedded', 'komponent', 'funktionafflerevariable', 'softwaredevelopment', 'subject', 'intelligent', 'sorting', 'statistics', 'algorithms', 'filter', 'differentialligninger', 'distribution', 'matricer']"],
            "simple_vault":                 ['path        : /home/balder/projects/ovault/test-vaults/simple_vault',
                                             'notes       : 7',
                                             'attachments : 0',
                                             "tags        : ['frontmatter-tag2', 'linksaregood', 'frontmatter-tag1', 'callout4youtag']"],
            "SoRobby_ObsidianStarterVault": ['path        : /home/balder/projects/ovault/test-vaults/SoRobby_ObsidianStarterVault',
                                             'notes       : 99',
                                             'attachments : 44',
                                             "tags        : ['notes', 'excalidraw', 'dashboard']"],
            "TheJoboReal_Noter":            ['path        : /home/balder/projects/ovault/test-vaults/TheJoboReal_Noter',
                                             'notes       : 874',
                                             'attachments : 2207',
                                             "tags        : ['ArcCos', 'Split', 'uni', 'ArcSin', 'effekt', 'Fjeder', 'course', 'Arbejde', 'Parrallel', 'define', 'Phasor', 'Heap', 'semester', 'excalidraw', 'Friktion', 'assignment', 'Inverterende', 'ArcTan', 'Lavplasfilter', 'Terminalhastighed', 'Hooks', 'ikke', 'Faseforskydning', 'Masseinertimoment', 'lecture-slide', 'lecture-note', 'exercise', 'SharedMemory', 'Stacks', 'algorithms', 'Centripidalkraften']"]
    }

    for v in VAULTS:
        out = run_example("1_overview.py", str(VAULT_DIR / v))

        print("\n" + str(out.splitlines()) + "\n")

        for i, line in enumerate(out.splitlines()):
            if len(expected[v]) != out.count("\n") + 1:
                raise pytest.fail(f"Expected {len(expected[v])} lines, got {len(out.splitlines())} for vault {v}")
            if line.startswith("path        :"):
                assert line == expected[v][i], f"Vault {v} failed on line {i+1}: {line}"

def test_2_find_tag(simple_vault: ovault.Vault):
    vault_path = str(simple_vault.path)

    # Find notes with a tag
    expected = "Searching for notes with tag: linksaregood\n"\
               "    second_note (178 characters)"

    got = run_example("2_find_tag.py", vault_path, "linksaregood")

    assert got == expected

    # Frontmatter tags
    expected = "Searching for notes with tag: frontmatter-tag1\n"\
               "    frontmatter (172 characters)"

    got = run_example("2_find_tag.py", vault_path, "frontmatter-tag1")

    print(got)
    assert got == expected

