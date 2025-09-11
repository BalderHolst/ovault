use std::{
    fs, io,
    path::{Path, PathBuf},
};

use pretty_assertions::assert_eq;
use serial_test::serial;

use crate::*;

const VAULT_DIR: &str = concat!(env!("CARGO_MANIFEST_DIR"), "/test-vaults");
const TMP_DIR: &str = concat!(env!("CARGO_MANIFEST_DIR"), "/target/tmp-test-vaults");

#[derive(Debug, Clone, Copy)]
enum TestVaultBase {
    Sandbox,
    SimpleVault,
    BalderHolst,
    SoRobby,
    TheJoboReal,
}

impl TestVaultBase {
    fn all() -> &'static [Self] {
        &[
            Self::Sandbox,
            Self::SimpleVault,
            Self::BalderHolst,
            Self::SoRobby,
            Self::TheJoboReal,
        ]
    }

    fn path(&self) -> PathBuf {
        let dir = PathBuf::from(VAULT_DIR);
        match self {
            Self::Sandbox => dir.join("Obsidian Sandbox"),
            Self::SimpleVault => dir.join("simple_vault"),
            Self::BalderHolst => dir.join("BalderHolst_uni-notes"),
            Self::SoRobby => dir.join("SoRobby_ObsidianStarterVault"),
            Self::TheJoboReal => dir.join("TheJoboReal_Noter"),
        }
    }
}

fn _pull_submodules() {
    // Pull submodules if they are not already initialized
    let status = std::process::Command::new("git")
        .args(["submodule", "update", "--init", "--recursive"])
        .status()
        .expect("Failed to run git submodule update");

    if !status.success() {
        panic!("Failed to pull submodules");
    }
}

fn copy_dir_all(src: &Path, dst: &Path) {
    if !src.exists() {
        panic!("Source directory does not exist: {}", src.display());
    }
    if dst.exists() {
        panic!("Destination directory already exists: {}", dst.display());
    }

    fs::create_dir_all(dst).expect("Failed to create destination directory");

    for entry in fs::read_dir(src).expect("Failed to read source directory") {
        let entry = entry.expect("Failed to read entry");
        let src_path = entry.path();
        let dst_path = dst.join(entry.file_name());

        if src_path.is_dir() {
            copy_dir_all(&src_path, &dst_path);
        } else {
            // Warn in error
            _ = fs::copy(&src_path, &dst_path).map_err(|e| {
                eprintln!(
                    "WARNING: Failed to copy file from {} to {}: {}",
                    src_path.display(),
                    dst_path.display(),
                    e
                );
            });
        }
    }
}

struct TestVault {
    vault: Vault,
}

impl TestVault {
    fn new(base: TestVaultBase) -> io::Result<Self> {
        let tmp_vault_path = PathBuf::from(TMP_DIR).join(base.path().file_name().unwrap());

        // Copy the vault directory to the temporary directory
        if tmp_vault_path.exists() {
            fs::remove_dir_all(&tmp_vault_path)?;
        }

        copy_dir_all(&base.path(), &tmp_vault_path);

        let vault = Vault::new(&tmp_vault_path)?;

        Ok(Self { vault })
    }
}

impl Drop for TestVault {
    fn drop(&mut self) {
        // Clean up the temporary vault directory
        let tmp_vault_path = self.vault.path.as_path();
        if tmp_vault_path.exists() {
            fs::remove_dir_all(tmp_vault_path).expect("Failed to remove temporary vault directory");
        }
    }
}

fn zero_tokens(tokens: Vec<Token>) -> Vec<Token> {
    tokens.into_iter().map(zero_span).collect()
}

