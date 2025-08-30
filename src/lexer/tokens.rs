//! This module defines the `Token` enum and related structs to represent different parts of a note.

use std::fmt;

#[cfg(feature = "python")]
use pyo3::{pyclass, pymethods};

use super::Span;

/// Represents a part of a note, such as text, code blocks, links, etc.
///
/// ## Example - Token Stream
/// A note might contain the following:
///
/// ```markdown
/// # Heading
/// This is a paragraph with a [link](https://example.com).
/// ```
///
/// This would be represented as a sequence of `Token` instances:
/// ```text
/// - `Token::Header { level: 1, heading: "Heading" }`
/// - `Token::Text { text: "This is a paragraph with a " }`
/// - `Token::ExternalLink { link: ... }`
/// - `Token::Text { text: "." }`
/// ```
///
/// ## Example - Find Headings
/// To find all headings in a note, you can iterate over the tokens:
/// ```python
#[doc = include_str!("../../examples/3_find_headings.py")]
/// ```
#[cfg_attr(feature = "python", pyclass)]
#[derive(Debug, Clone, PartialEq)]
#[rustfmt::skip]
pub enum Token {

    /// Represents the frontmatter of a note, which is typically YAML formatted metadata.
    ///
    /// NOTE: This can only appear as the first token in a note.
    Frontmatter {
        /// The span of the frontmatter in the source text.
        span: Span,
        /// The YAML content of the frontmatter
        yaml: String
    },

    /// Represents a block of text in the note.
    Text {
        /// The span of the frontmatter in the source text.
        span: Span,
        /// The text content of the token.
        text: String
    },

    /// Represents a tag in the note
    Tag {
        /// The span of the tag in the source text.
        span: Span,
        /// The tag name without the leading `#`.
        ///
        /// Example: `#tag` would be represented as `tag`.
        tag: String
    },

    /// Represents a header in the note, which can be of different levels.
    ///
    /// Example:
    /// ```text
    /// # First   => level = 1
    /// ## Second => level = 2
    /// ### Third => level = 3
    /// ```
    Header {
        /// The span of the tag in the source text.
        span: Span,
        /// The level of the header, where `1` is the highest level (e.g., `#`),
        level: usize,
        /// The heading text of the header.
        heading: String
    },

    /// Represents a code block in the note.
    ///
    /// Example:
    /// ````markdown
    /// ```python
    /// def hello_world():
    ///     print("Hello, world!")
    /// ```
    /// ````
    Code {
        /// The span of the code block in the source text.
        span: Span,
        /// The programming language of the code block, if specified.
        lang: Option<String>,
        /// The code content of the block.
        code: String
    },

    /// Represents a block quote in the note.
    Quote {
        /// The span of the quote in the source text.
        span: Span,
        /// The tokenized contents of the quote.
        tokens: Vec<Token>,
        /// The text content of the quote.
        text: String,
    },

    /// Represents inline mathematical expressions in the note.
    InlineMath {
        /// The span of the inline math in the source text.
        span: Span,
        /// The LaTeX representation of the inline math.
        latex: String
    },

    /// Represents display mathematical expressions in the note.
    DisplayMath {
        /// The span of the display math in the source text.
        span: Span,
        /// The LaTeX representation of the display math.
        latex: String
    },

    /// Represents a horizontal divider in the note.
    Divider {
        /// The span of the divider in the source text.
        span: Span
    },

    /// Represents a callout block in the note.
    Callout {
        /// The span of the callout in the source text.
        span: Span,
        /// The callout object containing its data.
        callout: Callout
    },

    /// Represents an internal link to another note within the vault.
    InternalLink {
        /// The span of the internal link in the source text.
        span: Span,
        /// The internal link object containing its data.
        link: InternalLink
    },

    /// Represents an external link to a URL.
    ExternalLink {
        /// The span of the external link in the source text.
        span: Span,
        /// The external link object containing its data.
        link: ExternalLink
    },

    // TODO: Numerated lists
    /// Represents a bulleted or numbered list in the note.
    ///
    /// Example:
    /// ```markdown
    /// - Item 1
    /// - Item 2
    ///   - Subitem 2.1
    /// ```
    List {
        /// The span of the list in the source text.
        span: Span,
        /// The items in the list.
        items: Vec<ListItem>,
    },

    /// Represents a checklist in the note.
    ///
    /// Example:
    /// ```markdown
    /// - [x] Completed item
    /// - [ ] Incomplete item
    /// ```
    CheckList {
        /// The span of the checklist in the source text.
        span: Span,
        /// The items in the checklist.
        items: Vec<CheckListItem>,
    },

    // Represents a Templater command in the note.
    //
    /// Example:
    /// ```markdown
    /// <% tp.file.include("path/to/file.md") %>
    /// ```
    TemplaterCommand {
        /// The span of the Templater command in the source text.
        span: Span,
        /// The command name.
        command: String,
    },
}

