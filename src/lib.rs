use lexer::Token;
use pyo3::{pymodule, types::{PyModule, PyModuleMethods}, Bound, PyResult};
use vault::Vault;

mod vault;
mod lexer;

pub fn add(left: u64, right: u64) -> u64 {
    left + right
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn it_works() {
        let result = add(2, 2);
        assert_eq!(result, 4);
    }
}

#[pymodule]
fn pyvault(m: &Bound<'_, PyModule>) -> PyResult<()> {
    m.add_class::<Vault>()?;
    m.add_class::<Token>()?;
    Ok(())
}

