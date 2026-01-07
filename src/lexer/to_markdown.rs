#[cfg(feature = "python")]
use pyo3::{pyfunction, Bound, PyAny, PyResult};

use super::tokens::*;

/// Trait for converting an item into a Markdown string representation.
///
/// Token spans have no effect on the output.
pub trait ToMarkdown {
    /// Converts the item to a Markdown string.
    fn to_markdown(&self) -> String;
}

fn tokens_to_markdown(tokens: &[Token]) -> String {
    tokens.iter().map(ToMarkdown::to_markdown).collect()
}

impl ToMarkdown for Token {
    fn to_markdown(&self) -> String {
        match self {
            Token::Frontmatter { span: _, yaml } => format!("---\n{yaml}---\n"),
            Token::Text { span: _, text } => text.clone(),
            Token::Tag { span: _, tag } => format!("#{tag}"),
            Token::Header {
                span: _,
                level,
                heading,
            } => format!("{} {heading}\n", "#".repeat(*level)),
            Token::Bold { tokens, marker, .. }
            | Token::Italic { tokens, marker, .. }
            | Token::Strikethrough { tokens, marker, .. }
            | Token::Highlight { tokens, marker, .. } => {
                let default_marker = match self {
                    Token::Bold { .. } => "**",
                    Token::Italic { .. } => "*",
                    Token::Strikethrough { .. } => "~~",
                    Token::Highlight { .. } => "==",
                    _ => unreachable!(),
                };

                let marker = marker
                    .as_ref()
                    .map(String::as_str)
                    .unwrap_or(default_marker);
                format!(
                    "{marker}{content}{marker}",
                    content = tokens_to_markdown(tokens)
                )
            }
            Token::InlineCode { code, .. } => {
                format!("`{}`", code)
            }
            Token::Code {
                span: _,
                lang,
                code,
            } => format!("```{}\n{}```\n", lang.as_deref().unwrap_or(""), code),
            Token::Quote { span: _, tokens } => format!(
                "> {content}\n",
                content = tokens_to_markdown(tokens).replace('\n', "\n> ")
            ),
            Token::InlineMath { span: _, latex } => format!("${latex}$"),
            Token::DisplayMath { span: _, latex } => format!("$${latex}$$"),
            Token::Divider { span: _ } => "---\n".to_string(),
            Token::Callout { span: _, callout } => callout.to_markdown(),
            Token::InternalLink { span: _, link } => link.to_markdown(),
            Token::ExternalLink { span: _, link } => link.to_markdown(),
            Token::List { span: _, items } => items
                .iter()
                .map(ListItem::to_markdown)
                .collect::<Vec<_>>()
                .join(""),
            Token::NumericList { span: _, items } => items
                .iter()
                .map(NumericListItem::to_markdown)
                .collect::<Vec<_>>()
                .join(""),
            Token::CheckList { span: _, items } => items
                .iter()
                .map(CheckListItem::to_markdown)
                .collect::<Vec<_>>()
                .join(""),
            Token::Table { span: _, table } => {
                let mut s = String::new();

                let rows: Vec<Vec<String>> = table
                    .rows
                    .iter()
                    .map(|row| {
                        row.iter()
                            .map(|cell| tokens_to_markdown(cell))
                            .collect::<Vec<_>>()
                    })
                    .collect();

                let mut widths: Vec<usize> = vec![0; table.headers.len()];

                // Calculate column widths
                {
                    for (i, heading) in table.headers.iter().enumerate() {
                        widths[i] = widths[i].max(heading.len());
                    }

                    for row in &rows {
                        for (i, cell) in row.iter().enumerate() {
                            widths[i] = widths[i].max(cell.len());
                        }
                    }
                }

                let format_row = |row: &[String]| -> String {
                    let mut row_str = String::new();
                    row_str.push('|');
                    for (i, cell) in row.iter().enumerate() {
                        row_str.push(' ');
                        row_str.push_str(&format!("{:width$}", cell, width = widths[i]));
                        row_str.push(' ');
                        row_str.push('|');
                    }
                    row_str.push('\n');
                    row_str
                };

                s += &format_row(&table.headers);

                s += "|";
                for w in &widths {
                    s += &format!(" {} |", "-".repeat(*w));
                }
                s.push('\n');

                for row in &rows {
                    s += &format_row(row);
                }

                s.push('\n');

                s
            }
            Token::Comment { span: _, comment } => format!("%%{comment}%%"),
            Token::Escaped { span: _, character } => format!("\\{character}"),
            Token::TemplaterCommand { span: _, command } => format!("<% {command} %>"),
        }
    }
}

