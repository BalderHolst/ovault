//! This module provides functionality to work with an Obsidian vault, including indexing notes and attachments, managing tags, and handling dangling links.

pub mod attachment;
pub mod note;

use std::{
    collections::{HashMap, HashSet},
    fs, io,
    path::{Path, PathBuf},
};

#[cfg(feature = "python")]
use pyo3::prelude::*;

use glob::glob;

use crate::{
    lexer::{tokens::Token, ToMarkdown},
    normalize::normalize,
    warn,
};

pub use attachment::Attachment;
pub use note::{frontmatter::Frontmatter, Note};

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

impl VaultItem {
    /// Get the path of the vault item
    pub fn path(&self) -> &PathBuf {
        match self {
            VaultItem::Note { note } => &note.path,
            VaultItem::Attachment { attachment } => &attachment.path,
        }
    }
}

/// An Obsidian vault containing notes and attachments.
#[cfg(not(feature = "python"))]
#[derive(Debug, Clone, PartialEq)]
pub struct Vault {
    /// Maps normalized note names to notes
    items: HashMap<String, Vec<VaultItem>>,

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

    items: HashMap<String, Vec<VaultItem>>,
    tags: HashMap<String, HashSet<String>>,
}

impl Vault {
    const IGNORE_FILE: &str = ".vault-ignore";
    const DEFAULT_IGNORED: &[&'static str] = &[Self::IGNORE_FILE, ".git", ".obsidian", ".trash"];
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
    fn new_raw(vault_path: &Path) -> Self {
        let mut ignored = HashSet::new();

        for def in Self::DEFAULT_IGNORED {
            let matches = Self::eval_glob(vault_path, def)
                .expect("Default ignore pattern should always be valid");

            for path in matches.filter_map(Result::ok) {
                let abs_path = path.canonicalize().unwrap();
                let rel_path = abs_path.strip_prefix(vault_path).unwrap();
                ignored.insert(rel_path.to_path_buf());
            }
        }

        Self {
            path: vault_path.to_path_buf(),
            dangling_links: HashMap::new(),
            items: HashMap::new(),
            tags: HashMap::new(),
            ignored,
        }
    }

    fn path_to_norm_name(&self, mut path: &Path) -> Option<String> {
        if path.is_absolute() {
            path = path.strip_prefix(&self.path).ok()?;
        }
        let path_str = path.to_str()?.to_string();
        Some(normalize(path_str))
    }

    /// Get a note by its path in the vault. Either absolute or relative to the vault path.
    pub fn get_note_by_path(&self, path: &Path) -> Option<&Note> {
        dbg!(path);
        let norm_name = self.path_to_norm_name(path)?;
        dbg!(&norm_name);
        self.get_note(&norm_name)
    }

    /// Get a mutable reference to a note by its path in the vault. Either absolute or relative to the vault path.
    pub fn get_note_by_path_mut(&mut self, path: &Path) -> Option<&mut Note> {
        let norm_name = self.path_to_norm_name(path)?;
        self.get_note_mut(&norm_name)
    }

    fn items(&self) -> impl Iterator<Item = &VaultItem> {
        self.items.values().flatten()
    }

    fn items_mut(&mut self) -> impl Iterator<Item = &mut VaultItem> {
        self.items.values_mut().flatten()
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

    fn eval_glob(vault_path: &Path, gstr: &str) -> Result<glob::Paths, glob::PatternError> {
        let vault_path = vault_path.display();
        let input = match gstr.starts_with("/") {
            true => format!("{}{}", vault_path, gstr),
            false => format!("{}/**/{}", vault_path, gstr),
        };
        glob(&input)
    }

    /// Parse the `.vault-ignore` file in the vault directory.
    pub fn parse_ignore_file(&mut self, path: &PathBuf) -> io::Result<()> {
        if !path.exists() {
            return Ok(());
        }

        let content = fs::read_to_string(path)?;
        for (i, line) in content.lines().enumerate() {
            let line = line.trim();

            // Skip empty lines and comments
            if line.is_empty() || line.starts_with('#') {
                continue;
            }

            let Ok(ignored_paths) = Self::eval_glob(&self.path, line) else {
                warn!(
                    "Could not parse line {} in ignore file '{}'",
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
    pub fn add_note<C: IntoNoteContent>(
        &mut self,
        vault_path: PathBuf,
        content: C,
    ) -> io::Result<PathBuf> {
        let abs_path = self.path.join(vault_path).with_extension("md");
        abs_path.parent().map(fs::create_dir_all).transpose()?;
        fs::write(&abs_path, content.into_content())?;
        self.register_note(&abs_path);
        Ok(abs_path)
    }

    fn insert_item(&mut self, name: String, item: VaultItem) {
        self.items.entry(name).or_default().push(item);
    }

    /// Rename a note in the vault. This will update the note's name, path, and all backlinks to the note.
    ///
    /// The inputs are treated as paths relative to the vault root.
    pub fn rename_note(&mut self, old_name: &str, new_name: &str) -> io::Result<()> {
        let normalized_old = normalize(old_name.to_string());
        let normalized_new = normalize(new_name.to_string());

        let Some(note) = self.get_note_mut(&normalized_old) else {
            return Err(io::Error::new(
                io::ErrorKind::NotFound,
                format!("Note '{}' not found", old_name),
            ));
        };

        let old_path = note.full_path();

        // Update the note's path
        note.path = PathBuf::from(new_name).with_extension("md");

        let new_path = note.full_path();

        if fs::exists(&new_path)? {
            note.path = old_path; // Restore the old path
            return Err(io::Error::new(
                io::ErrorKind::AlreadyExists,
                format!("Path '{}' already exists", new_name),
            ));
        }

        note.name = new_name.to_string();

        // Rename the file on disk
        fs::rename(&old_path, &new_path).map_err(|e| {
            io::Error::other(format!(
                "Could not rename note '{}' to '{}': {}",
                old_path.display(),
                new_path.display(),
                e
            ))
        })?;

        let note = note.clone();

        // Check if there are other items with the same name,
        // if so, we need to use full paths for the links to avoid collisions
        let use_full_path = self
            .items
            .get(&normalized_new)
            .is_some_and(|items| !items.is_empty());

        // Update notes that link to this note
        for backlink in note.backlinks.clone() {
            let Some(backlink_note) = self.get_note_mut(&backlink) else {
                warn!("Could not find note '{}' to update backlink", backlink);
                continue;
            };

            let mut links = backlink_note
                .all_tokens()?
                .filter_map(|token| {
                    if let Token::InternalLink { span, link, .. } = token {
                        if normalize(link.dest.clone()) == normalized_old {
                            return Some((span, link));
                        }
                    }
                    None
                })
                .collect::<Vec<_>>();

            links.reverse();

            for (span, mut link) in links {
                let old_dest = link.dest;
                if link.show_how.is_none() {
                    link.show_how = Some(old_dest);
                }
                match use_full_path {
                    false => link.dest = new_name.to_string(),
                    true => {
                        link.dest = note
                            .path
                            .with_extension("")
                            .to_str()
                            .unwrap_or(new_name)
                            .to_string()
                    }
                }
                let text = link.to_markdown();
                backlink_note.replace_span(span, text)?;
            }
        }

        // Update the vault tag index
        {
            self.tags.retain(|_, notes| {
                notes.retain(|note_name| note_name != &normalized_old);
                !notes.is_empty()
            });

            for tag in note.tags.iter() {
                self.tags
                    .entry(tag.clone())
                    .or_default()
                    .insert(normalized_new.clone());
            }
        }

        // Update the vault item index
        {
            if let Some(mut items) = self.items.remove(&normalized_old) {
                // Get the index of the note in the items vector (there can be multiple items with the same name)
                let index = items
                    .iter()
                    .position(|item| match item {
                        VaultItem::Note { note: n } => n.name == new_name,
                        _ => false,
                    })
                    .ok_or_else(|| {
                        io::Error::new(
                            io::ErrorKind::NotFound,
                            format!("Note '{}' not found in vault items", old_name),
                        )
                    })?;

                // Remove the note from the items vector
                let _item = items.remove(index);

                // Re-insert the remaining items (if any)
                if !items.is_empty() {
                    self.items.insert(normalized_old, items);
                }

                // Insert the renamed note
                self.insert_item(normalized_new, VaultItem::Note { note });
            }
        }

        Ok(())
    }

    /// Rename a tag in the vault.
    pub fn rename_tag(&mut self, old_tag: &str, new_tag: &str) -> io::Result<()> {
        let old_tag = old_tag.strip_prefix('#').unwrap_or(old_tag);
        let new_tag = new_tag.strip_prefix('#').unwrap_or(new_tag);

        if self.tags.contains_key(new_tag) {
            return Err(io::Error::new(
                io::ErrorKind::AlreadyExists,
                format!("Tag '{}' already exists", new_tag),
            ));
        }

        let Some(notes) = self.tags.remove(old_tag) else {
            return Err(io::Error::new(
                io::ErrorKind::NotFound,
                format!("Tag '{}' not found", old_tag),
            ));
        };

        for note_name in &notes {
            let Some(note) = self.get_note_mut(note_name) else {
                warn!("Could not find note '{}' to update tag", note_name);
                continue;
            };

            for token in note.all_tokens()? {
                if let Token::Tag { ref tag, .. } = token {
                    if *tag == old_tag {
                        let span = *token.span();
                        note.replace_span(span, format!("#{}", new_tag).to_string())?;
                    }
                }
            }

            let Ok(Some(mut frontmatter)) = note.frontmatter() else {
                continue;
            };

            let Some(note::frontmatter::FrontmatterItem::Array(tags_list)) =
                frontmatter.get_mut("tags")
            else {
                continue;
            };

            for tag in tags_list {
                let note::frontmatter::FrontmatterItem::String(ref mut tag) = tag else {
                    continue;
                };
                if tag == old_tag {
                    *tag = new_tag.to_string();
                }
            }

            _ = note.set_frontmatter(frontmatter).map_err(|e| {
                warn!(
                    "Could not update frontmatter for note '{}': {}",
                    note.name, e
                );
            });
        }

        self.tags.insert(new_tag.to_string(), notes);

        Ok(())
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
        self.insert_item(normalized_name, VaultItem::Note { note });
    }

    fn register_attachment(&mut self, path: PathBuf) {
        let name = normalize(path.file_name().unwrap().to_str().unwrap().to_string());
        let relpath = path.strip_prefix(&self.path).unwrap().to_path_buf();
        let attachment = Attachment { path: relpath };
        self.insert_item(name, VaultItem::Attachment { attachment });
    }

    /// Add a directory to the vault. This will recursively add all markdown files as note
    pub fn register_dir(&mut self, path: &Path) -> io::Result<()> {
        let Ok(rel_path) = path.strip_prefix(&self.path) else {
            warn!(
                "Can not add directory outside of vault: '{}'",
                path.display()
            );
            return Ok(());
        };

        if path != self.path && self.ignored.contains(rel_path) {
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
                    warn!("Could not find note: '{}'", from);
                    continue;
                };

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

    fn get_item(&self, name: &str) -> Option<&VaultItem> {
        let normalized_name = normalize(name.to_string());

        let last_component = normalized_name
            .rsplit('/')
            .next()
            .unwrap_or(&normalized_name);

        let candidates = self.items.get(last_component)?;

        if candidates.len() == 1 {
            return Some(&candidates[0]);
        }

        // Try to find the item with a matching vault path
        for candidate in candidates {
            let str_path = candidate.path().to_str()?;
            let norm_path = normalize(str_path.to_string());
            if norm_path == normalized_name {
                return Some(candidate);
            }
        }

        // Fallback, return the candidate with the shortest path
        candidates
            .iter()
            .min_by_key(|item| item.path().components().count())
    }

    fn get_item_mut(&mut self, name: &str) -> Option<&mut VaultItem> {
        let normalized_name = normalize(name.to_string());

        let last_component = normalized_name
            .rsplit('/')
            .next()
            .unwrap_or(&normalized_name);

        let candidates = self.items.get_mut(last_component)?;

        if candidates.len() == 1 {
            return Some(&mut candidates[0]);
        }

        // Try to find the item with a matching vault path
        let matched = candidates
            .iter_mut()
            .find(|candidate| {
                let Some(str_path) = candidate.path().to_str() else {
                    return false;
                };
                let norm_path = normalize(str_path.to_string());
                norm_path == normalized_name
            })
            .map(|c| c as *mut VaultItem);

        if let Some(matched) = matched {
            // SAFETY: We have a mutable reference to self, so we can safely return a mutable reference to the matched item
            return unsafe { Some(&mut *matched) };
        }

        // Fallback, return the candidate with the shortest path
        candidates
            .iter_mut()
            .min_by_key(|item| item.path().components().count())
    }

    /// Get a note by its normalized name.
    pub fn get_note(&self, name: &str) -> Option<&Note> {
        match self.get_item(name) {
            Some(VaultItem::Note { note }) => Some(note),
            _ => None,
        }
    }

    fn get_note_mut(&mut self, name: &str) -> Option<&mut Note> {
        match self.get_item_mut(name) {
            Some(VaultItem::Note { note }) => Some(note),
            _ => None,
        }
    }

    /// Get an attachment by its normalized name.
    pub fn get_attachment(&self, name: &str) -> Option<&Attachment> {
        match self.get_item(name) {
            Some(VaultItem::Attachment { attachment }) => Some(attachment),
            _ => None,
        }
    }

    fn get_attachment_mut(&mut self, name: &str) -> Option<&mut Attachment> {
        match self.get_item_mut(name) {
            Some(VaultItem::Attachment { attachment }) => Some(attachment),
            _ => None,
        }
    }
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
        let tag = tag.strip_prefix('#').unwrap_or(tag);
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

    /// Get note by its path in the vault. Either absolute or relative to the vault path.
    #[pyo3(name = "get_note_by_path")]
    pub fn py_get_note_by_path(&self, path: &str) -> Option<Note> {
        self.get_note_by_path(&PathBuf::from(path)).cloned()
    }

    /// Add a note to the vault.
    ///
    /// Use the `reindex` flag or call the `index` method to reindex the vault after adding notes.
    #[pyo3(name = "add_note", signature = (vault_path, content, reindex = false))]
    pub fn py_add_note(
        &mut self,
        vault_path: &str,
        content: &str,
        reindex: bool,
    ) -> PyResult<String> {
        let abs_path = self.add_note(vault_path.into(), content).map_err(|e| {
            pyo3::exceptions::PyIOError::new_err(format!("Could not add note '{vault_path}': {e}"))
        })?;

        if reindex {
            self.index();
        }

        let abs_path_string = abs_path
            .to_str()
            .ok_or(pyo3::exceptions::PyIOError::new_err(format!(
                "Could not convert path to string: '{}'",
                abs_path.display(),
            )))?
            .to_string();

        Ok(abs_path_string)
    }

    /// Rename a note in the vault. This will update the note's name, path, and all backlinks to the note.
    #[pyo3(name = "rename_note")]
    pub fn py_rename_note(&mut self, old_name: &str, new_name: &str) -> PyResult<Note> {
        self.rename_note(old_name, new_name).map_err(|e| {
            pyo3::exceptions::PyIOError::new_err(format!(
                "Could not rename note from '{}' to '{}': {}",
                old_name, new_name, e
            ))
        })?;

        self.get_note(&normalize(new_name.to_string()))
            .cloned()
            .ok_or_else(|| {
                pyo3::exceptions::PyKeyError::new_err(format!(
                    "Note '{}' not found after renaming",
                    new_name
                ))
            })
    }

    /// Rename a tag in the vault. This will update all notes that have the tag.
    #[pyo3(name = "rename_tag")]
    pub fn py_rename_tag(&mut self, old_tag: &str, new_tag: &str) -> PyResult<()> {
        self.rename_tag(old_tag, new_tag).map_err(|e| {
            pyo3::exceptions::PyIOError::new_err(format!(
                "Could not rename tag from '{}' to '{}': {}",
                old_tag, new_tag, e
            ))
        })
    }
}

/// A trait for types that can be converted into note content.
pub trait IntoNoteContent {
    /// Convert into a string that can be used as note content.
    fn into_content(self) -> String;
}

impl IntoNoteContent for String {
    fn into_content(self) -> String {
        self
    }
}

impl IntoNoteContent for &str {
    fn into_content(self) -> String {
        self.to_string()
    }
}

impl IntoNoteContent for Vec<Token> {
    fn into_content(self) -> String {
        self.into_iter().map(|t| t.to_markdown()).collect()
    }
}
