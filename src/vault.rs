use std::{
    collections::{HashMap, HashSet},
    fs, io,
    path::{Path, PathBuf},
};

#[cfg(feature = "python")]
use pyo3::prelude::*;

use glob::glob;
use yaml_rust2::{ScanError, Yaml, YamlLoader};

use crate::{
    lexer::{Lexer, Token},
    normalize::normalize,
};

pub type Frontmatter = HashMap<String, Yaml>;

#[derive(Debug, Clone, PartialEq)]
#[cfg_attr(feature = "python", pyclass(get_all))]
/// A note in an Obsidian vault.
pub struct Note {
    /// Path to the vault
    pub vault_path: PathBuf,
    /// Relative path within vault
    pub path: PathBuf,
    /// Name of the note (file name without extension)
    pub name: String,
    /// Length of the note contents in characters
    pub length: usize,
    /// Set of tags in the note
    pub tags: HashSet<String>,
    /// Set of backlinks to this note (links from other notes)
    pub backlinks: HashSet<String>,
    /// Set of links to other notes or attachments
    pub links: HashSet<String>,
}

// Python specific methods
#[cfg(feature = "python")]
#[pymethods]
impl Note {
    /// Get a string representation of the note.
    pub fn __repr__(&self) -> String {
        format!("Note({})", self.name)
    }

    /// Get the length of the note in characters.
    pub fn __len__(&self) -> usize {
        self.length
    }

    /// Get contents note as a list of tokens.
    #[pyo3(name = "tokens")]
    pub fn py_tokens(&self) -> PyResult<Vec<Token>> {
        match self.tokens() {
            Ok(ts) => Ok(ts.collect()),
            Err(e) => Err(e.into()),
        }
    }

    /// Get the absolute path to the note file.
    #[pyo3(name = "full_path")]
    pub fn py_full_path(&self) -> PathBuf {
        self.full_path()
    }

    /// Get the frontmatter as a string if it exists
    #[pyo3(name = "frontmatter")]
    pub fn py_frontmatter(&self) -> Option<String> {
        todo!()
    }

    /// Get the normalized name of the node.
    #[pyo3(name = "normalized_name")]
    pub fn py_normalized_name(&self) -> String {
        normalize(self.name.clone())
    }

    /// Read the contents of the note and return it as a string
    #[pyo3(name = "read")]
    pub fn py_read(&self) -> io::Result<String> {
        self.contents()
    }

    /// Inserts a string at a position in the note.
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
        self.insert_at(pos, text).map_err(PyErr::from)
    }

    /// Insert a string into the note *before* a given token.
    ///
    /// NOTE: The token should originate from this note as this
    /// method used the internal `Span` of the note to determine
    /// the insertion position.
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

    /// Insert a string into the note *after* a given token.
    ///
    /// NOTE: The token should originate from this note as this
    /// method used the internal `Span` of the note to determine
    /// the insertion position.
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

fn parse_frontmatter(frontmatter: &str) -> Result<Frontmatter, String> {
    let yaml = YamlLoader::load_from_str(&frontmatter)
        .map_err(|e| format!("Could not parse frontmatter: {}", e))?;

    if yaml.is_empty() {
        return Ok(HashMap::new());
    }

    if yaml.len() > 1 {
        return Err("Frontmatter must be a single YAML document".to_string());
    }

    let root = match yaml.into_iter().next().unwrap() {
        Yaml::Hash(root) => root,
        other => {
            return Err(format!(
                "Frontmatter must be a YAML object, not '{:?}'",
                other
            ))
        }
    };

    root.into_iter()
        .map(|(k, v)| {
            let key = k
                .as_str()
                .ok_or_else(|| format!("Frontmatter keys must be a string, not '{:?}'", k))?;
            Ok((key.to_string(), v))
        })
        .collect::<Result<Frontmatter, String>>()
}

// Rust specific methods
impl Note {
    fn full_path(&self) -> PathBuf {
        self.vault_path.join(&self.path)
    }

