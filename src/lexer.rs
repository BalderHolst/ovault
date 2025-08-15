use std::{collections::VecDeque, fmt};

#[cfg(feature = "python")]
use pyo3::{pyclass, pymethods};

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
    /// The contents of the callout, which can be a mix of text and other tokens.
    pub contents: Vec<Token>,
    /// Whether the callout can be folded or collapsed.
    pub foldable: bool,
}

/// Represents a span in the source text.
#[cfg_attr(feature = "python", pyclass(get_all))]
#[derive(Debug, Clone, Default, PartialEq)]
pub struct Span {
    /// The starting index of the span in the source text.
    pub start: usize,
    /// The ending index of the span in the source text.
    pub end: usize,
}

impl Span {
    pub fn shift(&mut self, offset: isize) {
        let start = self.start as isize + offset;
        let end = self.end as isize + offset;
        self.start = start as usize;
        self.end = end as usize;
    }

    pub fn line_col(&self, text: &str) -> (usize, usize) {
        let mut line = 1;
        let mut col = 1;

        for (i, c) in text.chars().enumerate() {
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
}

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
#[doc = include_str!("../examples/3_find_headings.py")]
/// ```
#[cfg_attr(feature = "python", pyclass)]
#[derive(Debug, Clone, PartialEq)]
#[rustfmt::skip]
pub enum Token   {

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
    /// ```markdown
    /// ```python
    /// def hello_world():
    ///     print("Hello, world!")
    /// ```
    /// ```
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
        /// The contents of the quote, which can be a mix of text and other tokens.
        contents: Vec<Token>
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
            let new_s = new_s.replace("\n", "\\n");
            new_s
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
                            .contents
                            .first()
                            .map_or("<no contents>".to_string(), |t| string(&t.__repr__()))
                    )
                )
            }
            Token::Quote { contents, .. } => {
                format!("Quote({})", string(&format!("{:?}", contents)))
            }
            Token::Frontmatter { yaml, .. } => format!("Frontmatter({})", string(yaml)),
            Token::InlineMath { latex, .. } => format!("InlineMath({})", string(latex)),
            Token::DisplayMath { latex, .. } => format!("DisplayMath({})", string(latex)),
            Token::Divider { .. } => format!("Divider"),
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
            | Token::ExternalLink { span, .. } => span,
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
            | Token::ExternalLink { span, .. } => span,
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
            | Token::DisplayMath { .. } => false,
        }
    }
}

#[derive(Debug, Clone, PartialEq)]
struct Mark(usize);
impl Copy for Mark {}

pub struct Lexer {
    cursor: usize,
    slow_cursor: usize,
    text: Vec<char>,
    queue: VecDeque<Token>,
}

impl Lexer {
    pub fn new<S: ToString>(text: S) -> Self {
        let chars = text.to_string().chars().collect();
        Self {
            cursor: 0,
            slow_cursor: 0,
            text: chars,
            queue: Default::default(),
        }
    }

    fn peek(&self, offset: isize) -> Option<char> {
        let index = self.cursor as isize + offset;
        if index < 0 {
            return None;
        }
        self.text.get(index as usize).copied()
    }

    fn current(&self) -> Option<char> {
        self.peek(0)
    }

    // Consume a character
    fn consume(&mut self) -> Option<char> {
        self.cursor += 1;
        self.peek(-1)
    }

    fn consume_assert_eq(&mut self, expected: char) -> Option<char> {
        self.cursor += 1;
        let c = self.peek(-1);
        debug_assert_eq!(c, Some(expected));
        c
    }

    fn consume_expect(&mut self, expect: impl FnOnce(char) -> bool) -> Option<char> {
        let c = self.consume();
        c.and_then(|a| match expect(a) {
            true => Some(a),
            false => None,
        })
    }

    fn consume_expected(&mut self, expected: char) -> Option<char> {
        self.consume_expect(|c| c == expected)
    }

    fn consume_until(&mut self, cond: impl Fn(char) -> bool) -> String {
        let start = self.mark();
        while self.current().map_or(false, |c| !cond(c)) {
            self.consume();
        }
        self.extract(start)
    }

    fn consume_while(&mut self, cond: impl Fn(char) -> bool) -> String {
        let start = self.mark();
        while self.current().map_or(false, |c| cond(c)) {
            self.consume();
        }
        self.extract(start)
    }

    fn consume_if(&mut self, cond: impl Fn(char) -> bool) -> bool {
        if self.current().map_or(false, cond) {
            self.consume();
            return true;
        }
        false
    }