impl ToMarkdown for InternalLink {
    fn to_markdown(&self) -> String {
        let Self {
            dest,
            position,
            show_how,
            options,
            render,
        } = self;

        let mut s = String::new();

        if *render {
            s.push('!');
        }

        s += "[[";

        s += dest;

        if let Some(position) = position {
            s += "#";
            s += position;
        }

        if let Some(options) = options {
            s += "|";
            s += options;
        }

        if let Some(show_how) = show_how {
            s += "|";
            s += show_how;
        }

        s += "]]";
        s
    }
}

impl ToMarkdown for ExternalLink {
    fn to_markdown(&self) -> String {
        let mut s = String::new();

        let Self {
            render,
            url,
            show_how,
            options,
            position,
        } = self;

        if *render {
            s.push('!');
        }

        s += "[";
        s += show_how;

        if let Some(options) = options {
            s += "|";
            s += options;
        }

        s += "](";

        s += url;

        if let Some(position) = position {
            s += "#";
            s += position;
        }

        s += ")";

        s
    }
}

impl ToMarkdown for Callout {
    fn to_markdown(&self) -> String {
        let Callout {
            kind,
            title,
            tokens,
            foldable,
        } = self;
        format!(
            "> [!{kind}]{dash}{space}{title}\n> {content}\n",
            dash = if *foldable { "-" } else { "" },
            space = if self.has_title() { " " } else { "" },
            content = tokens_to_markdown(tokens).replace('\n', "\n> ")
        )
    }
}

impl ToMarkdown for ListItem {
    fn to_markdown(&self) -> String {
        format!(
            "{}- {}\n",
            " ".repeat(self.indent),
            tokens_to_markdown(&self.tokens)
        )
    }
}

impl ToMarkdown for NumericListItem {
    fn to_markdown(&self) -> String {
        format!(
            "{}{}. {}\n",
            " ".repeat(self.indent),
            self.number,
            tokens_to_markdown(&self.tokens)
        )
    }
}

impl ToMarkdown for CheckListItem {
    fn to_markdown(&self) -> String {
        format!(
            "{}- [{}] {}\n",
            " ".repeat(self.indent),
            if self.checked { "x" } else { " " },
            tokens_to_markdown(&self.tokens)
        )
    }
}

/// Converts a Python objects to a Markdown string.
#[cfg(feature = "python")]
#[pyfunction]
#[pyo3(name = "to_markdown")]
pub fn py_to_markdown<'py>(obj: &Bound<'py, PyAny>) -> PyResult<String> {
    use pyo3::types::{PyAnyMethods, PyList, PyListMethods, PyString};

    match obj {
        obj if obj.is_instance_of::<PyString>() => {
            let s = obj.downcast::<PyString>()?;
            Ok(s.to_string())
        }
        obj if obj.is_instance_of::<Token>() => Ok(obj.downcast::<Token>()?.borrow().to_markdown()),
        obj if obj.is_instance_of::<InternalLink>() => {
            Ok(obj.downcast::<InternalLink>()?.borrow().to_markdown())
        }
        obj if obj.is_instance_of::<ExternalLink>() => {
            Ok(obj.downcast::<ExternalLink>()?.borrow().to_markdown())
        }
        obj if obj.is_instance_of::<Callout>() => {
            Ok(obj.downcast::<Callout>()?.borrow().to_markdown())
        }
        obj if obj.is_instance_of::<ListItem>() => {
            Ok(obj.downcast::<ListItem>()?.borrow().to_markdown())
        }
        obj if obj.is_instance_of::<NumericListItem>() => {
            Ok(obj.downcast::<NumericListItem>()?.borrow().to_markdown())
        }
        obj if obj.is_instance_of::<CheckListItem>() => {
            Ok(obj.downcast::<CheckListItem>()?.borrow().to_markdown())
        }
        obj if obj.is_instance_of::<PyList>() => {
            let list = obj
                .downcast::<PyList>()?
                .iter()
                .map(|item| py_to_markdown(&item))
                .collect::<Result<Vec<_>, pyo3::PyErr>>()?;
            Ok(list.join(""))
        }
        other => Err(pyo3::exceptions::PyTypeError::new_err(format!(
            "Cannot convert object of type '{}' to markdown.",
            other.get_type().str()?
        ))),
    }
}
