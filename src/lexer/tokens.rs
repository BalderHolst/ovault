//! This module defines the `Token` enum and related structs to represent different parts of a note.

use std::fmt;

#[cfg(feature = "python")]
use pyo3::{pyclass, pymethods};

#[cfg(feature = "python")]
use super::ToMarkdown;

use super::Span;

/// A list of tokens.
pub type Tokens = Vec<Token>;

// TODO: Add footnote support
// TODO: Add nested code block support
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
pub enum Token {
    /// Represents the frontmatter of a note, which is typically YAML formatted metadata.
    ///
    /// NOTE: This can only appear as the first token in a note.
    Frontmatter {
        /// The span of the frontmatter in the source text.
        span: Span,
        /// The YAML content of the frontmatter
        yaml: String,
    },

    /// Represents a comment in the note.
    ///
    /// Example:
    /// ```markdown
    /// %% This is a comment %%
    /// ```
    Comment {
        /// The span of the comment in the source text.
        span: Span,
        /// The comment content.
        comment: String,
    },

    /// Represents a block of text in the note.
    Text {
        /// The span of the frontmatter in the source text.
        span: Span,
        /// The text content of the token.
        text: String,
    },

    /// Represents a tag in the note
    Tag {
        /// The span of the tag in the source text.
        span: Span,
        /// The tag name without the leading `#`.
        ///
        /// Example: `#tag` would be represented as `tag`.
        tag: String,
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
        /// The span of the header in the source text.
        span: Span,
        /// The level of the header, where `1` is the highest level (e.g., `#`),
        level: usize,
        /// The heading text of the header.
        heading: String,
    },

    /// Represents bold text in the note.
    ///
    /// Example:
    /// ```markdown
    /// **This text is bold**
    /// __This text is also bold__
    /// ```
    Bold {
        /// The span of the token in the source text.
        span: Span,
        /// The marker used for bold (e.g., "**" or "__")
        marker: Option<String>,
        /// The tokenized content of the bold text.
        tokens: Vec<Token>,
    },

    /// Represents italic text in the note.
    ///
    /// Example:
    /// ```markdown
    /// *This text is italicized*
    /// _This text is also italicized_
    /// ```
    Italic {
        /// The span of the token in the source text.
        span: Span,
        /// The marker used for italics (e.g., "*" or "_")
        marker: Option<String>,
        /// The tokenized content of the italicized text.
        tokens: Vec<Token>,
    },

    /// Represents strikethrough text in the note.
    ///
    /// Example:
    /// ```markdown
    /// ~~This text is strikethrough~~
    /// ```
    Strikethrough {
        /// The span of the token in the source text.
        span: Span,
        /// The marker used for strikethrough (e.g., "~~")
        marker: Option<String>,
        /// The tokenized content of the strikethrough text.
        tokens: Vec<Token>,
    },

    /// Represents highlighted text in the note.
    ///
    /// Example:
    /// ```markdown
    /// ==This text is highlighted==
    /// ```
    Highlight {
        /// The span of the token in the source text.
        span: Span,
        /// The marker used for highlighting (e.g., "==").
        marker: Option<String>,
        /// The tokenized content of the highlighted text.
        tokens: Vec<Token>,
    },

    /// Represents inline code in the note.
    ///
    /// Example:
    /// ```markdown
    /// `inline code`
    /// ```
    InlineCode {
        /// The span of the token in the source text.
        span: Span,
        /// The inline code content.
        code: String,
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
        code: String,
    },

    /// Represents a block quote in the note.
    Quote {
        /// The span of the quote in the source text.
        span: Span,
        /// The tokenized content of the quote.
        tokens: Vec<Token>,
        /// The author of the quote, if specified.
        ///
        /// Example:
        /// ```markdown
        /// > "To be, or not to be, that is the question."
        /// > \- William Shakespeare
        /// ```
        /// would have author set to "William Shakespeare".
        author: Option<String>,
    },

    /// Represents inline mathematical expressions in the note.
    InlineMath {
        /// The span of the inline math in the source text.
        span: Span,
        /// The LaTeX representation of the inline math.
        latex: String,
    },

    /// Represents display mathematical expressions in the note.
    DisplayMath {
        /// The span of the display math in the source text.
        span: Span,
        /// The LaTeX representation of the display math.
        latex: String,
    },

    /// Represents a horizontal divider in the note.
    Divider {
        /// The span of the divider in the source text.
        span: Span,
    },

    /// Represents a callout block in the note.
    Callout {
        /// The span of the callout in the source text.
        span: Span,
        /// The callout object containing its data.
        callout: Callout,
    },

