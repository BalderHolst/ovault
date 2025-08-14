#[cfg(feature = "python")]
use pyo3::prelude::*;

mod vault;
mod lexer;
mod normalize;

pub use vault::Vault;
pub use lexer::{
    Token,
    Callout,
    InternalLink,
    ExternalLink,
    Span,
};

/// Python module for managing an [Obsidian](https://obsidian.md/) vault.
#[doc = include_str!("../documentation.md")]
#[cfg(feature = "python")]
#[pymodule]
mod ovault {
    use super::*;

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
