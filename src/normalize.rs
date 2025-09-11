//! Defines the `normalize` function to normalize note names for Obsidian links.

#[cfg(feature = "python")]
use pyo3::prelude::*;

#[cfg_attr(feature = "python", pyfunction)]
/// Nomalize a note name or path to be used in Obsidian links.
///
/// Example:
/// ```python
/// normalize("My Note") => "my-note"
/// ```
pub fn normalize(name: String) -> String {
    // Trim leading and trailing whitespace

    let mut name = name.trim();

    name = name.strip_prefix('/').unwrap_or(name);

    // Strip ".md" suffix if present
    let name = name.strip_suffix(".md").unwrap_or(name);

    // Trim spaces in each path component
    let name = name
        .split('/')
        .map(|part| part.trim())
        .filter(|part| !part.is_empty())
        .collect::<Vec<&str>>()
        .join("/");

    // Replace spaces with hyphens
    let name = name
        .chars()
        .map(|c| match c {
            ' ' => '-',
            _ => c.to_lowercase().next().unwrap(),
        })
        .collect::<String>();

    // Remove repeated '-'
    let name = name
        .split('-')
        .filter(|part| !part.is_empty())
        .map(|part| part.to_string())
        .collect::<Vec<String>>()
        .join("-");

    // Filter other chars away in name
    let name = name.chars().filter(|c| !matches!(c, '\'' | ',')).collect();

    name
}

#[cfg(test)]
mod tests {
    use super::*;

    // Helper function to make tests more concise
    fn assert_normalize(input: &str, expected: &str) {
        println!("Normalizing input: '{}'", input);
        let result = normalize(input.to_string());
        assert_eq!(
            result,
            expected.to_string(),
            "Failed for input: '{}'",
            input
        );
    }

    #[test]
    fn test_normalize_basic_name() {
        assert_normalize("My Note", "my-note");
        assert_normalize("Another Test", "another-test");
        assert_normalize("simple", "simple");
    }

    #[test]
    fn test_normalize_with_multiple_spaces() {
        assert_normalize("My   Note", "my-note");
        assert_normalize("  Leading Trailing  ", "leading-trailing");
        assert_normalize("Multiple   Spaces   Here", "multiple-spaces-here");
    }

    #[test]
    fn test_normalize_with_apostrophes() {
        assert_normalize("O'Reilly's Book", "oreillys-book");
        assert_normalize("Don't Forget", "dont-forget");
        assert_normalize("It's a Trap!", "its-a-trap!"); // Punctuation at the end might remain depending on implementation
    }

    #[test]
    fn test_normalize_with_existing_hyphens() {
        assert_normalize("already-hyphenated", "already-hyphenated");
        assert_normalize("my-awesome-note", "my-awesome-note");
    }

    #[test]
    fn test_normalize_leading_trailing_hyphens_from_spaces() {
        assert_normalize(" My Note ", "my-note");
        assert_normalize(" - My Note - ", "my-note");
    }

    #[test]
    fn test_normalize_with_leading_trailing_spaces() {
        assert_normalize(" Leading Space", "leading-space");
        assert_normalize("Trailing Space ", "trailing-space");
        assert_normalize("  Both Sides  ", "both-sides");
    }

    #[test]
    fn test_normalize_empty_string() {
        assert_normalize("", "");
    }

    #[test]
    fn test_normalize_only_spaces() {
        assert_normalize("   ", "");
    }

    #[test]
    fn test_normalize_with_numbers() {
        assert_normalize("Note 123", "note-123");
        assert_normalize("2023 Goals", "2023-goals");
    }

    #[test]
    fn test_normalize_with_mixed_case() {
        assert_normalize("MiXeD cAsE NoTe", "mixed-case-note");
        assert_normalize("ALL CAPS NOTE", "all-caps-note");
    }

    #[test]
    fn test_normalize_with_special_characters() {
        assert_normalize("Note!@#$%^&*()", "note!@#$%^&*()");
        assert_normalize("Note, with comma.", "note-with-comma.");
        assert_normalize("Note/with/slash", "note/with/slash");
        assert_normalize("Note_with_underscore", "note_with_underscore");
    }

    #[test]
    fn test_normalize_with_path_components() {
        // This is crucial for how Obsidian handles links.
        // It should extract the "file name" part and then normalize it.
        assert_normalize("path/to/My Document.md", "path/to/my-document");
        assert_normalize(
            "another/dir/Note with Spaces.txt",
            "another/dir/note-with-spaces.txt",
        );
        assert_normalize("/absolute/path/File.md", "absolute/path/file");
        assert_normalize("no/extension/file", "no/extension/file");
    }

    #[test]
    fn test_normalize_complex_case() {
        assert_normalize(
            "  A'nOthEr / CoMplEx   N0tE   wItH 'pUnCtUaTiOn?!.md  ",
            "another/complex-n0te-with-punctuation?!",
        );
        assert_normalize(
            "very///deep/path/My Final-Note.md",
            "very/deep/path/my-final-note",
        );
    }
}
