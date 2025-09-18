import ovault
import tempfile

def test_open_all_test_vaults(vaults: list[ovault.Vault]):
    """
    Test that all test vaults can be opened without errors.
    """
    for vault in vaults:
        print(vault.path)

def test_rename_tag_uni_vault(uni_notes_vault: ovault.Vault):
    vault = uni_notes_vault

    old_tag = "matematik"
    new_tag = "math"

    # Old tag should exist
    assert old_tag in vault.tags()

    tagged_notes = vault.get_notes_by_tag(old_tag)

    vault.rename_tag(old_tag, new_tag)

    # Old tag should not exist anymore
    assert old_tag not in vault.tags()
    assert len(vault.get_notes_by_tag(old_tag)) == 0

    # New tag should exist
    assert new_tag in vault.tags()
    assert len(vault.get_notes_by_tag(new_tag)) == len(tagged_notes)

def test_rename_tag_simple_vault(simple_vault: ovault.Vault):
    vault = simple_vault

    old_tag = "#frontmatter-tag2"
    new_tag = "RENAMED"

    tagged_notes = vault.get_notes_by_tag(old_tag)

    # Old tag should exist
    assert len(tagged_notes) > 0

    vault.rename_tag(old_tag, new_tag)

    # Old tag should not exist anymore
    assert old_tag not in vault.tags()
    assert len(vault.get_notes_by_tag(old_tag)) == 0

    # New tag should exist
    assert new_tag in vault.tags()
    assert len(vault.get_notes_by_tag(new_tag)) == len(tagged_notes)

def test_rename_note_in_simple_vault(simple_vault: ovault.Vault):
    vault = simple_vault

    old_note_name = "first_note"
    new_note_name = "FIRST_NOTE_RENAMED"

    print(vault.notes())

    old_note = vault.get_note_by_name(old_note_name)
    assert old_note is not None

    old_note_content = old_note.read()

    vault.rename_note(old_note_name, new_note_name)

    # Old note should not exist anymore
    assert vault.get_note_by_name(old_note_name) is None

    # New note should exist
    new_note = vault.get_note_by_name(new_note_name)
    assert new_note is not None

    assert new_note.read() == old_note_content

    for backlink in new_note.backlinks:
        backlink_note = vault.get_note_by_name(backlink)
        print(f"Checking backlinks in note: {backlink}")
        for link in backlink_note.links:
            print(f"    {backlink} -> {link}")
            assert link != old_note_name, "Backlinks should be updated to the new note name"

def test_rename_note_in_uni_vault(uni_notes_vault: ovault.Vault):
    vault = uni_notes_vault

    old_note_name = "Jacobian Matrix"
    new_note_name = "Jacobian Matrix Renamed"

    old_note = vault.get_note_by_name(old_note_name)
    assert old_note is not None

    old_note_content = old_note.read()

    vault.rename_note(old_note_name, new_note_name)

    # Old note should not exist anymore
    assert vault.get_note_by_name(old_note_name) is None

    # New note should exist
    new_note = vault.get_note_by_name(new_note_name)
    assert new_note is not None

    assert new_note.read() == old_note_content

    for backlink in new_note.backlinks:
        backlink_note = vault.get_note_by_name(backlink)
        for link in backlink_note.links:
            print(f"{backlink} -> {link}")
            assert link != old_note_name, "Backlinks should be updated to the new note name"

def test_vault_ignore(simple_vault: ovault.Vault):
    vault_path = str(simple_vault.path)

    def note_paths(notes):
        return sorted([str(note.path) for note in notes])

    def create_ignore_file(contents: str) -> tempfile.NamedTemporaryFile:
        ignore_file = tempfile.NamedTemporaryFile("w+")
        ignore_file.write(contents)
        ignore_file.flush()
        return ignore_file

    # ============== No ignore ==============

    default = ovault.Vault(vault_path, ignore = [], ignore_file=None)
    default_paths = note_paths(default.notes())
    print("Default (no ignore):")
    print(default_paths)

    default_ignore_file = create_ignore_file("")
    default_f = ovault.Vault(vault_path, ignore = [], ignore_file=default_ignore_file.name)
    default_f_paths = note_paths(default_f.notes())
    print("\nDefault (no ignore) from file:")
    print(default_f_paths)

    assert default_paths == default_f_paths

    # ============== Ignore todo.md ==============

    no_todos = ovault.Vault(vault_path, ignore = ["todo.md"])
    no_todos_paths = note_paths(no_todos.notes())
    print("\nIgnoring 'todo.md':")
    print(no_todos_paths)

    no_todos_ignore_file = create_ignore_file("todo.md")
    no_todos_f = ovault.Vault(vault_path, ignore = [], ignore_file=no_todos_ignore_file.name)
    no_todos_f_paths = note_paths(no_todos_f.notes())
    print("\nIgnoring 'todo.md' from file:")
    print(no_todos_f_paths)

    assert no_todos_paths == no_todos_f_paths

    # ============== Ignore /sub directory ==============

    no_sub = ovault.Vault(vault_path, ignore = ["/sub"])
    no_sub_paths = note_paths(no_sub.notes())
    print("\nIgnoring '/sub' directory:")
    print(no_sub_paths)

    no_sub_ignore_file = create_ignore_file("/sub")
    no_sub_f = ovault.Vault(vault_path, ignore = [], ignore_file=no_sub_ignore_file.name)
    no_sub_f_paths = note_paths(no_sub_f.notes())
    print("\nIgnoring '/sub' directory from file:")
    print(no_sub_f_paths)

    assert no_sub_paths == no_sub_f_paths
