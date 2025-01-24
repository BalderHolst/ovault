use pyo3::{exceptions::PyValueError, pyclass, pymethods, IntoPyObject, PyAny, PyResult, Python};
use std::{
    collections::{HashMap, HashSet},
    fs, io,
    path::PathBuf,
};

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

#[pyclass]
#[derive(Debug, Clone, PartialEq)]
pub struct Note {
    /// Relative path within vault
    #[pyo3(get)]
    path: PathBuf,

    #[pyo3(get)]
    name: String,

    #[pyo3(get)]
    tokens: Vec<Token>,

    #[pyo3(get)]
    frontmatter: Option<String>,

    #[pyo3(get)]
    tags: HashSet<String>,

    #[pyo3(get)]
    backlinks: HashSet<String>,

    #[pyo3(get)]
    links: HashSet<String>,
}

#[pymethods]
impl Note {
    pub fn __repr__(&self) -> String {
        format!("Note({})", self.name)
    }
}

impl Note {
    pub fn path_debth(&self) -> usize {
        self.path.components().count()
    }

    fn add_link(&mut self, link: String) {
        self.links.insert(link);
    }

    fn add_backlink(&mut self, backlink: String) {
        self.backlinks.insert(backlink);
    }
}

#[pyclass]
#[derive(Debug, Clone, PartialEq)]
pub struct Attachment {
    #[pyo3(get, set)]
    path: PathBuf,
}

#[pyclass]
#[derive(Debug, Clone, PartialEq)]
pub enum VaultItem {
    Note { note: Note },
    Attachment { attachment: Attachment },
}

#[pyclass]
#[derive(Debug, Clone, PartialEq)]
pub struct Vault {
    /// Maps normalized note names to notes
    items: HashMap<String, VaultItem>,

    /// Path to Obsidian vault
    #[pyo3(get)]
    path: PathBuf,

    /// Maps tags to notes with those tags
    tags: HashMap<String, HashSet<String>>,
}

#[pymethods]
impl Vault {
    #[new]
    pub fn py_new(path: &str) -> PyResult<Self> {
        let path = PathBuf::from(path);
        let mut v = Self::new(&path);
        v.add_dir(&path)?;
        v.index();
        Ok(v)
    }

    #[pyo3(name = "items")]
    pub fn py_items(&self) -> Vec<VaultItem> {
        self.items.values().cloned().collect()
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

    #[pyo3(name = "get_notes_with_tag")]
    pub fn py_get_notes_with_tag(&self, tag: &str) -> Option<Vec<Note>> {
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

    #[pyo3(name = "get_linked_items")]
    pub fn py_get_linked_items<'py>(
        &self,
        py: Python<'py>,
        name: &str,
    ) -> PyResult<Vec<pyo3::Bound<'py, PyAny>>> {
        let Some(note) = self.get_note(&normalize(name.to_string())) else {
            return PyResult::Err(PyValueError::new_err(format!(
                "Could not find note: '{}'",
                name
            )));
        };

        let mut links = vec![];

        for link in &note.links {
            let Some(item) = self.get_item(link) else {
                continue;
            };

            let obj = match item {
                VaultItem::Note { note } => note.clone().into_pyobject(py)?.into_super(),
                VaultItem::Attachment { attachment } => {
                    attachment.clone().into_pyobject(py)?.into_super()
                }
            };

            links.push(obj);
        }

        Ok(links)
    }
}

impl Vault {
    pub fn new(path: &PathBuf) -> Self {
        Self {
            path: path.clone(),
            items: HashMap::new(),
            tags: HashMap::new(),
        }
    }

    pub fn items(&self) -> impl Iterator<Item = &VaultItem> {
        self.items.values()
    }

    pub fn items_mut(&mut self) -> impl Iterator<Item = &mut VaultItem> {
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

    pub fn set_item(&mut self, item: Note) -> Option<VaultItem> {
        self.items
            .insert(normalize(item.name.clone()), VaultItem::Note { note: item })
    }

    pub fn set_note(&mut self, note: Note) -> Option<VaultItem> {
        self.items
            .insert(normalize(note.name.clone()), VaultItem::Note { note })
    }

    /// Add a note to the vault
    pub fn add_note(&mut self, path: &PathBuf) {
        debug_assert_eq!(path.extension().unwrap(), "md");

        let name = path.file_stem().unwrap().to_str().unwrap();
        let tokens: Vec<Token> = match Lexer::from_file(path.as_path()) {
            Ok(lexer) => lexer.collect(),
            Err(e) => {
                eprintln!("ERROR: {:?}\nSkipping file '{}'.", e, path.display());
                return;
            }
        };

        // Extract frontmatter if it exists
        let (frontmatter, tokens) = match tokens.first() {
            Some(Token::Frontmatter { yaml }) => {
                (Some(yaml.clone()), tokens.split_first().unwrap().1.to_vec())
            }
            _ => (None, tokens),
        };

        let note = Note {
            path: path.strip_prefix(&self.path).unwrap().to_path_buf(),
            name: name.to_string(),
            tokens,
            frontmatter,
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
        match path.file_name().map(|n| n.to_str()) {
            Some(Some(".git"))
            | Some(Some(".obsidian"))
            | Some(Some("Templates"))
            | Some(Some("External"))
            | Some(Some(".trash"))
            | Some(Some("Excalidraw")) => return Ok(()),
            _ => {}
        }

        for file in fs::read_dir(path)? {
            let file = file?;
            let file_path = file.path();
            if file_path.is_file() {
                match file_path.extension() {
                    Some(ex) => match ex.to_str() {
                        Some("md") => self.add_note(&file_path),
                        _ => self.add_attachment(file_path),
                    },
                    None => self.add_attachment(file_path),
                }
            } else if file_path.is_dir() {
                self.add_dir(&file_path)?;
            }
        }
        Ok(())
    }

    pub fn index(&mut self) {
        // New links
        let mut links = vec![];

        // New Tags
        let mut tags = vec![];

        for note in self.notes_mut() {
            for token in &note.tokens {
                match token {
                    Token::Frontmatter { .. }
                    | Token::Text { .. }
                    | Token::Header { .. }
                    | Token::Callout { .. }
                    | Token::Quote { .. }
                    | Token::Divider { .. }
                    | Token::InlineMath { .. }
                    | Token::DisplayMath { .. }
                    | Token::Code { .. }
                    | Token::ExternalLink { .. } => {}
                    Token::Tag { tag } => {
                        note.tags.insert(tag.clone());
                        let name = normalize(note.name.clone());
                        tags.push((tag.clone(), name));
                    }
                    Token::InternalLink { link } => {
                        // if `dest` field is empty, the link points to heading in itself
                        // and we don't have to do anything in that case.
                        if link.dest.is_empty() {
                            continue;
                        }

                        let from = normalize(note.name.clone());
                        let to = normalize(link.dest.clone());
                        links.push((from, to));
                    }
                }
            }
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

                // eprintln!("WARNING: Could not find linked item: '{from}' -> '{to}'");
            }
        }
    }

    fn get_item(&self, normalized_name: &String) -> Option<&VaultItem> {
        self.items.get(normalized_name)
    }

    fn get_item_mut(&mut self, normalized_name: &String) -> Option<&mut VaultItem> {
        self.items.get_mut(normalized_name)
    }

    fn get_note(&self, normalized_name: &String) -> Option<&Note> {
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

    fn get_attachment(&self, normalized_name: &String) -> Option<&Attachment> {
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
