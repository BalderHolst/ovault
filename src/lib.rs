//! A library for managing an [Obsidian](https://obsidian.md/) vault.

#![warn(missing_docs)]

#[cfg(feature = "python")]
use pyo3::prelude::*;

pub mod lexer;
pub mod normalize;
pub mod vault;

mod logging;
#[cfg(test)]
mod tests;

pub use lexer::{tokens::*, Span};
pub use vault::{attachment::Attachment, note::Note, Vault, VaultItem};

#[doc = include_str!("../docs/documentation.md")]
#[cfg(feature = "python")]
#[pymodule]
mod ovault {
    use crate::vault::note::yaml_to_python;

    use super::*;

    /// Tokenize a string to a list of tokens.
    #[pyfunction]
    fn text_to_tokens(text: &str) -> Vec<Token> {
        lexer::Lexer::new(text).collect()
    }

    #[pymodule_export]
    use Attachment;
    #[pymodule_export]
    use Note;
    #[pymodule_export]
    use Vault;
    #[pymodule_export]
    use VaultItem;

    #[pymodule_export]
    use Callout;
    #[pymodule_export]
    use ExternalLink;
    #[pymodule_export]
    use InternalLink;
    #[pymodule_export]
    use Token;

    #[pymodule_export]
    use Span;

    #[pymodule_export]
    use vault::Frontmatter;

    #[pymodule_export]
    use normalize::normalize;

    #[pyfunction]
    fn parse_yaml<'py>(py: Python<'py>, source: &str) -> PyResult<Bound<'py, pyo3::types::PyList>> {
        let yamls = yaml_rust2::YamlLoader::load_from_str(source).map_err(|e| {
            pyo3::exceptions::PySyntaxError::new_err(format!("Could not parse yaml: {e}"))
        })?;
        let list = pyo3::types::PyList::empty(py);
        for yaml in yamls {
            list.append(yaml_to_python(py, yaml)?)?
        }
        Ok(list)
    }

    #[allow(non_upper_case_globals)]
    #[pymodule_export]
    const __version__: &str = env!("CARGO_PKG_VERSION");
}
