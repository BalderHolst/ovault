// Generate the documentation file from the MDX source using txtx.py script.
#[cfg(feature = "python")]
fn build_docs() {
    const SRC: &str = "./docs/documentation.mdx";
    const DST: &str = "./docs/documentation.md";

    const TXTX: &str = "./scripts/txtx.py";

    // Run: ./docs/txtx.py ./docs/documentation.mdx > ./docs/documentation.md

    let result = std::process::Command::new("python3")
        .arg(TXTX)
        .arg(SRC)
        .output()
        .expect("Failed to run txtx.py");

    if !result.status.success() {
        println!(
            "cargo::warning=Could not run txtx.py: {}",
            String::from_utf8_lossy(&result.stderr)
        );
        return;
    }

    std::fs::write(DST, result.stdout).expect("Failed to write documentation.md");
}

fn main() {
    // Build the documentation if the Python feature is enabled
    #[cfg(feature = "python")]
    build_docs();
}
