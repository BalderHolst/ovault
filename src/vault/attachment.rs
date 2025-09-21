//! Definition of an [Attachment] in an Obsidian vault.

use std::{collections::HashSet, path::PathBuf};

#[cfg(feature = "python")]
use pyo3::prelude::*;

/// An attachment in an Obsidian vault. An attachment is any
/// file that is not a markdown file.
#[derive(Debug, Clone, PartialEq)]
#[cfg_attr(feature = "python", pyclass(get_all))]
pub struct Attachment {
    /// Absolute path to the vault root.
    pub vault_path: PathBuf,

    /// Path to the attachment file.
    pub path: PathBuf,

    /// List of paths to markdown files that link to this attachment.
    pub backlinks: HashSet<String>,
}

impl Attachment {
    /// Create a new [Attachment] object.
    pub fn new(vault_path: PathBuf, path: PathBuf) -> Self {
        Self {
            vault_path,
            path,
            backlinks: HashSet::new(),
        }
    }

    /// Get the full (absolute) path to the attachment file.
    pub fn full_path(&self) -> PathBuf {
        self.vault_path.join(&self.path)
    }

    pub(crate) fn add_backlink(&mut self, backlink: String) {
        self.backlinks.insert(backlink);
    }
}

#[cfg(feature = "python")]
#[pymethods]
impl Attachment {
    /// Get the full (absolute) path to the attachment file as a string.
    #[pyo3(name = "full_path")]
    pub fn py_full_path(&self) -> String {
        self.full_path().to_string_lossy().to_string()
    }

    /// Read the attachment file as bytes.
    #[pyo3(name = "read_bytes")]
    pub fn py_read_bytes(&self) -> PyResult<Vec<u8>> {
        std::fs::read(self.full_path()).map_err(|e| {
            PyErr::new::<pyo3::exceptions::PyIOError, _>(format!(
                "Failed to read attachment: {}",
                e
            ))
        })
    }

    fn __repr__(&self) -> String {
        format!("Attachment({})", self.path.display())
    }

    fn __eq__(&self, other: &Attachment) -> bool {
        self == other
    }

    fn __lt__(&self, other: &Attachment) -> bool {
        self.path < other.path
    }
}
