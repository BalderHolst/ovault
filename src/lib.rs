#[cfg(feature = "python")]
use pyo3::{pymodule, types::{PyModule, PyModuleMethods}, Bound, PyResult};

mod vault;
mod lexer;

pub use vault::Vault;
pub use lexer::Token;

#[cfg(feature = "python")]
#[pymodule]
fn ovault(m: &Bound<'_, PyModule>) -> PyResult<()> {
    m.add_class::<vault::Vault>()?;
    m.add_class::<lexer::Token>()?;
    Ok(())
}