    fn consume_whitespace(&mut self) -> String {
        self.consume_until(|c| !c.is_whitespace())
    }

    fn mark(&self) -> Mark {
        Mark(self.cursor)
    }

    /// Get the text between the mark and the cursor
    fn extract(&self, start: Mark) -> String {
        let Mark(start) = start;
        let start = start.min(self.text.len());
        let end = self.cursor.min(self.text.len());
        self.text[start..end].iter().collect()
    }

    fn extract_span(&self, start: Mark) -> Span {
        let Mark(start) = start;
        let start = start.min(self.text.len());
        let end = self.cursor.min(self.text.len());
        Span { start, end }
    }
}

// Methods that construct tokens
impl Lexer {
    fn try_lex_heading(&mut self) -> Option<Token> {
        let start = self.mark();
        self.consume_expected('#')?;

        let mut level: usize = 1;
        while self.current() == Some('#') {
            self.consume();
            level += 1;
        }

        // Assert that there is white space
        self.consume_expect(|c| c.is_whitespace())?;
        _ = self.consume_whitespace();

        let heading_start = self.mark();
        while !matches!(self.current(), Some('\n') | None) {
            self.consume();
        }
        let heading = self.extract(heading_start);
        let span = self.extract_span(start);
        Some(Token::Header {
            span,
            level,
            heading,
        })
    }

    fn try_lex_tag(&mut self) -> Option<Token> {
        // Whitespace must lead a tag
        let prev = self.peek(-1);
        if prev.is_some() && !matches!(prev, Some(c) if c.is_whitespace()) {
            return None;
        }

        let start = self.mark();

        self.consume_expected('#')?;

        let tag = self.consume_while(|c| c.is_alphabetic() || c.is_digit(10));

        if tag.is_empty() {
            return None;
        }

        let span = self.extract_span(start);

        Some(Token::Tag { span, tag })
    }

    fn try_lex_external_link(&mut self) -> Option<Token> {
        let start = self.mark();
        let mut render = false;
        match self.consume()? {
            '!' => {
                render = true;
                self.consume_expected('[')?;
            }
            '[' => {}
            _ => return None,
        }

        let show_how = self.consume_until(|c| matches!(c, ']' | '\n'));
        self.consume_expected(']')?;

        self.consume_expected('(')?;
        let url = self.consume_until(|c| c == ')');
        self.consume_assert_eq(')')?;

        let (show_how, options) = match show_how.split_once('|') {
            Some((show_how, options)) => (show_how.to_string(), Some(options.to_string())),
            None => (show_how, None),
        };

        let (position, url) = match url.split_once('#') {
            Some((url, position)) => (Some(position.to_string()), url.to_string()),
            None => (None, url),
        };

        let span = self.extract_span(start);

        Some(Token::ExternalLink {
            span,
            link: ExternalLink {
                url,
                show_how,
                options,
                position,
                render,
            },
        })
    }

    fn try_lex_internal_link(&mut self) -> Option<Token> {
        let start = self.mark();
        let mut render = false;
        match self.consume()? {
            '!' => {
                render = true;
                self.consume_expected('[')?;
                self.consume_expected('[')?;
            }
            '[' => {
                self.consume_expected('[')?;
            }
            _ => return None,
        }

        let inner_start = self.mark();
        loop {
            self.consume_until(|c| matches!(c, ']' | '\n'));

            if self.peek(1)? == ']' {
                break;
            }

            // If we hit a newline, this is not a valid internal link
            if self.current()? == '\n' {
                return None;
            }
        }

        let inner = self.extract(inner_start);

        self.consume_assert_eq(']');
        self.consume_assert_eq(']');

        let mut dest;
        let mut position = None;
        let mut show_how = None;
        let mut options = None;

        let fields: Vec<_> = inner.split('|').collect();
        match fields.len() {
            0 => {
                dest = "".to_string();
            }
            1 => {
                dest = inner;
            }
            2 => {
                dest = fields[0].to_string();
                show_how = Some(fields[1].to_string());
            }
            3 => {
                dest = fields[0].to_string();
                options = Some(fields[1].to_string());
                show_how = Some(fields[2].to_string());
            }
            // This should maybe do something different, but i don't know what
            _ => return None,
        }

        let dest_fields = dest.split('#').collect::<Vec<_>>();
        match dest_fields.len() {
            2 => {
                position = Some(dest_fields[1].to_string());
                dest = dest_fields[0].to_string();
            }
            1 | _ => dest = dest,
        }

        let span = self.extract_span(start);

        Some(Token::InternalLink {
            span,
            link: InternalLink {
                dest,
                position,
                show_how,
                options,
                render,
            },
        })
    }

