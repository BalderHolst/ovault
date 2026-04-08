use std::path::PathBuf;



fn main() {

    let mut args = std::env::args();

    let _program = args.next().expect("There should always be a program");

    let Some(dylib_path) = args.next() else {
        eprintln!("Please provide a dylib path");
        return;
    };


    let pymodule = match pyo3_introspection::introspect_cdylib(dylib_path, "ovault") {
        Ok(m) => m,
        Err(e) => {
            eprintln!("Could not introspect dylib: {e}");
            return;
        }
    };

    let stubs = pyo3_introspection::module_stub_files(&pymodule);

    let stub_file = PathBuf::from("__init__.pyi");

    assert!(stubs.len() == 1); // We only expect "__init__.pyi"

    let stub_str = stubs[&stub_file].as_str();

    print!("{stub_str}")
}