    /// Represents an internal link to another note within the vault.
    InternalLink {
        /// The span of the internal link in the source text.
        span: Span,
        /// The internal link object containing its data.
        link: InternalLink,
    },

    /// Represents an external link to a URL.
    ExternalLink {
        /// The span of the external link in the source text.
        span: Span,
        /// The external link object containing its data.
        link: ExternalLink,
    },

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

    /// Represents a numerated list in the note.
    ///
    /// Example:
    /// ```markdown
    /// 1. First item
    /// 2. Second item
    ///   1. Subitem 2.1
    ///   2. Subitem 2.2
    /// ```
    NumericList {
        /// The span of the numerated list in the source text.
        span: Span,
        /// The items in the numerated list.
        items: Vec<NumericListItem>,
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

    // TODO: Handle alignment markers in table headers.
    /// Represents a table in the note.
    ///
    /// Example:
    /// ```markdown
    /// | Header 1 | Header 2 |
    /// | -------- | -------- |
    /// | Cell 1   | Cell 2   |
    /// | Cell 3   | Cell 4   |
    /// ```
    Table {
        /// The span of the table in the source text.
        span: Span,
        /// The table object containing its data.
        table: Table,
    },

    /// Represents an escaped character in the note.
    ///
    /// Example:
    /// ```markdown
    /// \*This text is not italicized\*
    /// ```
    Escaped {
        /// The span of the escaped character in the source text.
        span: Span,
        /// The escaped character.
        character: char,
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
            Token::Bold { .. } => "Bold",
            Token::Italic { .. } => "Italic",
            Token::Strikethrough { .. } => "Strikethrough",
            Token::Highlight { .. } => "Highlight",
            Token::InlineCode { .. } => "InlineCode",
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
            Token::NumericList { .. } => "NumericList",
            Token::CheckList { .. } => "CheckList",
            Token::Table { .. } => "Table",
            Token::Comment { .. } => "Comment",
            Token::Escaped { .. } => "Escaped",
            Token::TemplaterCommand { .. } => "TemplaterCommand",
        };
        write!(f, "{}", name)
    }
}

impl Token {
    /// Iterate over the inner tokens of the token, if any.
    pub fn iter_inner(&self) -> Box<dyn Iterator<Item = &Token> + '_> {
        match self {
            Token::Bold { tokens, .. }
            | Token::Italic { tokens, .. }
            | Token::Strikethrough { tokens, .. }
            | Token::Highlight { tokens, .. }
            | Token::Quote { tokens, .. }
            | Token::Callout {
                callout: Callout { tokens, .. },
                ..
            } => Box::new(tokens.iter()),
            Token::List { items, .. } => Box::new(items.iter().flat_map(|item| item.tokens.iter())),
            Token::NumericList { items, .. } => {
                Box::new(items.iter().flat_map(|item| item.tokens.iter()))
            }
            Token::CheckList { items, .. } => {
                Box::new(items.iter().flat_map(|item| item.tokens.iter()))
            }
            Token::Table { table, .. } => Box::new(
                table
                    .rows
                    .iter()
                    .flat_map(|col| col.iter().flat_map(|cell| cell.iter())),
            ),
            Token::Frontmatter { .. }
            | Token::Text { .. }
            | Token::Tag { .. }
            | Token::Header { .. }
            | Token::InlineCode { .. }
            | Token::Code { .. }
            | Token::InlineMath { .. }
            | Token::DisplayMath { .. }
            | Token::Divider { .. }
            | Token::InternalLink { .. }
            | Token::ExternalLink { .. }
            | Token::Comment { .. }
            | Token::Escaped { .. }
            | Token::TemplaterCommand { .. } => {
                // These tokens do not contain nested tokens
                Box::new([].iter())
            }
        }
    }

    /// Iterate over the inner tokens *mutably* of the token, if any.
    pub fn iter_inner_mut(&mut self) -> Box<dyn Iterator<Item = &mut Token> + '_> {
        match self {
            Token::Bold { tokens, .. }
            | Token::Italic { tokens, .. }
            | Token::Strikethrough { tokens, .. }
            | Token::Highlight { tokens, .. }
            | Token::Quote { tokens, .. }
            | Token::Callout {
                callout: Callout { tokens, .. },
                ..
            } => Box::new(tokens.iter_mut()),
            Token::List { items, .. } => {
                Box::new(items.iter_mut().flat_map(|item| item.tokens.iter_mut()))
            }
            Token::NumericList { items, .. } => {
                Box::new(items.iter_mut().flat_map(|item| item.tokens.iter_mut()))
            }
            Token::CheckList { items, .. } => {
                Box::new(items.iter_mut().flat_map(|item| item.tokens.iter_mut()))
            }
            Token::Table { table, .. } => Box::new(
                table
                    .rows
                    .iter_mut()
                    .flat_map(|col| col.iter_mut().flat_map(|cell| cell.iter_mut())),
            ),
            Token::Frontmatter { .. }
            | Token::Text { .. }
            | Token::Tag { .. }
            | Token::Header { .. }
            | Token::InlineCode { .. }
            | Token::Code { .. }
            | Token::InlineMath { .. }
            | Token::DisplayMath { .. }
            | Token::Divider { .. }
            | Token::InternalLink { .. }
            | Token::ExternalLink { .. }
            | Token::Comment { .. }
            | Token::Escaped { .. }
            | Token::TemplaterCommand { .. } => {
                // These tokens do not contain nested tokens
                Box::new([].iter_mut())
            }
        }
    }
}