impl fmt::Display for Token {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> std::fmt::Result {
        let name = match self {
            Token::Text { .. } => "Text",
            Token::Tag { .. } => "Tag",
            Token::Header { .. } => "Header",
            Token::InternalLink { .. } => "InternalLink",
            Token::ExternalLink { .. } => "ExternalLink",
            Token::Code { .. } => "Code",
            Token::Callout { .. } => "Callout",
            Token::Quote { .. } => "Quote",
            Token::Frontmatter { .. } => "Frontmatter",
            Token::InlineMath { .. } => "InlineMath",
            Token::DisplayMath { .. } => "DisplayMath",
            Token::Divider { .. } => "Divider",
            Token::List { .. } => "List",
            Token::CheckList { .. } => "CheckList",
            Token::TemplaterCommand { .. } => "TemplaterCommand",
        };
        write!(f, "{}", name)
    }
}

#[cfg(feature = "python")]
#[pymethods]
impl Token {
    /// String representation of the token.
    pub fn __repr__(&self) -> String {
        const MAX_LEN: usize = 20;
        fn string(s: &str) -> String {
            let mut new_s = String::from(s);
            if new_s.len() > MAX_LEN {
                new_s = format!("{}...", &new_s.chars().take(MAX_LEN).collect::<String>());
                new_s = new_s.trim_end().to_string();
            }
            new_s.replace("\n", "\\n")
        }

        match self {
            Token::Text { text, .. } => format!("Text({})", string(text)),
            Token::Tag { tag, .. } => format!("Tag({})", string(tag)),
            Token::Header { level, heading, .. } => {
                format!("Header({} {})", "#".repeat(*level), string(heading))
            }
            Token::InternalLink { link, .. } => format!("InternalLink({})", link.label()),
            Token::ExternalLink { link, .. } => format!("ExternalLink({})", link.label()),
            Token::Code { lang, code, .. } => match lang {
                Some(lang) => format!("Code({}: {})", string(lang), string(code)),
                None => format!("Code({})", string(code)),
            },
            Token::Callout { callout, .. } => {
                format!(
                    "Callout({})",
                    &format!(
                        "{}: {}",
                        callout.kind,
                        callout
                            .tokens
                            .first()
                            .map_or("<no contents>".to_string(), |t| string(&t.__repr__()))
                    )
                )
            }
            Token::Quote { text, .. } => {
                format!("Quote({})", string(&format!("{:?}", text)))
            }
            Token::Frontmatter { yaml, .. } => format!("Frontmatter({})", string(yaml)),
            Token::InlineMath { latex, .. } => format!("InlineMath({})", string(latex)),
            Token::DisplayMath { latex, .. } => format!("DisplayMath({})", string(latex)),
            Token::Divider { .. } => "Divider".to_string(),
            Token::List { items, .. } => {
                let item_strs: Vec<String> = items
                    .iter()
                    .map(|item| {
                        let content_strs: Vec<String> =
                            item.tokens.iter().map(|t| t.__repr__()).collect();
                        format!("ListItem([{}])", content_strs.join(", "))
                    })
                    .collect();
                format!("List([{}])", item_strs.join(", "))
            }
            Token::CheckList { items, .. } => {
                let item_strs: Vec<String> = items
                    .iter()
                    .map(|item| {
                        let content_strs: Vec<String> =
                            item.tokens.iter().map(|t| t.__repr__()).collect();
                        format!("CheckListItem([{}])", content_strs.join(", "))
                    })
                    .collect();
                format!("CheckList([{}])", item_strs.join(", "))
            }
            Token::TemplaterCommand { command, .. } => {
                format!("TemplaterCommand({})", string(command))
            }
        }
    }
}

impl Token {
    /// Get the span of the token.
    pub fn span(&self) -> &Span {
        match self {
            Token::Frontmatter { span, .. }
            | Token::Text { span, .. }
            | Token::Tag { span, .. }
            | Token::Header { span, .. }
            | Token::Code { span, .. }
            | Token::Quote { span, .. }
            | Token::InlineMath { span, .. }
            | Token::DisplayMath { span, .. }
            | Token::Divider { span, .. }
            | Token::Callout { span, .. }
            | Token::InternalLink { span, .. }
            | Token::ExternalLink { span, .. }
            | Token::List { span, .. }
            | Token::CheckList { span, .. }
            | Token::TemplaterCommand { span, .. } => span,
        }
    }

    /// Get a mutable reference to the span of the token.
    pub fn span_mut(&mut self) -> &mut Span {
        match self {
            Token::Frontmatter { span, .. }
            | Token::Text { span, .. }
            | Token::Tag { span, .. }
            | Token::Header { span, .. }
            | Token::Code { span, .. }
            | Token::Quote { span, .. }
            | Token::InlineMath { span, .. }
            | Token::DisplayMath { span, .. }
            | Token::Divider { span, .. }
            | Token::Callout { span, .. }
            | Token::InternalLink { span, .. }
            | Token::ExternalLink { span, .. }
            | Token::List { span, .. }
            | Token::CheckList { span, .. }
            | Token::TemplaterCommand { span, .. } => span,
        }
    }

