use std::{
    collections::{HashMap, HashSet},
    fs, io,
    path::PathBuf,
};

#[cfg(feature = "python")]
use pyo3::prelude::*;

use glob::glob;

use crate::lexer::{Lexer, Token};

fn normalize(mut name: String) -> String {
    // TODO: Actually handle multiple files with the same name
    if name.contains('/') {
        name = name.split_once('/').unwrap().1.to_string();
    }

    name.chars()
        .map(|c| match c {
            ' ' => '-',
            _ => c.to_lowercase().next().unwrap(),
        })
        // Remove repeated '-'
        .collect::<String>()
        .split('-')
        .filter(|part| !part.is_empty())
        .map(|part| part.to_string())
        .collect::<Vec<String>>()
        .join("-")
        // Filter other chars away in name
        .chars()
        .filter(|c| match c {
            '\'' => false,
            _ => true,
        })
        .collect()
}

#[derive(Debug, Clone, PartialEq)]
#[cfg_attr(feature = "python", pyclass(get_all))]
/// A note in an Obsidian vault.
pub struct Note {
    /// Path to the vault
    vault_path: PathBuf,
    /// Relative path within vault
    path: PathBuf,
    name: String,
    length: usize,
    tags: HashSet<String>,
    backlinks: HashSet<String>,
    links: HashSet<String>,
}

// Python specific methods
#[cfg(feature = "python")]
#[pymethods]
impl Note {
    pub fn __repr__(&self) -> String {
        format!("Note({})", self.name)
    }

    pub fn __len__(&self) -> usize {
        self.length
    }

    #[pyo3(name = "tokens")]
    pub fn py_tokens(&self) -> PyResult<Vec<Token>> {
        match self.tokens() {
            Ok(ts) => Ok(ts.collect()),
            Err(e) => Err(e.into()),
        }
    }

    #[pyo3(name = "full_path")]
    pub fn py_full_path(&self) -> PathBuf {
        self.full_path()
    }

    #[pyo3(name = "frontmatter")]
    pub fn py_frontmatter(&self) -> Option<String> {
        self.frontmatter()
    }

    pub fn read(&self) -> io::Result<String> {
        self.contents()
    }

    #[pyo3(name = "insert_at")]
    pub fn py_insert_at(&mut self, mut pos: isize, text: String) -> PyResult<()> {
        if pos < 0 {
            pos += self.length as isize;
        }
        let pos = usize::try_from(pos).map_err(|_| {
            pyo3::exceptions::PyIndexError::new_err(format!(
                "Note position out of range. The note is {} characters long.",
                self.length
            ))
        })?;
        let pos = pos as usize;
        self.insert_at(pos, text).map_err(PyErr::from)
    }

    #[pyo3(signature = (token, text, offset=0))]
    pub fn insert_before_token(
        &mut self,
        token: Token,
        text: String,
        offset: isize,
    ) -> PyResult<()> {
        let pos = token.span().start as isize + offset;
        self.py_insert_at(pos, text)
    }

    #[pyo3(signature = (token, text, offset=0))]
    pub fn insert_after_token(
        &mut self,
        token: Token,
        text: String,
        offset: isize,
    ) -> PyResult<()> {
        let pos = token.span().end as isize + offset;
        self.py_insert_at(pos, text)
    }
}

// Rust specific methods
impl Note {
    fn full_path(&self) -> PathBuf {
        self.vault_path.join(&self.path)
    }

    pub fn frontmatter(&self) -> Option<String> {
        match self.tokens().ok()?.next()? {
            Token::Frontmatter { yaml, .. } => Some(yaml),
            _ => None,
        }
    }

    pub fn path_debth(&self) -> usize {
        self.path.components().count()
    }

    pub fn contents(&self) -> io::Result<String> {
        fs::read_to_string(self.full_path())
    }

    fn tokens(&self) -> io::Result<impl Iterator<Item = Token>> {
        let contents = self.contents()?;
        Ok(Lexer::new(contents))
    }

    fn add_link(&mut self, to: String) {
        self.links.insert(to);
    }

    fn add_backlink(&mut self, from: String) {
        self.backlinks.insert(from);
    }

