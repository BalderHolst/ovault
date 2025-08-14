#[cfg(feature = "python")]
use pyo3::prelude::*;

mod vault;
mod lexer;
mod normalize;

pub use vault::Vault;
pub use lexer::Token;

/// Python module for managing an [Obsidian](https://obsidian.md/) vault.
#[cfg(feature = "python")]
#[pymodule]
mod ovault {
    use super::*;

    #[pymodule_export] use Vault;
    #[pymodule_export] use Token;

    #[allow(non_upper_case_globals)]
    #[pymodule_export]
    const __version__: &str = env!("CARGO_PKG_VERSION");
}