    fn at_line_start(&self) -> Option<()> {
        if !matches!(self.peek(-1), None | Some('\n')) {
            return None;
        }
        Some(())
    }

    fn at_block_start(&self) -> Option<()> {
        self.at_line_start()?;

        if !matches!(self.current(), Some('>')) {
            return None;
        }

        Some(())
    }

    /// Extract the text contained within a block prefixed with '>'
    fn try_extract_block(&mut self) -> Option<Vec<Token>> {
        self.at_block_start()?;

        let mut tokens = vec![];

        loop {
            if !matches!(self.current(), Some('>')) {
                break;
            }

            self.consume(); // Consume '>'
            self.consume_if(|c| c == ' ');

            let line_start = self.mark();
            self.consume_until(|c| c == '\n');
            self.consume();

            let line = self.extract(line_start);
            let mut line_tokens: Vec<_> = Self::new(line).collect();
            line_tokens
                .iter_mut()
                .for_each(|t| t.span_mut().shift(line_start.0 as isize));

            tokens.extend(line_tokens);
        }

        Some(tokens)
    }

    fn try_lex_quote(&mut self) -> Option<Token> {
        let start = self.mark();
        let tokens = self.try_extract_block()?;
        let span = self.extract_span(start);
        Some(Token::Quote {
            span,
            contents: tokens,
        })
    }

    fn try_lex_callout(&mut self) -> Option<Token> {
        self.at_block_start()?;

        let start = self.mark();

        self.consume_assert_eq('>');
        self.consume_until(|c| !c.is_whitespace() || c == '\n');

        self.consume_expected('[')?;
        self.consume_expected('!')?;
        let kind = self.consume_until(|c| c == ']');
        self.consume_assert_eq(']');

        let mut foldable = false;
        if self.consume_if(|c| c == '-') {
            foldable = true;
        }

        self.consume_until(|c| c != ' ');
        let title = self.consume_until(|c| c == '\n');
        self.consume_assert_eq('\n');

        let tokens = self.try_extract_block()?;

        let span = self.extract_span(start);

        Some(Token::Callout {
            span,
            callout: Callout {
                kind,
                title,
                contents: tokens,
                foldable,
            },
        })
    }

    fn try_lex_front_matter(&mut self) -> Option<Token> {
        if self.cursor != 0 {
            return None;
        }

        let start = self.mark();

        self.consume_expected('-')?;
        self.consume_expected('-')?;
        self.consume_expected('-')?;

        self.consume_until(|c| c != '-');
        self.consume_until(|c| !c.is_whitespace() || c == '\n');
        self.consume_expected('\n')?;

        let yaml_start = self.mark();
        loop {
            self.consume_until(|c| c == '-');
            if self.peek(1)? == '-' && self.peek(2)? == '-' {
                break;
            }
            self.consume()?; // Consume single '-'
        }
        let yaml = self.extract(yaml_start);

        self.consume_expected('-')?;
        self.consume_expected('-')?;
        self.consume_expected('-')?;

        self.consume_until(|c| c != '-'); // Consume any remaining '-'

        // Consume any white space followed by a newline
        self.consume_until(|c| !c.is_whitespace() || c == '\n');
        self.consume_expected('\n')?;

        let span = self.extract_span(start);

        Some(Token::Frontmatter { span, yaml })
    }

    fn try_lex_divider(&mut self) -> Option<Token> {
        self.at_line_start()?;

        let start = self.mark();

        self.consume_expected('-')?;
        self.consume_expected('-')?;
        self.consume_expected('-')?;

        self.consume_until(|c| c != '-');
        self.consume_until(|c| !c.is_whitespace() || c == '\n');

        self.consume_if(|c| c == '\n');

        let span = self.extract_span(start);

        Some(Token::Divider { span })
    }

    fn try_lex_code(&mut self) -> Option<Token> {
        let start = self.mark();

        self.consume_expected('`')?;
        self.consume_expected('`')?;
        self.consume_expected('`')?;

        let lang = self.consume_until(|c| c == '\n');
        self.consume()?; // consume newline

        let lang = match lang.is_empty() {
            true => None,
            false => Some(lang),
        };

        let code_start = self.mark();
        loop {
            self.consume_until(|c| c == '`');
            if self.peek(1) == Some('`') && self.peek(2) == Some('`') {
                break;
            }

            // consume the "`" we found
            self.consume()?;
        }

        let code = self.extract(code_start);

        self.consume_expected('`')?;
        self.consume_expected('`')?;
        self.consume_expected('`')?;

        let span = self.extract_span(start);

        Some(Token::Code { span, lang, code })
    }