    /// Get the frontmatter as a string if it exists
    pub fn frontmatter_string(&self) -> Option<String> {
        match self.tokens().ok()?.next()? {
            Token::Frontmatter { yaml, .. } => Some(yaml),
            _ => None,
        }
    }

    pub fn frontmatter(&self) -> Result<Option<Frontmatter>, String> {
        let raw = match self.frontmatter_string() {
            Some(s) => s,
            None => return Ok(None),
        };
        let frontmatter = parse_frontmatter(&raw)
            .map_err(|e| format!("Could not parse frontmatter in note '{}': {}", self.name, e))?;
        Ok(Some(frontmatter))
    }

    /// Now deep is the note within the vault
    pub fn path_debth(&self) -> usize {
        self.path.components().count()
    }

    /// Read the note contents to a string
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

    /// Insert a string as a position within the note
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
                Token::Frontmatter { yaml, .. } => {
                    let frontmatter = match parse_frontmatter(&yaml) {
                        Ok(f) => f,
                        Err(e) => {
                            eprintln!(
                                "WARNING: Could not parse frontmatter in note '{}': {}",
                                self.name, e
                            );
                            continue;
                        }
                    };
                    if let Some(tags) = frontmatter.get("tags").map(|tags| tags.as_vec()).flatten()
                    {
                        for tag in tags {
                            let tag = match tag {
                                Yaml::String(s) => s,
                                _ => {
                                    eprintln!(
                                        "WARNING: Invalid tag in frontmatter of note '{}': {:?}",
                                        self.name, tag
                                    );
                                    continue;
                                }
                            };
                            self.tags.insert(tag.to_string());
                        }
                    };
                }
                Token::Tag { tag, .. } => {
                    self.tags.insert(tag.clone());
                }
                Token::InternalLink { link, .. } => {
                    // if `dest` field is empty, the link points to heading in itself
                    // and we don't have to do anything in that case.
                    // TODO: Maybe add the link anyway?
                    if link.dest.is_empty() {
                        continue;
                    }

                    let to = normalize(link.dest.clone());
                    self.add_link(to);
                }
                Token::Callout { callout, .. } => {
                    self.index_tokens(callout.tokens.iter().cloned());
                }
                Token::Quote { tokens, .. } => {
                    self.index_tokens(tokens.iter().cloned());
                }
                Token::Text { .. }
                | Token::Header { .. }
                | Token::Divider { .. }
                | Token::InlineMath { .. }
                | Token::DisplayMath { .. }
                | Token::Code { .. }
                | Token::ExternalLink { .. }
                | Token::TemplaterCommand { .. } => {}
            }
        }
    }
}

/// An attachment in an Obsidian vault. An attachment is any
/// file that is not a markdown file.
#[derive(Debug, Clone, PartialEq)]
#[cfg_attr(feature = "python", pyclass(get_all))]
pub struct Attachment {
    path: PathBuf,
}

/// An item in an Obsidian vault can be either a note or an attachment.
#[derive(Debug, Clone, PartialEq)]
#[cfg_attr(feature = "python", pyclass)]
pub enum VaultItem {
    /// A note in the vault (markdown file)
    Note {
        /// The note itself
        note: Note,
    },
    /// An attachment in the vault
    Attachment {
        /// The attachment itself
        attachment: Attachment,
    },
}

/// An Obsidian vault containing notes and attachments.
#[cfg(not(feature = "python"))]
#[derive(Debug, Clone, PartialEq)]
pub struct Vault {
    /// Maps normalized note names to notes
    pub items: HashMap<String, VaultItem>,

    /// Path to Obsidian vault
    pub path: PathBuf,

    /// Paths that were ignored during indexing
    pub ignored: HashSet<PathBuf>,

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
    /// Path to Obsidian vault directory
    #[pyo3(get)]
    pub path: PathBuf,

    /// A map of dangling links. The key is the note name and the value is a
    /// list of links that point to non-existing notes or attachments.
    #[pyo3(get)]
    pub dangling_links: HashMap<String, Vec<String>>,

