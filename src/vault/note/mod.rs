//! Module for handling notes in an Obsidian vault.

pub mod frontmatter;

use crate::{
    lexer::{tokens::*, Lexer, Span},
    normalize::normalize,
    vault::IntoNoteContent,
    warn,
};
use std::{collections::HashSet, fs, io, path::PathBuf};

use frontmatter::{Frontmatter, FrontmatterItem};

// TODO: Add `hash` method (also for python)
/// A note in an Obsidian vault.
#[derive(Debug, Clone, PartialEq)]
#[cfg_attr(feature = "python", pyclass(get_all))]
pub struct Note {
    /// Path to the vault
    pub vault_path: PathBuf,
    /// Relative path within vault
    pub path: PathBuf,
    /// Name of the note (file name without extension)
    pub name: String,
    /// Length of the note content in characters
    pub length: usize,
    /// Set of tags in the note
    pub tags: HashSet<String>,
    /// Set of backlinks to this note (links from other notes)
    pub backlinks: HashSet<String>,
    /// Set of links to other notes or attachments
    pub links: HashSet<String>,
}

// Rust specific methods
impl Note {
    /// Get the full absolute path to the note file
    pub fn full_path(&self) -> PathBuf {
        self.vault_path.join(&self.path)
    }

    /// Get the frontmatter as a string if it exists
    pub fn frontmatter_string(&self) -> Option<String> {
        match self.tokens().ok()?.next()? {
            Token::Frontmatter { yaml, .. } => Some(yaml),
            _ => None,
        }
    }

    /// Get the frontmatter of the note as a set of key-value pairs
    pub fn frontmatter(&self) -> Result<Option<Frontmatter>, String> {
        let raw = match self.frontmatter_string() {
            Some(s) => s,
            None => return Ok(None),
        };
        let frontmatter = parse_frontmatter(&raw)
            .map_err(|e| format!("Could not parse frontmatter in note '{}': {}", self.name, e))?;
        Ok(Some(frontmatter))
    }

    /// Set the frontmatter of the note. If the note already has frontmatter,
    /// it will be replaced with the new data.
    pub fn set_frontmatter(&mut self, frontmatter: Frontmatter) -> io::Result<()> {
        let yaml = frontmatter.to_yaml(2);
        let mut content = self.content()?;

        match self.frontmatter_string() {
            Some(s) => {
                content = format!("---\n{}\n---\n{}", yaml, &content[s.len()..]);
                fs::write(self.full_path(), content)
            }
            None => {
                content = format!("---\n{}\n---\n{}", yaml, content);
                fs::write(self.full_path(), content)
            }
        }
    }

    /// Now deep is the note within the vault
    pub fn path_debth(&self) -> usize {
        self.path.components().count()
    }

    /// Read the note content to a string
    pub fn content(&self) -> io::Result<String> {
        fs::read_to_string(self.full_path())
    }

    /// Get an iterator if tokens from the note content.
    pub fn tokens(&self) -> io::Result<impl Iterator<Item = Token>> {
        let content = self.content()?;
        Ok(Lexer::new(content))
    }

    /// Get an iterator of all tokens in the note, including those nested
    /// within other tokens (e.g. callouts, quotes, lists).
    pub fn all_tokens(&self) -> io::Result<impl Iterator<Item = Token>> {
        let content = self.content()?;
        Ok(Lexer::new(content).flat_map(|token| {
            let mut tokens = vec![token.clone()];
            match token {
                Token::Callout { callout, .. } => {
                    tokens.extend(callout.tokens.iter().cloned());
                }
                Token::Quote {
                    tokens: qtokens, ..
                } => {
                    tokens.extend(qtokens.iter().cloned());
                }
                Token::List { items, .. } => {
                    for item in items {
                        tokens.extend(item.tokens.iter().cloned());
                    }
                }
                Token::NumericList { items, .. } => {
                    for item in items {
                        tokens.extend(item.tokens.iter().cloned());
                    }
                }
                Token::CheckList { items, .. } => {
                    for item in items {
                        tokens.extend(item.tokens.iter().cloned());
                    }
                }
                Token::Frontmatter { .. }
                | Token::Text { .. }
                | Token::Tag { .. }
                | Token::Header { .. }
                | Token::Code { .. }
                | Token::InlineMath { .. }
                | Token::DisplayMath { .. }
                | Token::Divider { .. }
                | Token::InternalLink { .. }
                | Token::ExternalLink { .. }
                | Token::TemplaterCommand { .. } => {
                    // These tokens do not contain nested tokens
                }
            }
            tokens.into_iter()
        }))
    }

    /// Add a note to the internal list of linked notes.
    pub fn add_link(&mut self, to: String) {
        self.links.insert(to);
    }