    fn try_lex_display_math(&mut self) -> Option<Token> {
        let start = self.mark();

        self.consume_expected('$')?;
        self.consume_expected('$')?;

        let latex_start = self.mark();
        loop {
            self.consume_until(|c| c == '$');
            if self.peek(1)? == '$' {
                break;
            }

            // Move past the single '$'
            self.consume()?;
        }

        let latex = self.extract(latex_start);

        self.consume_expected('$')?;
        self.consume_expected('$')?;

        let span = self.extract_span(start);

        Some(Token::DisplayMath { span, latex })
    }

    fn try_lex_inline_math(&mut self) -> Option<Token> {
        let start = self.mark();

        self.consume_expected('$')?;

        // Make sure this is not a display match
        #[cfg(test)]
        {
            if matches!(self.current(), Some('$')) {
                panic!("Please try to parse display math before inline math.")
            }
        }

        let latex = self.consume_until(|c| c == '$');

        self.consume()?; // Consume '$'

        let span = self.extract_span(start);

        Some(Token::InlineMath { span, latex })
    }
}

impl Iterator for Lexer {
    type Item = Token;

    fn next(&mut self) -> Option<Self::Item> {
        // TODO: Tokens should hold their spans in the source text so
        // we can decouple the temporary enviornment and adding `continue`
        // if the token is `Some`
        macro_rules! please {
            ($method:ident) => {
                let start = self.cursor;
                let token = self.$method();
                if let Some(token) = token {
                    if self.slow_cursor != start {
                        let text = self.text[self.slow_cursor..start].iter().collect();
                        let span = Span {
                            start: self.slow_cursor,
                            end: start,
                        };
                        self.queue.push_back(Token::Text { span, text });
                    }
                    self.queue.push_back(token);
                    self.slow_cursor = self.cursor;
                    continue;
                }
                self.cursor = start;
            };
        }

        loop {
            if let Some(t) = self.queue.pop_front() {
                return Some(t);
            }

            please!(try_lex_heading);
            please!(try_lex_tag);
            please!(try_lex_code);
            please!(try_lex_display_math);
            please!(try_lex_inline_math);
            please!(try_lex_internal_link);
            please!(try_lex_external_link);
            please!(try_lex_callout);
            please!(try_lex_quote);
            please!(try_lex_front_matter);
            please!(try_lex_divider);

            // Check if we are at the end of the file
            if self.current().is_none() {
                if self.slow_cursor >= self.text.len() {
                    return None;
                }
                let start = Mark(self.slow_cursor);
                let text = self.extract(start);
                let span = self.extract_span(start);
                self.queue.push_back(Token::Text { span, text });
                self.slow_cursor = self.cursor;
            }

            // Consume a text character
            self.consume();
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    macro_rules! test_lex_token {
        ($source:expr => $($token:tt)*) => {
            let mut lexer = Lexer::new($source);
            let token = lexer.next().unwrap();
            assert_eq!(
                token,
                $($token)*
            );
        };
    }

    #[test]
    fn test_lex_front_matter() {
        test_lex_token! {
            "---\nkey: value\n-----\n# this is a heading"
            => Token::Frontmatter {
                span: Span { start: 0, end: 21 },
                yaml: "key: value\n".to_string()
            }
        };
    }

    #[test]
    fn test_lex_heading() {
        test_lex_token! {
            "# Heading"
            => Token::Header {
                span: Span { start: 0, end: 9 },
                level: 1,
                heading: "Heading".to_string()
            }
        }
    }

    #[test]
    fn test_lex_tag() {
        test_lex_token! {
            "#tag"
            => Token::Tag {
                span: Span { start: 0, end: 4 },
                tag: "tag".to_string()
            }
        }

        test_lex_token! {
            "#tag4you"
            => Token::Tag {
                span: Span { start: 0, end: 8 },
                tag: "tag4you".to_string()
            }
        }
    }

    #[test]
    fn test_lex_external_link() {
        test_lex_token! {
            "![alt text](https://link.domain)"
            => Token::ExternalLink {
                span: Span { start: 0, end: 32 },
                link: ExternalLink {
                    url: "https://link.domain".to_string(),
                    show_how: "alt text".to_string(),
                    options: None,
                    position: None,
                    render: true,
                }
            }
        }

        test_lex_token! {
            "[other alt text|options](https://example.com#pos)"
            => Token::ExternalLink {
                span: Span { start: 0, end: 49 },
                link: ExternalLink {
                    url: "https://example.com".to_string(),
                    show_how: "other alt text".to_string(),
                    options: Some("options".to_string()),
                    position: Some("pos".to_string()),
                    render: false,
                }
            }
        }
    }

    #[test]
    fn test_lex_internal_link() {
        test_lex_token! {
            "![[other_note]]"
            => Token::InternalLink {
                span: Span { start: 0, end: 15 },
                link: InternalLink {
                    dest: "other_note".to_string(),
                    position: None,
                    show_how: None,
                    options: None,
                    render: true
                }
            }
        }

        test_lex_token! {
            "![[other_note]]."
            => Token::InternalLink {
                span: Span { start: 0, end: 15 },
                link: InternalLink {
                    dest: "other_note".to_string(),
                    position: None,
                    show_how: None,
                    options: None,
                    render: true
                }
            }
        }

        test_lex_token! {
            "[[other_note|alias]]"
            => Token::InternalLink {
                span: Span { start: 0, end: 20 },
                link: InternalLink {
                    dest: "other_note".to_string(),
                    show_how: Some("alias".to_string()),
                    position: None,
                    options: None,
                    render: false
                }
            }
        }

        test_lex_token! {
            "[[other_note#some-heading]]"
            => Token::InternalLink {
                span: Span { start: 0, end: 27 },
                link: InternalLink {
                    dest: "other_note".to_string(),
                    show_how: None,
                    position: Some("some-heading".to_string()),
                    options: None,
                    render: false
                }
            }
        }

        test_lex_token! {
            "[[other_note#page=13|center|alias]]"
            => Token::InternalLink {
                span: Span { start: 0, end: 35 },
                link: InternalLink {
                    dest: "other_note".to_string(),
                    show_how: Some("alias".to_string()),
                    position: Some("page=13".to_string()),
                    options: Some("center".to_string()),
                    render: false
                }
            }
        }
    }

    #[test]
    fn test_lex_divider() {
        test_lex_token! {
            "---"
            => Token::Divider {
                span: Span { start: 0, end: 3 },
            }
        }

        test_lex_token! {
            "---------"
            => Token::Divider {
                span: Span { start: 0, end: 9 },
            }
        }
    }

    #[test]
    fn test_lex_code() {
        test_lex_token! {
            "```rust\nthis is some code```"
            => Token::Code {
                span: Span { start: 0, end: 28 },
                lang: Some("rust".to_string()),
                code: "this is some code".to_string()
            }
        }
    }

    #[test]
    fn test_lex_inline_math() {
        test_lex_token! {
            "$a=b$"
            => Token::InlineMath {
                span: Span { start: 0, end: 5 },
                latex: "a=b".to_string()
            }
        }
    }

    #[test]
    fn test_lex_display_math() {
        test_lex_token! {
            "$$a=b$$"
            => Token::DisplayMath {
                span: Span { start: 0, end: 7 },
                latex: "a=b".to_string()
            }
        }
    }

    #[test]
    fn test_lex_quote() {
        test_lex_token! {
            "> 'fun quote!'\n> - Author"
            => Token::Quote {
                span: Span { start: 0, end: 25 },
                contents: vec![
                    Token::Text {
                        span: Span { start: 2, end: 15 },
                        text: "'fun quote!'\n".to_string(),
                    },
                    Token::Text {
                        span: Span { start: 17, end: 25 },
                        text: "- Author".to_string(),
                    },
                ],
            }
        }
    }

    #[test]
    fn test_lex_callout() {
        test_lex_token! {
            "> [!kind]- Title!\n> this\n> is contents"
            => Token::Callout {
                span: Span { start: 0, end: 38 },
                callout: Callout {
                    kind: "kind".to_string(),
                    title: "Title!".to_string(),
                    contents: vec![
                        Token::Text {
                            span: Span { start: 20, end: 25 },
                            text: "this\n".to_string(),
                        },
                        Token::Text {
                            span: Span { start: 27, end: 38 },
                            text: "is contents".to_string(),
                        },
                    ],
                    foldable: true,
                }
            }
        }
    }
}