    /// Paths that were ignored during indexing
    #[pyo3(get)]
    pub ignored: HashSet<PathBuf>,

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
    /// Create a new vault from the given path. The path must be an existing directory.
    ///
    /// The `create` argument determines whether the vault directory should be created
    /// if it does not exist.
    ///
    /// The vault will be indexed on creation, and the `.vault-ignore` file will be parsed
    #[new]
    #[pyo3(signature = (path, create = false))]
    pub fn py_new(path: &str, create: bool) -> PyResult<Self> {
        let path = PathBuf::from(path);

        if create && !path.exists() {
            fs::create_dir_all(&path).map_err(|e| {
                pyo3::exceptions::PyIOError::new_err(format!(
                    "Could not create vault at '{}': {}",
                    path.display(),
                    e
                ))
            })?;
        }

        let path = path.canonicalize().map_err(|e| {
            pyo3::exceptions::PyFileNotFoundError::new_err(format!(
                "Could not find vault at '{}': {}",
                path.display(),
                e
            ))
        })?;
        Ok(Self::new(&path)?)
    }

    /// Get a list of all notes in the vault. Order is not guaranteed.
    #[pyo3(name = "notes")]
    pub fn py_notes(&self) -> Vec<Note> {
        self.notes().cloned().collect()
    }

    /// Get a list of all attachments in the vault. Order is not guaranteed.
    #[pyo3(name = "attachments")]
    pub fn py_attachments(&self) -> Vec<Attachment> {
        self.attachments().cloned().collect()
    }

    /// Get a list of all tags in the vault. Order is not guaranteed.
    #[pyo3(name = "tags")]
    pub fn py_tags(&self) -> Vec<String> {
        self.tags.keys().cloned().collect()
    }

    /// Index the vault. This will clear the current index and re-index the vault.
    ///
    /// This is useful if you have edited, added or removed notes or attachments from the vault.
    #[pyo3(name = "index")]
    pub fn py_index(&mut self) -> PyResult<()> {
        self.items.clear();
        self.tags.clear();
        let path = self.path.clone();
        self.register_dir(&path).map_err(PyErr::from)?;
        self.index();
        Ok(())
    }

    /// Get all notes that have the given tag.
    #[pyo3(name = "get_notes_by_tag")]
    pub fn py_get_notes_by_tag(&self, tag: &str) -> Vec<Note> {
        let Some(tag) = self.tags.get(tag) else {
            return vec![];
        };
        tag.iter()
            .filter_map(|name| self.get_note(name))
            .cloned()
            .collect()
    }

    /// Get note by its name.
    #[pyo3(name = "get_note_by_name")]
    pub fn py_get_note(&self, name: &str) -> Option<Note> {
        self.get_note(&normalize(name.to_string())).cloned()
    }

    /// Add a note to the vault.
    ///
    /// Call the `index` method to reindex the vault after adding notes.
    #[pyo3(name = "add_note")]
    pub fn py_add_note(&mut self, vault_path: &str, contents: &str) -> PyResult<String> {
        let abs_path = self.add_note(vault_path.into(), contents).map_err(|e| {
            pyo3::exceptions::PyIOError::new_err(format!("Could not add note '{vault_path}': {e}"))
        })?;

        let abs_path_string = abs_path
            .to_str()
            .ok_or(pyo3::exceptions::PyIOError::new_err(format!(
                "Could not convert path to string: '{}'",
                abs_path.display(),
            )))?
            .to_string();

        Ok(abs_path_string)
    }
}

impl Vault {
    /// Create a new vault from the given path.
    ///
    /// The path must be an existing directory.
    ///
    /// The vault will be indexed on creation, and the `.vault-ignore` file will be parsed.
    pub fn new(path: &Path) -> io::Result<Self> {
        let mut v = Self::new_raw(path);
        v.parse_ignore_file(&path.join(Self::IGNORE_FILE))?;
        v.register_dir(path)?;
        v.index();
        Ok(v)
    }

