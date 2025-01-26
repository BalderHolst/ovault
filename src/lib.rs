#[cfg(feature = "python")]
use pyo3::{pymodule, types::{PyModule, PyModuleMethods}, Bound, PyResult};

mod vault;
mod lexer;

#[cfg(feature = "python")]
#[pymodule]
fn pyvault(m: &Bound<'_, PyModule>) -> PyResult<()> {
    m.add_class::<vault::Vault>()?;
    m.add_class::<lexer::Token>()?;
    Ok(())
}