    /// Add a backlink to the note's list of backlinks.
    pub fn add_backlink(&mut self, from: String) {
        self.backlinks.insert(from);
    }

    /// Insert a string as a position within the note
    ///
    /// The vault may need to be re-indexed after this operation.
    pub fn insert_at<C: IntoNoteContent>(&mut self, pos: usize, text: C) -> io::Result<()> {
        let text = text.into_content();
        let path = self.full_path();
        let content = fs::read_to_string(path.clone())?;
        let content = format!("{}{}{}", &content[..pos], text, &content[pos..]);
        self.index_content(content.clone());
        fs::write(path, content)
    }

    /// Replace a span of text withing the note with a new string.
    ///
    /// The vault may need to be re-indexed after this operation.
    pub fn replace_span<C: IntoNoteContent>(&mut self, span: Span, text: C) -> io::Result<()> {
        let text = text.into_content();
        let path = self.full_path();
        let content = fs::read_to_string(path.clone())?;
        if span.start > span.end || span.end > content.len() {
            return Err(io::Error::new(
                io::ErrorKind::InvalidInput,
                format!("Span {span:?} is out of bounds"),
            ));
        }
        let (start, end) = span.byte_indexes(&content);
        let new_content = format!("{}{}{}", &content[..start], text, &content[end..]);
        self.index_content(new_content.clone());
        fs::write(path, new_content)
    }

    /// Set the entire content of the note to a new string.
    ///
    /// The vault may need to be re-indexed after this operation.
    pub fn set_content<C: IntoNoteContent>(&mut self, content: C) -> io::Result<()> {
        let content = content.into_content();
        let path = self.full_path();
        self.index_content(content.clone());
        fs::write(path, content)
    }

    /// Update `tags` and `links` fields from note content
    pub fn index(&mut self) {
        let content = match self.content() {
            Ok(ts) => ts,
            Err(e) => {
                warn!(
                    "Could not read file '{}': {}",
                    self.full_path().display(),
                    e
                );
                return;
            }
        };
        self.index_content(content);
    }

    fn index_content(&mut self, content: String) {
        self.links.clear();
        self.tags.clear();
        self.length = content.len();
        let tokens = Lexer::new(content);
        self.index_tokens(tokens);
    }

