import pytest
import os
import shutil
from pathlib import Path

VAULT_DIR = Path(__file__).parent.parent / "test-vaults"

import ovault

def copy_dir_content(src: Path, dst: Path):
    """Recursively copies content of src directory to dst."""
    dst.mkdir(parents=True, exist_ok=True)
    for item in os.listdir(src):
        src_path = src / item
        dst_path = dst / item
        if src_path.is_dir():
            shutil.copytree(src_path, dst_path, dirs_exist_ok=True)
        elif src_path.is_file():
            shutil.copy2(src_path, dst_path)

def get_tmp_vault(tmp_path: Path, vault_name: str) -> ovault.Vault:
    """
    Fixture that copies the 'Obsidian Sandbox' test vault to a temporary directory
    and returns its path.
    """
    source_vault = VAULT_DIR / vault_name
    if not source_vault.exists():
        pytest.fail(f"Test vault '{source_vault}' not found.")

    temp_vault_path = tmp_path / vault_name
    copy_dir_content(source_vault, temp_vault_path)
    return ovault.Vault(str(temp_vault_path))

@pytest.fixture
def sandbox_vault(tmp_path: Path):
    v = get_tmp_vault(tmp_path, "Obsidian Sandbox")
    yield v
    shutil.rmtree(v.path)

@pytest.fixture
def uni_notes_vault(tmp_path: Path):
    v = get_tmp_vault(tmp_path, "BalderHolst_uni-notes")
    yield v
    shutil.rmtree(v.path)

@pytest.fixture
def simple_vault(tmp_path: Path):
    v = get_tmp_vault(tmp_path, "simple_vault")
    yield v
    shutil.rmtree(v.path)

@pytest.fixture
def starter_vault(tmp_path: Path):
    v = get_tmp_vault(tmp_path, "SoRobby_ObsidianStarterVault")
    yield v
    shutil.rmtree(v.path)

@pytest.fixture
def jobo_notes_vault(tmp_path: Path):
    v = get_tmp_vault(tmp_path, "TheJoboReal_Noter")
    yield v
    shutil.rmtree(v.path)

@pytest.fixture
def vaults(sandbox_vault: ovault.Vault,
           uni_notes_vault: ovault.Vault,
           simple_vault: ovault.Vault,
           starter_vault: ovault.Vault,
           jobo_notes_vault: ovault.Vault) -> list[ovault.Vault]:

    return [ sandbox_vault, uni_notes_vault, simple_vault, starter_vault, jobo_notes_vault ]

@pytest.fixture
def empty_vault(tmp_path: Path):
    empty_vault_path = tmp_path / "empty_vault"
    empty_vault_path.mkdir()
    vault = ovault.Vault(str(empty_vault_path))
    yield vault
    shutil.rmtree(empty_vault_path)
