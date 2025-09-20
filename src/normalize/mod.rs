//! Defines the `normalize` function to normalize note names for Obsidian links.

#[cfg(feature = "python")]
use pyo3::prelude::*;

#[cfg(test)]
mod tests;

#[cfg_attr(feature = "python", pyfunction)]
/// Nomalize a note name or path to be used in Obsidian links.
///
/// Example:
/// ```python
/// normalize("My Note") => "my-note"
/// ```
pub fn normalize(name: String) -> String {
    // Trim leading and trailing whitespace

    let mut name = name.trim();

    name = name.strip_prefix('/').unwrap_or(name);

    // Strip ".md" suffix if present
    let name = name.strip_suffix(".md").unwrap_or(name);

    // Trim spaces in each path component
    let name = name
        .split('/')
        .map(|part| part.trim())
        .filter(|part| !part.is_empty())
        .collect::<Vec<&str>>()
        .join("/");

    // Replace spaces with hyphens
    let name = name
        .chars()
        .map(|c| match c {
            ' ' => '-',
            _ => c.to_lowercase().next().unwrap(),
        })
        .collect::<String>();

    // Remove repeated '-'
    let name = name
        .split('-')
        .filter(|part| !part.is_empty())
        .map(|part| part.to_string())
        .collect::<Vec<String>>()
        .join("-");

    // Filter other chars away in name
    let name = name.chars().filter(|c| !matches!(c, '\'' | ',')).collect();

    name
}