    /// Check if the token is a whitespace token.
    pub fn is_whitespace(&self) -> bool {
        match self {
            Token::Text { text, .. } => text.chars().all(char::is_whitespace),
            Token::Tag { .. }
            | Token::Header { .. }
            | Token::InternalLink { .. }
            | Token::ExternalLink { .. }
            | Token::Code { .. }
            | Token::Callout { .. }
            | Token::Quote { .. }
            | Token::Frontmatter { .. }
            | Token::Divider { .. }
            | Token::InlineMath { .. }
            | Token::DisplayMath { .. }
            | Token::List { .. }
            | Token::CheckList { .. }
            | Token::TemplaterCommand { .. } => false,
        }
    }
}

/// Represents an external link to an external URL.
///
/// Example:
/// ```markdown
/// ![alt text](https://imageimage--link.domain)
/// [show_how](https://github.com/BalderHolst)
/// ```
#[cfg_attr(feature = "python", pyclass(get_all, set_all))]
#[derive(Debug, Clone, PartialEq)]
pub struct ExternalLink {
    /// Whether the link should be rendered as an image or video.
    pub render: bool,
    /// The URL of the link.
    pub url: String,
    /// The text that will be displayed for the link.
    pub show_how: String,
    /// Additional options for the link, such as size or alignment.
    pub options: Option<String>,
    /// The section in the linked document where the link should point to.
    pub position: Option<String>,
}

impl ExternalLink {
    /// Returns the label for the link, which is either the `show_how` text or the URL.
    pub fn label(&self) -> &str {
        if self.show_how.is_empty() {
            self.url.as_str()
        } else {
            self.show_how.as_str()
        }
    }
}

#[cfg(feature = "python")]
#[pymethods]
impl ExternalLink {
    fn __repr__(&self) -> String {
        format!(
            "ExternalLink(url: {}, show_how: {}, options: {:?}, position: {:?}, render: {})",
            self.url, self.show_how, self.options, self.position, self.render
        )
    }
}

/// Represents an internal link to another note.
///
/// Example:
/// ```markdown
/// ![[note_name#position|display text]]
/// ```
#[cfg_attr(feature = "python", pyclass(get_all, set_all))]
#[derive(Debug, Clone, PartialEq)]
pub struct InternalLink {
    /// The destination of the link, which is the name of the note.
    pub dest: String,
    /// The section in the linked document where the link should point to.
    pub position: Option<String>,
    /// The text that will be displayed for the link.
    pub show_how: Option<String>,
    /// Additional options for the link, such as size or alignment.
    pub options: Option<String>,
    /// Whether the link should be rendered as an image, video or note.
    pub render: bool,
}

impl InternalLink {
    /// Returns the label for the link, which is either the `show_how` text or the destination.
    pub fn label(&self) -> String {
        let l = match &self.show_how {
            Some(s) => return s.to_owned(),
            None => self.dest.as_str(),
        }
        .to_string();
        match &self.position {
            Some(pos) => format!("{}>{}", l, pos),
            None => l,
        }
    }
}

/// Represents a callout block in the document.
///
/// Example:
/// ```markdown
/// > [!note]- Title
/// > This is a note callout.
/// ```
#[cfg_attr(feature = "python", pyclass(get_all, set_all))]
#[derive(Debug, Clone, PartialEq)]
pub struct Callout {
    /// The kind of callout, such as "note", "tip", "warning", etc.
    pub kind: String,
    /// The title of the callout.
    pub title: String,
    /// The tokenized content of the callout, which can include text, code blocks, links, etc.
    pub tokens: Vec<Token>,
    /// The text content of the callout.
    pub text: String,
    /// Whether the callout can be folded or collapsed.
    pub foldable: bool,
}

/// Represents a single item in a list.
#[derive(Debug, Clone, PartialEq)]
#[cfg_attr(feature = "python", pyclass(get_all))]
pub struct ListItem {
    /// The span of the list item in the source text.
    pub span: Span,
    /// The indentation level of the list item, which indicates its nesting level.
    pub indent: usize,
    /// The tokenized content of the list item
    pub tokens: Vec<Token>,
}

/// Represents a single item in a checklist.
#[derive(Debug, Clone, PartialEq)]
#[cfg_attr(feature = "python", pyclass(get_all))]
pub struct CheckListItem {
    /// Whether the checklist item is checked or not.
    pub checked: bool,
    /// The span of the checklist item in the source text.
    pub span: Span,
    /// The indentation level of the checklist item, which indicates its nesting level.
    pub indent: usize,
    /// The tokenized content of the checklist item
    pub tokens: Vec<Token>,
}
