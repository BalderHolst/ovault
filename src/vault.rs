use pyo3::{pyclass, pymethods, PyResult};
use std::{collections::HashMap, ffi::OsStr, fs, io, path::PathBuf};

use crate::lexer::{Lexer, Token};

fn remove_extension(path: &PathBuf) -> PathBuf {
    path.parent().unwrap().join(path.file_stem().unwrap())
}

fn normalize_path_to_string_keep_ext(path: &PathBuf) -> String {
    let extension = path.extension();
    let mut path = path.clone();
    path.set_extension("");
    let path = normalize_path_to_string(&path);
    match extension {
        Some(ext) => path + "." + ext.to_str().unwrap(),
        None => path,
    }
}

fn normalize_path_to_string(path: &PathBuf) -> String {
    let components = path.components();
    components
        .map(|s| normalize_string(s.as_os_str().to_str().unwrap().to_string()))
        .collect::<Vec<String>>()
        .join("/")
}

fn normalize_path(path: &PathBuf) -> PathBuf {
    PathBuf::from(normalize_path_to_string_keep_ext(path))
}

fn normalize_name(mut name: String) -> String {
    if name.contains('/') {
        eprintln!("WARNING: Normalizing name with '/': `{name}`. Only using filename.");
        name = name.split_once('/').unwrap().1.to_string();
    }
    return normalize_string(name);
}

