#[cfg(feature = "python")]
use pyo3::{pyclass, pymethods};

/// Represents a span in the source text.
#[cfg_attr(feature = "python", pyclass(get_all))]
#[derive(Debug, Clone, Copy, Default, PartialEq)]
pub struct Span {
    /// The starting index of the span in the source text.
    pub start: usize,
    /// The ending index of the span in the source text.
    pub end: usize,
}

impl Span {
    /// Shifts the span by a given offset.
    pub fn shift(&mut self, offset: isize) {
        let start = self.start as isize + offset;
        let end = self.end as isize + offset;
        self.start = start as usize;
        self.end = end as usize;
    }

    /// Calculates the line and column number of the span given the source text.
    pub fn line_col(&self, source: &str) -> (usize, usize) {
        let mut line = 1;
        let mut col = 1;

        for (i, c) in source.chars().enumerate() {
            if i >= self.start && i < self.end {
                return (line, col);
            }
            if c == '\n' {
                line += 1;
                col = 1;
            } else {
                col += 1;
            }
        }

        (line, col)
    }

    /// Converts the character indices of the span to byte indices in the source text.
    pub fn byte_indexes(&self, source: &str) -> (usize, usize) {
        let mut indexes = source.char_indices().map(|(i, _)| i);
        let start = indexes.nth(self.start).unwrap_or(source.len());
        let end = indexes
            .nth(self.end - self.start - 1)
            .unwrap_or(source.len());
        (start, end)
    }

    /// Extracts the substring from the source text that corresponds to this span.
    pub fn extract<'a>(&self, source: &'a str) -> &'a str {
        let (start, end) = self.byte_indexes(source);
        if start >= source.len() || end > source.len() {
            return "";
        }
        &source[start..end]
    }
}

#[cfg(feature = "python")]
#[pymethods]
impl Span {
    /// Creates a new `Span` from the given start and end indices.
    #[new]
    fn py_new(start: usize, end: usize) -> Self {
        Span { start, end }
    }
}