#[cfg(feature = "python")]
#[pymethods]
impl Token {
    /// String representation of the token.
    pub fn __repr__(&self) -> String {
        const MAX_LEN: usize = 20;
        fn string_repr(s: &str) -> String {
            let mut new_s = String::from(s);
            if new_s.len() > MAX_LEN {
                new_s = format!("{}...", &new_s.chars().take(MAX_LEN).collect::<String>());
                new_s = new_s.trim_end().to_string();
            }
            new_s.replace("\n", "\\n")
        }

        fn tokens_repr(tokens: &[Token]) -> String {
            let token_strs: Vec<String> = tokens.iter().map(|t| t.__repr__()).collect();
            format!("[{}]", token_strs.join(", "))
        }

        match self {
            Token::Text { text, .. } => format!("Text({})", string_repr(text)),
            Token::Tag { tag, .. } => format!("Tag({})", string_repr(tag)),
            Token::Header { level, heading, .. } => {
                format!("Header({} {})", "#".repeat(*level), string_repr(heading))
            }
            Token::Bold { tokens, .. } => format!("Bold({})", tokens_repr(tokens)),
            Token::Italic { tokens, .. } => format!("Italic({})", tokens_repr(tokens)),
            Token::Strikethrough { tokens, .. } => {
                format!("Strikethrough({})", tokens_repr(tokens))
            }
            Token::Highlight { tokens, .. } => format!("Highlight({})", tokens_repr(tokens)),
            Token::InlineCode { code, .. } => format!("InlineCode({})", string_repr(code)),
            Token::InternalLink { link, .. } => format!("InternalLink({})", link.label()),
            Token::ExternalLink { link, .. } => format!("ExternalLink({})", link.label()),
            Token::Code { lang, code, .. } => match lang {
                Some(lang) => format!("Code({}: {})", string_repr(lang), string_repr(code)),
                None => format!("Code({})", string_repr(code)),
            },
            Token::Callout { callout, .. } => {
                format!(
                    "Callout({})",
                    &format!(
                        "[{}] {:?}: {}",
                        callout.kind,
                        callout.title,
                        tokens_repr(&callout.tokens)
                    )
                )
            }
            Token::Quote { tokens, .. } => {
                format!("Quote({})", tokens_repr(tokens))
            }
            Token::Frontmatter { yaml, .. } => format!("Frontmatter({})", string_repr(yaml)),
            Token::InlineMath { latex, .. } => format!("InlineMath({})", string_repr(latex)),
            Token::DisplayMath { latex, .. } => format!("DisplayMath({})", string_repr(latex)),
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
            Token::NumericList { items, .. } => {
                let item_strs: Vec<String> = items
                    .iter()
                    .map(|item| {
                        let content_strs: Vec<String> =
                            item.tokens.iter().map(|t| t.__repr__()).collect();
                        format!("NumericListItem([{}])", content_strs.join(", "))
                    })
                    .collect();
                format!("NumericList([{}])", item_strs.join(", "))
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
            Token::Table { table, .. } => {
                format!(
                    "Table(headers: {}, rows: {})",
                    table.headers.join(", "),
                    table
                        .rows
                        .iter()
                        .map(|row| {
                            let cell_strs: Vec<String> = row
                                .iter()
                                .map(|cell| {
                                    let content_strs: Vec<String> =
                                        cell.iter().map(|t| t.__repr__()).collect();
                                    format!("[{}]", content_strs.join(", "))
                                })
                                .collect();
                            format!("[{}]", cell_strs.join(", "))
                        })
                        .collect::<Vec<String>>()
                        .join(", ")
                )
            }
            Token::Comment { comment, .. } => {
                format!("Comment({})", string_repr(comment))
            }
            Token::Escaped { character, .. } => {
                format!("Escaped({})", character)
            }
            Token::TemplaterCommand { command, .. } => {
                format!("TemplaterCommand({})", string_repr(command))
            }
        }
    }

    /// Convert the token to a Markdown string.
    #[pyo3(name = "to_markdown")]
    pub fn py_to_markdown(&self) -> String {
        self.to_markdown()
    }
}

macro_rules! impl_token_span_method {
    [$($variant:ident),*] => {
        impl Token {
            /// Get the span of the token.
            pub fn span(&self) -> &Span {
                match self {
                    $(Token::$variant { span, .. } => span,)*
                }
            }

            /// Get a mutable reference to the span of the token.
            pub fn span_mut(&mut self) -> &mut Span {
                match self {
                    $(Token::$variant { span, .. } => span,)*
                }
            }
       }
    };

}

impl_token_span_method!(
    Frontmatter,
    Text,
    Tag,
    Header,
    Bold,
    Italic,
    Strikethrough,
    Highlight,
    InlineCode,
    Code,
    Quote,
    InlineMath,
    DisplayMath,
    Divider,
    Callout,
    InternalLink,
    ExternalLink,
    List,
    NumericList,
    CheckList,
    Table,
    Comment,
    Escaped,
    TemplaterCommand
);

impl Token {
    /// Check if the token is a whitespace token.
    pub fn is_whitespace(&self) -> bool {
        use Token::*;
        match self {
            Text { text, .. } => text.chars().all(char::is_whitespace),
            Comment { .. } => true,
            Tag { .. }
            | Bold { .. }
            | Italic { .. }
            | Strikethrough { .. }
            | Highlight { .. }
            | InlineCode { .. }
            | Header { .. }
            | InternalLink { .. }
            | ExternalLink { .. }
            | Code { .. }
            | Callout { .. }
            | Quote { .. }
            | Frontmatter { .. }
            | Divider { .. }
            | InlineMath { .. }
            | DisplayMath { .. }
            | List { .. }
            | NumericList { .. }
            | CheckList { .. }
            | Table { .. }
            | Escaped { .. }
            | TemplaterCommand { .. } => false,
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

    #[pyo3(name = "to_markdown")]
    fn py_to_markdown(&self) -> String {
        self.to_markdown()
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

#[cfg(feature = "python")]
#[pymethods]
impl InternalLink {
    #[pyo3(name = "to_markdown")]
    fn py_to_markdown(&self) -> String {
        self.to_markdown()
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
    /// Whether the callout can be folded or collapsed.
    pub foldable: bool,
}

impl Callout {
    /// Checks if the callout has a non-empty title.
    pub fn has_title(&self) -> bool {
        !self.title.trim().is_empty()
    }
}

#[cfg(feature = "python")]
#[pymethods]
impl Callout {
    /// Returns the markdown representation of the callout.
    #[pyo3(name = "to_markdown")]
    pub fn py_to_markdown(&self) -> String {
        self.to_markdown()
    }
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

#[cfg(feature = "python")]
#[pymethods]
impl ListItem {
    /// Convert the list item to a Markdown string.
    #[pyo3(name = "to_markdown")]
    pub fn py_to_markdown(&self) -> String {
        self.to_markdown()
    }
}

/// Represents a single item in a numerated list.
#[derive(Debug, Clone, PartialEq)]
#[cfg_attr(feature = "python", pyclass(get_all))]
pub struct NumericListItem {
    /// The span of the list item in the source text.
    pub span: Span,
    /// The item number, parsed from the source text.
    pub number: u32,
    /// The indentation level of the list item, which indicates its nesting level.
    pub indent: usize,
    /// The tokenized content of the list item
    pub tokens: Vec<Token>,
}

#[cfg(feature = "python")]
#[pymethods]
impl NumericListItem {
    /// Convert the numeric list item to a Markdown string.
    #[pyo3(name = "to_markdown")]
    pub fn py_to_markdown(&self) -> String {
        self.to_markdown()
    }
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

#[cfg(feature = "python")]
#[pymethods]
impl CheckListItem {
    /// Convert the checklist item to a Markdown string.
    #[pyo3(name = "to_markdown")]
    pub fn py_to_markdown(&self) -> String {
        self.to_markdown()
    }
}

/// Contains the data of a markdown table.
#[cfg_attr(feature = "python", pyclass(get_all))]
#[derive(Debug, Clone, PartialEq)]
pub struct Table {
    /// The headers of the table.
    pub headers: Vec<String>,
    /// The rows of the table, where each row is a vector of tokenized cells
    pub rows: Vec<Vec<Tokens>>,
}

#[cfg(feature = "python")]
#[pymethods]
impl Table {
    fn __repr__(&self) -> String {
        format!("Table(headers: {})", self.headers.join(", "),)
    }

    fn __len__(&self) -> usize {
        debug_assert!(self.rows.len() == self.headers.len());
        self.rows.len()
    }
}