    pub fn insert_at(&mut self, pos: usize, text: String) -> io::Result<()> {
        let path = self.full_path();
        let contents = fs::read_to_string(path.clone())?;
        let contents = format!("{}{}{}", &contents[..pos], text, &contents[pos..]);
        self.index_contents(contents.clone());
        fs::write(path, contents)
    }

    /// Update `tags` and `links` fields from note contents
    fn index(&mut self) {
        let contents = match self.contents() {
            Ok(ts) => ts,
            Err(e) => {
                eprintln!(
                    "WARNING: Could not read file '{}': {}",
                    self.full_path().display(),
                    e
                );
                return;
            }
        };
        self.index_contents(contents);
    }

    fn index_contents(&mut self, contents: String) {
        self.links.clear();
        self.tags.clear();
        self.length = contents.len();
        let tokens = Lexer::new(contents);
        self.index_tokens(tokens);
    }

    fn index_tokens(&mut self, tokens: impl Iterator<Item = Token>) {
        for token in tokens {
            match token {
                Token::Tag { tag, .. } => {
                    self.tags.insert(tag.clone());
                }
                Token::InternalLink { link, .. } => {
                    // if `dest` field is empty, the link points to heading in itself
                    // and we don't have to do anything in that case.
                    if link.dest.is_empty() {
                        continue;
                    }

                    let to = normalize(link.dest.clone());
                    self.add_link(to);
                }
                Token::Callout { callout, .. } => {
                    self.index_tokens(callout.contents.iter().cloned());
                }
                Token::Quote {
                    contents: tokens, ..
                } => {
                    self.index_tokens(tokens.iter().cloned());
                }
                Token::Frontmatter { .. }
                | Token::Text { .. }
                | Token::Header { .. }
                | Token::Divider { .. }
                | Token::InlineMath { .. }
                | Token::DisplayMath { .. }
                | Token::Code { .. }
                | Token::ExternalLink { .. } => {}
            }
        }
    }
}

#[derive(Debug, Clone, PartialEq)]
#[cfg_attr(feature = "python", pyclass(get_all))]
/// An attachment in an Obsidian vault. An attachment is any
/// file that is not a markdown file.
pub struct Attachment {
    path: PathBuf,
}

#[derive(Debug, Clone, PartialEq)]
#[cfg_attr(feature = "python", pyclass)]
enum VaultItem {
    Note { note: Note },
    Attachment { attachment: Attachment },
}

#[cfg(not(feature = "python"))]
#[derive(Debug, Clone, PartialEq)]
pub struct Vault {
    /// Maps normalized note names to notes
    items: HashMap<String, VaultItem>,

    /// Path to Obsidian vault
    path: PathBuf,

    ignored: HashSet<PathBuf>,

    /// Maps tags to notes with those tags
    tags: HashMap<String, HashSet<String>>,

    /// Maps notes to the dangling links they contain
    dangling_links: HashMap<String, Vec<String>>,
}

#[cfg(feature = "python")]
#[derive(Debug, Clone, PartialEq)]
#[pyclass]
/// An Obsidian vault containing notes and attachments. The vault is indexed
/// on creation and can be re-indexed with the `index` method.
pub struct Vault {
    #[pyo3(get)]
    path: PathBuf,
    #[pyo3(get)]
    dangling_links: HashMap<String, Vec<String>>,

    /// Paths that were ignored during indexing
    #[pyo3(get)]
    ignored: HashSet<PathBuf>,
    items: HashMap<String, VaultItem>,
    tags: HashMap<String, HashSet<String>>,
}

impl Vault {
    const IGNORE_FILE: &str = ".vault-ignore";
    const DEFAULT_IGNORED: &[&'static str] = &[Self::IGNORE_FILE, ".git", ".obsidian", ".trash"];
}

#[cfg(feature = "python")]
#[pymethods]
impl Vault {
    #[new]
    pub fn py_new(path: &str) -> PyResult<Self> {

        let path = PathBuf::from(path);
        let path = path.canonicalize().map_err(|e| {
            pyo3::exceptions::PyFileNotFoundError::new_err(format!(
                "Could not find vault at '{}': {}",
                path.display(),
                e
            ))
        })?;

        let mut v = Self::new(&path);
        v.parse_ignore_file(&path.join(Self::IGNORE_FILE))?;
        v.add_dir(&path)?;
        v.index();
        Ok(v)
    }

