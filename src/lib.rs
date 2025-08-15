//! A library for managing an [Obsidian](https://obsidian.md/) vault.

#![warn(missing_docs)]

#[cfg(feature = "python")]
use pyo3::prelude::*;

mod vault;
mod lexer;
mod normalize;

#[cfg(test)]
mod tests;

pub use vault::Vault;
pub use lexer::{
    Token,
    Callout,
    InternalLink,
    ExternalLink,
    Span,
};

#[doc = include_str!("../docs/documentation.md")]
#[cfg(feature = "python")]
#[pymodule]
mod ovault {
    use super::*;

    /// Tokenize a string to a list of tokens.
    #[pyfunction]
    fn text_to_tokens(text: &str) -> Vec<Token> {
        lexer::Lexer::new(text).collect()
    }

    #[pymodule_export] use Vault;
    #[pymodule_export] use Token;
    #[pymodule_export] use Callout;
    #[pymodule_export] use InternalLink;
    #[pymodule_export] use ExternalLink;
    #[pymodule_export] use Span;

    #[pymodule_export] use normalize::normalize;

    #[allow(non_upper_case_globals)]
    #[pymodule_export]
    const __version__: &str = env!("CARGO_PKG_VERSION");
}