fn zero_span(mut token: Token) -> Token {
    let span = token.span_mut();
    *span = Span::ZERO;

    match token {
        Token::Quote { ref mut tokens, .. } => {
            *tokens = zero_tokens(tokens.clone());
        }
        Token::Callout {
            ref mut callout, ..
        } => {
            callout.tokens = zero_tokens(callout.tokens.clone());
        }
        Token::List { ref mut items, .. } => {
            for item in items {
                item.span = Span::ZERO;
                item.tokens = zero_tokens(item.tokens.clone());
            }
        }
        Token::NumericList { ref mut items, .. } => {
            for item in items {
                item.span = Span::ZERO;
                item.tokens = zero_tokens(item.tokens.clone());
            }
        }
        Token::CheckList { ref mut items, .. } => {
            for item in items {
                item.span = Span::ZERO;
                item.tokens = zero_tokens(item.tokens.clone());
            }
        }
        _ => {}
    }

    token
}

#[test]
#[serial]
fn test_open_vaults() {
    for base in TestVaultBase::all() {
        println!("\nTesting vault: {:?}", base);

        let test_vault = TestVault::new(*base).expect("Failed to create test vault");
        let vault = &test_vault.vault;

        // Check if the vault path exists
        assert!(
            vault.path.exists(),
            "Vault path does not exist: {}",
            vault.path.display()
        );

        // Check if the vault has notes
        let notes: Vec<_> = vault.notes().collect();
        assert!(
            !notes.is_empty(),
            "Vault has no notes: {}",
            vault.path.display()
        );

        // Print the number of notes found
        println!(
            "Found {} notes in vault: {}",
            notes.len(),
            vault.path.display()
        );
    }
}

#[test]
#[serial]
fn test_get_note_by_path() {
    let vaults = vec![
        TestVaultBase::SimpleVault,
        TestVaultBase::Sandbox,
        TestVaultBase::BalderHolst,
    ];

    for base in vaults {
        println!("\nTesting vault: {:?}", base);

        let test_vault = TestVault::new(base).expect("Failed to create test vault");
        let vault = &test_vault.vault;

        for note in vault.notes() {
            let abs_path = note.full_path();
            let rel_path = note.path.clone();

            let note_by_abs = vault
                .get_note_by_path(&abs_path)
                .expect("Failed to get note by absolute path");

            let note_by_rel = vault
                .get_note_by_path(&rel_path)
                .expect("Failed to get note by relative path");

            assert_eq!(note, note_by_abs);
            assert_eq!(note, note_by_rel);
        }
    }
}

#[test]
#[serial]
fn test_name_collisions() {
    let base = TestVaultBase::SimpleVault;
    let test_vault = TestVault::new(base).expect("Failed to create test vault");
    let vault = &test_vault.vault;

    let root_todo_names: &[&str] = &["todo", "Todo", "TODO", " ToDo ", " todo "];
    let sub_todo_names: &[&str] = &[
        "sub/todo",
        "sub/Todo",
        "sub/TODO",
        "sub/ ToDo ",
        "sub/ todo ",
        "SUB/todo",
        "Sub/Todo",
        "SUB/TODO",
        " SUB/ ToDo ",
        "SUB/ todo ",
    ];

    let root_todo = vault.get_note("todo").expect("Failed to get 'todo' note");

    let subdir_todo = vault
        .get_note(sub_todo_names[0])
        .expect("Failed to get 'sub/todo' note");

    assert_ne!(root_todo.path, subdir_todo.path);

    for name in root_todo_names.iter().skip(1) {
        println!("Checking root todo name variant: '{}'", name);
        let note = vault.get_note(name).expect("Failed to get 'todo' note");
        assert_eq!(note.path, root_todo.path);
    }

    for name in sub_todo_names.iter().skip(1) {
        let note = vault.get_note(name).expect("Failed to get 'sub/todo' note");
        println!("Checking subdir todo name variant: '{}'", name);
        assert_eq!(note.path, subdir_todo.path);
    }
}