    #[pyo3(name = "notes")]
    pub fn py_notes(&self) -> Vec<Note> {
        self.notes().cloned().collect()
    }

    #[pyo3(name = "attachments")]
    pub fn py_attachments(&self) -> Vec<Attachment> {
        self.attachments().cloned().collect()
    }

    #[pyo3(name = "tags")]
    pub fn tags(&self) -> Vec<String> {
        self.tags.keys().cloned().collect()
    }

    #[pyo3(name = "index")]
    pub fn py_index(&mut self) -> PyResult<()> {
        self.items.clear();
        self.tags.clear();
        let path = self.path.clone();
        self.add_dir(&path).map_err(PyErr::from)?;
        self.index();
        Ok(())
    }

    #[pyo3(name = "get_notes_by_tag")]
    pub fn py_get_notes_by_tag(&self, tag: &str) -> Option<Vec<Note>> {
        let notes = self
            .tags
            .get(tag)?
            .iter()
            .filter_map(|name| self.get_note(name))
            .cloned()
            .collect();
        Some(notes)
    }

    #[pyo3(name = "get_note_by_name")]
    pub fn py_get_note(&self, name: &str) -> Option<Note> {
        self.get_note(&normalize(name.to_string())).cloned()
    }
}

impl Vault {

    pub fn new(path: &PathBuf) -> Self {
        let ignored = HashSet::from_iter(Self::DEFAULT_IGNORED.iter().map(PathBuf::from));
        Self {
            path: path.clone(),
            dangling_links: HashMap::new(),
            items: HashMap::new(),
            tags: HashMap::new(),
            ignored,
        }
    }

    fn items(&self) -> impl Iterator<Item = &VaultItem> {
        self.items.values()
    }

    fn items_mut(&mut self) -> impl Iterator<Item = &mut VaultItem> {
        self.items.values_mut()
    }

    pub fn notes(&self) -> impl Iterator<Item = &Note> {
        self.items().filter_map(|item| match item {
            VaultItem::Note { note } => Some(note),
            _ => None,
        })
    }

    pub fn notes_mut(&mut self) -> impl Iterator<Item = &mut Note> {
        self.items_mut().filter_map(|item| match item {
            VaultItem::Note { note } => Some(note),
            _ => None,
        })
    }

    pub fn attachments(&self) -> impl Iterator<Item = &Attachment> {
        self.items().filter_map(|item| match item {
            VaultItem::Attachment { attachment } => Some(attachment),
            _ => None,
        })
    }

    pub fn attachments_mut(&mut self) -> impl Iterator<Item = &mut Attachment> {
        self.items_mut().filter_map(|item| match item {
            VaultItem::Attachment { attachment } => Some(attachment),
            _ => None,
        })
    }

    pub fn parse_ignore_file(&mut self, path: &PathBuf) -> io::Result<()> {
        if !path.exists() {
            return Ok(());
        }

        let contents = fs::read_to_string(path)?;
        for (i, line) in contents.lines().enumerate() {
            let line = line.trim();

            // Skip empty lines and comments
            if line.is_empty() || line.starts_with('#') {
                continue;
            }

            let gstr = match line.starts_with("/") {
                true => format!("{}{}", self.path.display(), line),
                false => format!("{}/**/{}", self.path.display(), line),
            };

            let Ok(ignored_paths) = glob(&gstr) else {
                eprintln!(
                    "WARNING: Could not parse line {} in ignore file '{}'",
                    i + 1,
                    path.display()
                );
                continue;
            };
            ignored_paths.filter_map(Result::ok).for_each(|path| {
                let abs_path = path.canonicalize().unwrap();
                let rel_path = abs_path.strip_prefix(&self.path).unwrap();
                self.ignored.insert(rel_path.to_path_buf());
            });
        }
        Ok(())
    }

