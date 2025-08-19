use crate::{
    lexer::{Lexer, Span, Token},
    normalize::normalize,
};
use std::{
    collections::{HashMap, HashSet},
    fs, io,
    path::PathBuf,
};

#[cfg(feature = "python")]
use pyo3::{prelude::*, types::*, IntoPyObjectExt};
use yaml_rust2::{Yaml, YamlLoader};

pub type Frontmatter = HashMap<String, Yaml>;

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

    /// Get the frontmatter as a python dictionary
    #[pyo3(name = "frontmatter")]
    pub fn py_frontmatter<'py>(&self, py: Python<'py>) -> PyResult<Option<Bound<'py, PyDict>>> {
        let frontmatter = match self.frontmatter() {
            Ok(Some(f)) => f,
            Ok(None) => return Ok(None),
            Err(e) => return Err(pyo3::exceptions::PyException::new_err(e)),
        };
        frontmatter_to_python(py, frontmatter).map(Some)
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
    let yaml = YamlLoader::load_from_str(frontmatter)
        .map_err(|e| format!("Could not parse frontmatter: {}", e))?;

    if yaml.is_empty() {
        return Ok(HashMap::new());
    }

    if yaml.len() > 1 {
        eprintln!("WARNING: Multiple YAML documents found in frontmatter of note. Only using the first one.")
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

    root.into_iter()
        .map(|(k, v)| {
            let key = k
                .as_str()
                .ok_or_else(|| format!("Frontmatter keys must be a string, not '{:?}'", k))?;
            Ok((key.to_string(), v))
        })
        .collect::<Result<Frontmatter, String>>()
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

#[cfg(feature = "python")]
fn frontmatter_to_python<'py>(
    py: Python<'py>,
    frontmatter: Frontmatter,
) -> PyResult<Bound<'py, PyDict>> {
    let dict = PyDict::new(py);
    for (k, v) in frontmatter {
        dict.set_item(k, yaml_to_python(py, v)?)?;
    }
    Ok(dict)
}

// Rust specific methods
impl Note {
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

    /// Now deep is the note within the vault
    pub fn path_debth(&self) -> usize {
        self.path.components().count()
    }

    /// Read the note contents to a string
    pub fn contents(&self) -> io::Result<String> {
        fs::read_to_string(self.full_path())
    }

    pub fn tokens(&self) -> io::Result<impl Iterator<Item = Token>> {
        let contents = self.contents()?;
        Ok(Lexer::new(contents))
    }

    pub fn add_link(&mut self, to: String) {
        self.links.insert(to);
    }

    pub fn add_backlink(&mut self, from: String) {
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

    /// Replace a span of text withing the note with a new string.
    pub fn replace_span(&mut self, span: Span, text: String) -> io::Result<()> {
        let path = self.full_path();
        let contents = fs::read_to_string(path.clone())?;
        if span.start > span.end || span.end > contents.len() {
            return Err(io::Error::new(
                io::ErrorKind::InvalidInput,
                format!("Span {span:?} is out of bounds"),
            ));
        }
        let new_contents = format!(
            "{}{}{}",
            &contents[..span.start],
            text,
            &contents[span.end..]
        );
        self.index_contents(new_contents.clone());
        fs::write(path, new_contents)
    }

    /// Update `tags` and `links` fields from note contents
    pub fn index(&mut self) {
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
                    if let Some(tags) = frontmatter.get("tags").and_then(|tags| tags.as_vec()) {
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