    fn index_tokens(&mut self, tokens: impl Iterator<Item = Token>) {
        for token in tokens {
            match token {
                Token::Frontmatter { yaml, .. } => {
                    let frontmatter = match parse_frontmatter(&yaml) {
                        Ok(f) => f,
                        Err(e) => {
                            warn!("Could not parse frontmatter in note '{}': {}", self.name, e);
                            continue;
                        }
                    };
                    let Some(FrontmatterItem::Array(tags)) = frontmatter.get("tags") else {
                        continue;
                    };
                    for tag in tags {
                        let FrontmatterItem::String(tag) = tag else {
                            warn!(
                                "Invalid tag in frontmatter of note '{}': {:?}",
                                self.name, tag
                            );
                            continue;
                        };
                        self.tags.insert(tag.clone());
                    }
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
                Token::List { items, .. } => {
                    for item in items {
                        self.index_tokens(item.tokens.iter().cloned());
                    }
                }
                Token::NumericList { items, .. } => {
                    for item in items {
                        self.index_tokens(item.tokens.iter().cloned());
                    }
                }
                Token::CheckList { items, .. } => {
                    for item in items {
                        self.index_tokens(item.tokens.iter().cloned());
                    }
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

#[cfg(feature = "python")]
use pyo3::{prelude::*, types::*, IntoPyObjectExt};
use yaml_rust2::{Yaml, YamlLoader};

// Python specific methods
#[cfg(feature = "python")]
#[pymethods]
impl Note {
    /// Get content note as a list of tokens.
    #[pyo3(name = "tokens")]
    pub fn py_tokens(&self) -> PyResult<Vec<Token>> {
        match self.tokens() {
            Ok(ts) => Ok(ts.collect()),
            Err(e) => Err(e.into()),
        }
    }

    /// Get content note as a list of all tokens, including those nested
    /// within other tokens (e.g. callouts, quotes, lists).
    #[pyo3(name = "all_tokens")]
    pub fn py_all_tokens(&self) -> PyResult<Vec<Token>> {
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

    /// Get the frontmatter as a python dictionary
    #[pyo3(name = "frontmatter")]
    pub fn py_frontmatter<'py>(
        &self,
        py: Python<'py>,
    ) -> PyResult<Option<Bound<'py, Frontmatter>>> {
        match self.frontmatter() {
            Ok(Some(f)) => Ok(Some(Bound::new(py, f)?)),
            Ok(None) => Ok(None),
            Err(e) => Err(pyo3::exceptions::PyException::new_err(e)),
        }
    }

    /// Set the frontmatter of the note from a python dictionary.
    #[pyo3(name = "set_frontmatter")]
    pub fn py_set_frontmatter(&mut self, frontmatter: Frontmatter) -> PyResult<()> {
        self.set_frontmatter(frontmatter)
            .map_err(pyo3::exceptions::PyException::new_err)
    }

    /// Get the normalized name of the node.
    #[pyo3(name = "normalized_name")]
    pub fn py_normalized_name(&self) -> String {
        let path = self.path.to_str().unwrap_or(&self.name);
        normalize(path.to_string())
    }

    /// Read the content of the note and return it as a string
    #[pyo3(name = "read")]
    pub fn py_read(&self) -> io::Result<String> {
        self.content()
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

    /// Replaces the text between two positions in the note with the given text.
    #[pyo3(name = "replace_between")]
    pub fn py_replace_between(&mut self, start: usize, end: usize, text: String) -> PyResult<()> {
        self.py_replace_span(Span { start, end }, text)
    }

    /// Replaces a `Span` in the note with the given text.
    /// This can be used to replace tokens within the note.
    #[pyo3(name = "replace_span")]
    pub fn py_replace_span(&mut self, span: Span, text: String) -> PyResult<()> {
        self.replace_span(span, text).map_err(PyErr::from)
    }

    /// Inserts a string into the note *before* a given token.
    ///
    /// NOTE: The token should originate from this note as this
    /// method uses the internal `Span` of the note to determine
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
    /// method uses the internal `Span` of the note to determine
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

    /// Compare two notes for equality.
    pub fn __eq__(&self, other: &Note) -> bool {
        self == other
    }

    /// Compare two notes for inequality.
    pub fn __ne__(&self, other: &Note) -> bool {
        !self.__eq__(other)
    }

    /// Compare two notes for ordering based on their paths.
    pub fn __lt__(&self, other: &Note) -> bool {
        self.path < other.path
    }

    /// Compare two notes for ordering based on their paths.
    pub fn __le__(&self, other: &Note) -> bool {
        self.path <= other.path
    }

    /// Compare two notes for ordering based on their paths.
    pub fn __gt__(&self, other: &Note) -> bool {
        self.path > other.path
    }

    /// Compare two notes for ordering based on their paths.
    pub fn __ge__(&self, other: &Note) -> bool {
        self.path >= other.path
    }

    /// Get the length of the note in characters.
    pub fn __len__(&self) -> usize {
        self.length
    }

    /// Get a string representation of the note.
    pub fn __repr__(&self) -> String {
        format!("Note({})", self.name)
    }
}

fn parse_frontmatter(frontmatter: &str) -> Result<Frontmatter, String> {
    let yaml = YamlLoader::load_from_str(frontmatter)
        .map_err(|e| format!("Could not parse frontmatter: {}", e))?;

    if yaml.is_empty() {
        return Ok(Frontmatter::new());
    }

    if yaml.len() > 1 {
        warn!("Multiple YAML documents found in frontmatter of note. Only using the first one.")
    }

    let root = match yaml.into_iter().next().unwrap() {
        Yaml::Hash(root) => root,
        other => {
            return Err(format!(
                "Frontmatter must be a key-value (Hash) object, not '{:?}'",
                other
            ))
        }
    };

    let items = root
        .into_iter()
        .map(|(k, v)| {
            let key = k
                .as_str()
                .ok_or_else(|| format!("Frontmatter keys must be a string, not '{:?}'", k))?;
            let value = FrontmatterItem::from(v);
            Ok((key.to_string(), value))
        })
        .collect::<Result<Vec<(String, FrontmatterItem)>, String>>()?;

    Ok(Frontmatter::from(items))
}

/// Convert a `Yaml` object into a python object
#[cfg(feature = "python")]
pub fn yaml_to_python<'py>(py: Python<'py>, yaml: Yaml) -> PyResult<Bound<'py, PyAny>> {
    match yaml {
        Yaml::Real(_) => yaml.as_f64().unwrap().into_bound_py_any(py),
        Yaml::Integer(i) => i.into_bound_py_any(py),
        Yaml::String(s) => s.into_bound_py_any(py),
        Yaml::Boolean(b) => b.into_bound_py_any(py),
        Yaml::Array(yamls) => {
            let list = PyList::empty(py);
            for yaml in yamls {
                list.append(yaml_to_python(py, yaml)?)?;
            }
            Ok((*list).clone())
        }
        Yaml::Hash(map) => {
            let dict = PyDict::new(py);
            for (k, v) in map {
                let k = yaml_to_python(py, k)?;
                let v = yaml_to_python(py, v)?;
                dict.set_item(k, v)?;
            }
            dict.into_bound_py_any(py)
        }
        Yaml::Alias(_) | Yaml::Null | Yaml::BadValue => Ok(PyNone::get(py).as_any().clone()),
    }
}