    /// Add a note to the vault
    pub fn add_note(&mut self, path: &PathBuf) {
        debug_assert_eq!(path.extension().unwrap(), "md");

        let name = path.file_stem().unwrap().to_str().unwrap();

        let note = Note {
            vault_path: self.path.clone(),
            path: path.strip_prefix(&self.path).unwrap().to_path_buf(),
            name: name.to_string(),
            length: 0,
            links: Default::default(),
            tags: Default::default(),
            backlinks: Default::default(),
        };

        let normalized_name = normalize(name.to_string());
        self.items.insert(normalized_name, VaultItem::Note { note });
    }

    fn add_attachment(&mut self, path: PathBuf) {
        let name = normalize(path.file_name().unwrap().to_str().unwrap().to_string());
        let relpath = path.strip_prefix(&self.path).unwrap().to_path_buf();
        let attachment = Attachment { path: relpath };
        self.items
            .insert(name, VaultItem::Attachment { attachment });
    }

    pub fn add_dir(&mut self, path: &PathBuf) -> io::Result<()> {
        let Ok(rel_path) = path.strip_prefix(&self.path) else {
            eprintln!(
                "WARNING: Can not add directory outside of vault: '{}'",
                path.display()
            );
            return Ok(());
        };

        if self.ignored.contains(rel_path) {
            return Ok(());
        }

        for file in fs::read_dir(path)? {
            let file = file?;
            let abs_file_path = file.path();
            if abs_file_path.is_file() {

                let rel_file_path = abs_file_path.strip_prefix(&self.path).unwrap();
                if self.ignored.contains(rel_file_path) {
                    continue;
                }

                match abs_file_path.extension() {
                    Some(ex) => match ex.to_str() {
                        Some("md") => self.add_note(&abs_file_path),
                        _ => self.add_attachment(abs_file_path),
                    },
                    None => self.add_attachment(abs_file_path),
                }
            } else if abs_file_path.is_dir() {
                self.add_dir(&abs_file_path)?;
            }
        }
        Ok(())
    }

    pub fn index(&mut self) {
        let mut tags = vec![];
        let mut links = vec![];

        for note in self.notes_mut() {
            note.backlinks.clear();
            note.index();

            let name = normalize(note.name.clone());

            tags.extend(note.tags.iter().map(|tag| (tag.clone(), name.clone())));

            links.extend(note.links.iter().map(|link| (name.clone(), link.clone())))
        }

        // Insert the tags
        for (tag, name) in tags {
            self.tags.entry(tag).or_default().insert(name);
        }

        // Insert the links
        for (from, to) in links {
            // Link
            {
                let Some(from_note) = self.get_note_mut(&from) else {
                    eprintln!("WARNING: Could not find note: '{}'", from);
                    continue;
                };

                // TODO: Add path instead of link
                from_note.add_link(to.clone());
            }

            // Backlink
            {
                if let Some(to_note) = self.get_note_mut(&to) {
                    to_note.add_backlink(from.clone());
                    continue;
                };

                if let Some(_to_attachment) = self.get_attachment_mut(&to) {
                    continue;
                };

                self.dangling_links
                    .entry(from)
                    .and_modify(|links| links.push(to.clone()))
                    .or_insert(vec![to]);
            }
        }
    }

    fn get_item(&self, normalized_name: &String) -> Option<&VaultItem> {
        self.items.get(normalized_name)
    }

    fn get_item_mut(&mut self, normalized_name: &String) -> Option<&mut VaultItem> {
        self.items.get_mut(normalized_name)
    }

    pub fn get_note(&self, normalized_name: &String) -> Option<&Note> {
        match self.get_item(normalized_name) {
            Some(VaultItem::Note { note }) => Some(note),
            _ => None,
        }
    }

    fn get_note_mut(&mut self, normalized_name: &String) -> Option<&mut Note> {
        match self.get_item_mut(normalized_name) {
            Some(VaultItem::Note { note }) => Some(note),
            _ => None,
        }
    }

    pub fn get_attachment(&self, normalized_name: &String) -> Option<&Attachment> {
        match self.get_item(normalized_name) {
            Some(VaultItem::Attachment { attachment }) => Some(attachment),
            _ => None,
        }
    }

    fn get_attachment_mut(&mut self, normalized_name: &String) -> Option<&mut Attachment> {
        match self.get_item_mut(normalized_name) {
            Some(VaultItem::Attachment { attachment }) => Some(attachment),
            _ => None,
        }
    }
}