#[test]
#[serial]
fn test_to_markdown() {
    let bases = &[
        TestVaultBase::Sandbox,
        TestVaultBase::SimpleVault,
        TestVaultBase::BalderHolst,
        TestVaultBase::SoRobby,
        TestVaultBase::TheJoboReal,
    ];

    for base in bases {
        println!("\nTesting vault: {:?}", base);

        let test_vault = TestVault::new(*base).expect("Failed to create test vault");
        let vault = &test_vault.vault;

        let mut notes = vault.notes().collect::<Vec<_>>();

        // Sort to make output consistent
        notes.sort_by_key(|note| &note.name);

        for note in notes {
            info!("========== Testing note: '{}' ==========", note.name);
            let tokens: Vec<_> = note
                .tokens()
                .expect("Failed to tokenize note")
                .map(zero_span)
                .collect();

            println!("Original tokens:");
            for token in &tokens {
                println!("  - {:?}", token);
            }

            let text = tokens
                .iter()
                .map(lexer::ToMarkdown::to_markdown)
                .collect::<String>();

            println!("New text:\n{text}\n");

            let new_tokens = lexer::Lexer::new(&text).collect::<Vec<_>>();

            for (old, new) in tokens.iter().zip(new_tokens.iter()) {
                println!(
                    "New token ({}) source: {:?}",
                    new,
                    new.span().extract(&text)
                );
                let new = zero_span(new.clone());
                assert_eq!(old, &new);
            }

            assert_eq!(
                tokens.len(),
                new_tokens.len(),
                "Token count mismatch in note '{}'",
                note.name
            );
        }
    }
}

#[test]
fn test_nested_callout_to_markdown() {
    let source = ">>[!blank-container]\n>>```dataviewjs\n>>```";

    let original_tokens: Vec<_> = lexer::Lexer::new(source).map(zero_span).collect();
    let new_source = original_tokens
        .iter()
        .map(lexer::ToMarkdown::to_markdown)
        .collect::<String>();
    let new_tokens = lexer::Lexer::new(&new_source)
        .map(zero_span)
        .collect::<Vec<_>>();

    assert_eq!(original_tokens, new_tokens);
}

#[test]
#[serial]
fn test_vault_links() {
    let mut test_vault =
        TestVault::new(TestVaultBase::Sandbox).expect("Failed to create test vault");

    let vault = &mut test_vault.vault;

    let mut notes: Vec<_> = vault.notes().collect();
    notes.sort_by_key(|note| &note.name);

    assert_eq!(notes.len(), 31);

    // Start Here
    {
        let note = vault
            .get_note("start-here")
            .expect("'Start Here' note not found");
        assert_eq!(note.name, "Start Here");
        assert_eq!(note.path.as_path().file_name().unwrap(), "Start Here.md");
    }

    // Links
    const LINK_COUNTS: &[(&str, usize)] = &[
        ("Lists", 0),
        ("Task", 0),
        ("Images", 0),
        ("Internal link", 1),
        ("Code block", 0),
        ("Links", 0),
        ("Embeds", 2),
        ("Inline code", 0),
        ("Horizontal divider", 0),
        ("Math", 0),
        ("Format your notes", 20),
        ("Emphasis", 0),
        ("Highlighting", 0),
        ("Footnote", 0),
        ("Diagram", 1),
        ("Strikethrough", 0),
        ("Callout", 1),
        ("Comment", 0),
        ("Table", 2),
        ("Heading", 0),
        ("Blockquote", 0),
        ("Plugins make Obsidian special for you", 1),
        ("Vault is just a local folder", 1),
        ("Start Here", 3),
        ("From standard note-taking", 3),
        ("No prior experience", 3),
        ("From plain-text note-taking", 3),
        ("Get started with Obsidian", 3),
        ("Create a vault", 1),
        ("Create your first note", 2),
        ("Link notes", 1),
    ];
    for note in &notes {
        println!("Checking links in note: '{}'", note.name);
        for link in &note.links {
            println!("  - '{:?}'", link);
        }

        let expected_count = LINK_COUNTS
            .iter()
            .find(|(name, _)| *name == note.name)
            .expect("Missing expected link count")
            .1;
        assert_eq!(
            note.links.len(),
            expected_count,
            "Unexpected link count in note '{}': expected {}, found {}",
            note.name,
            expected_count,
            note.links.len()
        );
    }
}