    /// Create a new vault without parsing the ignore file, adding the vault directory or indexing it.
    fn new_raw(path: &Path) -> Self {
        let ignored = HashSet::from_iter(Self::DEFAULT_IGNORED.iter().map(PathBuf::from));
        Self {
            path: path.to_path_buf(),
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

    /// Get an iterator over all notes in the vault
    pub fn notes(&self) -> impl Iterator<Item = &Note> {
        self.items().filter_map(|item| match item {
            VaultItem::Note { note } => Some(note),
            _ => None,
        })
    }

    /// Get an iterator over all notes mutably in the vault
    pub fn notes_mut(&mut self) -> impl Iterator<Item = &mut Note> {
        self.items_mut().filter_map(|item| match item {
            VaultItem::Note { note } => Some(note),
            _ => None,
        })
    }

    /// Get an iterator over all attachments in the vault
    pub fn attachments(&self) -> impl Iterator<Item = &Attachment> {
        self.items().filter_map(|item| match item {
            VaultItem::Attachment { attachment } => Some(attachment),
            _ => None,
        })
    }

    /// Get an iterator over all attachments mutably in the vault
    pub fn attachments_mut(&mut self) -> impl Iterator<Item = &mut Attachment> {
        self.items_mut().filter_map(|item| match item {
            VaultItem::Attachment { attachment } => Some(attachment),
            _ => None,
        })
    }

    /// Parse the `.vault-ignore` file in the vault directory.
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

    /// Add a new note to the vault.
    ///
    /// NOTE: Call `index` after adding notes to update the vault state.
    pub fn add_note(&mut self, vault_path: PathBuf, contents: &str) -> io::Result<PathBuf> {
        let abs_path = self.path.join(vault_path).with_extension("md");
        abs_path.parent().map(fs::create_dir_all).transpose()?;
        fs::write(&abs_path, contents)?;
        self.register_note(&abs_path);
        Ok(abs_path)
    }

    /// Register a new note in the vault
    fn register_note(&mut self, path: &Path) {
        assert_eq!(path.extension().unwrap(), "md");

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

    fn register_attachment(&mut self, path: PathBuf) {
        let name = normalize(path.file_name().unwrap().to_str().unwrap().to_string());
        let relpath = path.strip_prefix(&self.path).unwrap().to_path_buf();
        let attachment = Attachment { path: relpath };
        self.items
            .insert(name, VaultItem::Attachment { attachment });
    }

    /// Add a directory to the vault. This will recursively add all markdown files as note
    pub fn register_dir(&mut self, path: &Path) -> io::Result<()> {
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
                        Some("md") => self.register_note(&abs_file_path),
                        _ => self.register_attachment(abs_file_path),
                    },
                    None => self.register_attachment(abs_file_path),
                }
            } else if abs_file_path.is_dir() {
                self.register_dir(&abs_file_path)?;
            }
        }
        Ok(())
    }

    /// Index the vault. This will clear the current index and re-index the vault.
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

    fn get_item(&self, normalized_name: &str) -> Option<&VaultItem> {
        self.items.get(normalized_name)
    }

    fn get_item_mut(&mut self, normalized_name: &str) -> Option<&mut VaultItem> {
        self.items.get_mut(normalized_name)
    }

    /// Get a note by its normalized name.
    pub fn get_note(&self, normalized_name: &str) -> Option<&Note> {
        match self.get_item(normalized_name) {
            Some(VaultItem::Note { note }) => Some(note),
            _ => None,
        }
    }

    fn get_note_mut(&mut self, normalized_name: &str) -> Option<&mut Note> {
        match self.get_item_mut(normalized_name) {
            Some(VaultItem::Note { note }) => Some(note),
            _ => None,
        }
    }

    /// Get an attachment by its normalized name.
    pub fn get_attachment(&self, normalized_name: &str) -> Option<&Attachment> {
        match self.get_item(normalized_name) {
            Some(VaultItem::Attachment { attachment }) => Some(attachment),
            _ => None,
        }
    }

    fn get_attachment_mut(&mut self, normalized_name: &str) -> Option<&mut Attachment> {
        match self.get_item_mut(normalized_name) {
            Some(VaultItem::Attachment { attachment }) => Some(attachment),
            _ => None,
        }
    }
}
