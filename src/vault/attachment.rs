//! Definition of an [Attachment] in an Obsidian vault.

use std::path::PathBuf;

#[cfg(feature = "python")]
use pyo3::prelude::*;

/// An attachment in an Obsidian vault. An attachment is any
/// file that is not a markdown file.
#[derive(Debug, Clone, PartialEq)]
#[cfg_attr(feature = "python", pyclass(get_all))]
pub struct Attachment {
    /// Path to the attachment file.
    pub path: PathBuf,
}