// TODO: Use references
fn normalize_string(name: String) -> String {
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
            '.' => false,
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
    tags: Vec<String>,

    #[pyo3(get)]
    backlinks: Vec<String>,

    #[pyo3(get)]
    links: Vec<String>,
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

    fn add_backlink(&mut self, backlink: String) {
        if !self.backlinks.contains(&backlink) {
            self.backlinks.push(backlink);
        }
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
enum VaultItem {
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
    vault_root: PathBuf,


    /// Maps tags to notes with those tags
    tags: HashMap<String, Vec<String>>,
}

#[pymethods]
impl Vault {
    #[new]
    pub fn py_new(path: &str) -> PyResult<Self> {
        let path = PathBuf::from(path);
        let mut v = Self::new(&path);
        v.add_dir(&path)?;
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
}

impl Vault {
    pub fn new(path: &PathBuf) -> Self {
        Self {
            items: HashMap::new(),
            vault_root: path.clone(),
        }
    }

    pub fn items(&self) -> impl Iterator<Item=&VaultItem> {
        self.items.values()
    }

    pub fn items_mut(&mut self) -> impl Iterator<Item=&mut VaultItem> {
        self.items.values_mut()
    }

    pub fn notes(&self) -> impl Iterator<Item=&Note> {
        self.items().filter_map(|item| match item {
            VaultItem::Note { note } => Some(note),
            _ => None,
        })
    }

    pub fn notes_mut(&mut self) -> impl Iterator<Item=&mut Note> {
        self.items_mut().filter_map(|item| match item {
            VaultItem::Note { note } => Some(note),
            _ => None,
        })
    }

    pub fn attachments(&self) -> impl Iterator<Item=&Attachment> {
        self.items().filter_map(|item| match item {
            VaultItem::Attachment { attachment } => Some(attachment),
            _ => None,
        })
    }

    pub fn attachments_mut(&mut self) -> impl Iterator<Item=&mut Attachment> {
        self.items_mut().filter_map(|item| match item {
            VaultItem::Attachment { attachment } => Some(attachment),
            _ => None,
        })
    }

    pub fn set_note(&mut self, note: Note) -> Option<VaultItem> {
        self.items.insert(normalize_name(note.name.clone()), VaultItem::Note { note })
    }

    pub fn add_note(&mut self, path: &PathBuf) {
        let name = path.file_stem().unwrap().to_str().unwrap();
        let tokens: Vec<Token> = match Lexer::from_file(path.as_path()) {
            Ok(lexer) => lexer.collect(),
            Err(e) => {
                eprintln!("ERROR: {:?}\nSkipping file '{}'.", e, path.display());
                return;
            }
        };

        let (frontmatter, tokens) = match tokens.first() {
            Some(Token::Frontmatter { yaml }) => {
                (Some(yaml.clone()), tokens.split_first().unwrap().1.to_vec())
            }
            _ => (None, tokens),
        };

        let note = Note {
            path: path.strip_prefix(&self.vault_root).unwrap().to_path_buf(),
            name: name.to_string(),
            tokens,
            frontmatter,
            links: Vec::new(),
            tags: Vec::new(),
            backlinks: Vec::new(),
        };
        let normalized_name = normalize_name(name.to_string());
        self.items.insert(normalized_name, VaultItem::Note { note });
    }

    fn add_attachment(&mut self, path: PathBuf) {
        let name = normalize_name(path.file_name().unwrap().to_str().unwrap().to_string());
        let relpath = path.strip_prefix(&self.vault_root).unwrap().to_path_buf();
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
        for note in self.notes_mut() {
            for token in &note.tokens {
                match token {
                    Token::Frontmatter { .. } => {}
                    Token::Text { .. } => {}
                    Token::Header { .. } => {}
                    Token::Callout { .. } => {}
                    Token::Quote { .. } => {}
                    Token::Divider { .. } => {}
                    Token::InlineMath { .. } => {}
                    Token::DisplayMath { .. } => {}
                    Token::Tag { tag } => note.tags.push(tag.to_string()),
                    Token::ExternalLink { .. } => {}
                    Token::InternalLink { link } => {
                        // if `dest` field is emply, the link points to itself and we don't have to
                        // do anything in that case.
                        if link.dest.is_empty() {
                            continue;
                        }

                        let to_note_name = normalize_name(link.dest.clone());
                        // let mut to_note = match self.notes.get(&to_note_name) {
                        //     Some(n) => n.clone(),
                        //     None => {
                        //         // Is it an attachment?
                        //         if self.attachments.get(&to_note_name).is_some() {
                        //             continue;
                        //         }

                        //         eprintln!(
                        //             "WARNING [{}]: Could not find linked note: '{}'",
                        //             note_name, to_note_name
                        //         );
                        //         continue;
                        //     }
                        // };

                        // TODO: Add path instead of link
                        note.links.push(to_note_name.clone());

                        // to_note.add_backlink(
                        //     "/".to_string() + &normalize_path_to_string(&hugo_site_path),
                        // );
                        // self.notes.insert(to_note_name, to_note);
                    }
                }
            }
        }
    }

    pub fn tokens_to_string<I>(&self, note: &Note, tokens: I) -> String
    where
        I: IntoIterator<Item = Token>,
    {
        tokens
            .into_iter()
            .map(|token| self.token_to_string(note, &token))
            .collect::<String>()
    }

    fn get_item(&self, normalized_name: &String) -> Option<&VaultItem> {
        self.items.get(normalized_name)
    }

    fn get_note(&self, normalized_name: &String) -> Option<&Note> {
        match self.get_item(normalized_name) {
            Some(VaultItem::Note { note }) => Some(note),
            _ => None,
        }
    }

    fn get_attachment(&self, normalized_name: &String) -> Option<&PathBuf> {
        match self.get_item(normalized_name) {
            Some(VaultItem::Attachment { attachment }) => Some(&attachment.path),
            _ => None,
        }
    }

    fn token_to_string(&self, note: &Note, token: &Token) -> String {
        let mut is_attachment = false;

        match token {
            Token::Text { text } => text.clone(),
            Token::Tag { tag } => format!("#{tag}"),
            Token::Header { level, heading } => format!(
                "{} {}",
                "#".repeat(*level),
                self.tokens_to_string(note, heading.clone()),
            ),
            Token::ExternalLink { link } => todo!("{link:?}"),
            Token::InternalLink { link } => {
                let normalized_name = normalize_name(link.dest.clone());
                let normalized_path = match self.get_note(&normalized_name){
                    Some(note) if note.path.extension() == Some(OsStr::new("md")) => normalize_path_to_string(&remove_extension(&note.path)),
                    Some(note) => normalize_path_to_string(&note.path),

                    // If link does not point to a note
                    None => {
                        match self.get_attachment(&normalized_name) {
                            // Found attachment!
                            Some(p) => {
                                is_attachment = true;
                                normalize_path_to_string_keep_ext(p)
                            },

                            // Remove link if it does not point to anything
                            None => {
                                let s = link.label();
                                // TODO: specify from where in error
                                eprintln!("WARNING: Removing link to '{s}'.");
                                return s.to_owned();
                            }
                        }

                    },
                };
                let url = "../".repeat(note.path_debth()) + normalized_path.as_str();
                let vault_url = "notes/vault/".to_string() + normalized_path.as_str();
                match (is_attachment, link.render, &link.position) {
                    (_, true, None) => format!("![{}]({})", link.label(), url),
                    (_, false, None) => format!("[{}]({})", link.label(), url),
                    // TODO: actually embed things idk
                    (_, true, Some(position))  => format!("![{}#{}]({})", link.label(), position, url),
                    (false, false, Some(_position)) => format!(
                        // TODO: Jump to heading (position) when link is clicked
                        "[{show_how}]({{{{< ref \"{url}\" >}}}})",
                        show_how=link.label(),
                        url=vault_url
                        //pos=position,
                        ),
                    (true, false, Some(position)) => format!(
                        "[{show_how}]({url}#{pos})",
                        show_how=link.label(),
                        pos=position,
                        url=url
                        ),
                }
            },
            Token::Callout { callout } => format!(
                "\n{{{{< callout type=\"{}\" title=\"{}\" foldable=\"{}\" >}}}}\n{}{{{{< /callout >}}}}\n",
                callout.kind,
                self.tokens_to_string(note, callout.title.clone()),
                if callout.foldable { "true" } else { "false" },
                self.tokens_to_string(note, callout.contents.clone()),
            ),
            Token::Quote { contents } => contents.iter().map(|token| "> ".to_string() + self.token_to_string(note, token).as_str()).collect(),
            Token::Frontmatter { .. } => panic!("Frontmatter should never be part of a note body."),
            Token::Divider { .. } => "\n--------------------\n".to_string(),
            Token::InlineMath { latex } => format!("${}$", latex.clone()),
            Token::DisplayMath { latex } => format!("$${}$$", latex.clone()),
        }
    }
}
