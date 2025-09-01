import ovault

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

def test_rename_note(uni_notes_vault: ovault.Vault):
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
