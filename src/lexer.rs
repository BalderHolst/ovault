use pyo3::{pyclass, pymethods};
use std::{collections::VecDeque, fs, path::Path};
use yaml_rust::{self, ScanError};

#[derive(Debug)]
pub enum LexerError {
    Io(std::io::Error),
    Utf(std::string::FromUtf8Error),
}

#[pyclass]
#[derive(Debug, Clone, PartialEq)]
pub struct ExternalLink {
    #[pyo3(get, set)]
    pub render: bool,
    #[pyo3(get, set)]
    pub url: String,
    #[pyo3(get, set)]
    pub show_how: String,
    #[pyo3(get, set)]
    pub options: Option<String>,
    #[pyo3(get, set)]
    pub position: Option<String>,
}

impl ExternalLink {
    pub fn label(&self) -> &str {
        if self.show_how.is_empty() {
            self.url.as_str()
        } else {
            self.show_how.as_str()
        }
    }
}

#[pyclass]
#[derive(Debug, Clone, PartialEq)]
pub struct InternalLink {
    #[pyo3(get, set)]
    pub dest: String,
    #[pyo3(get, set)]
    pub position: Option<String>,
    #[pyo3(get, set)]
    pub show_how: Option<String>,
    #[pyo3(get, set)]
    pub options: Option<String>,
    #[pyo3(get, set)]
    pub render: bool,
}

impl InternalLink {
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

#[pyclass]
#[derive(Debug, Clone, PartialEq)]
pub struct Callout {
    #[pyo3(get, set)]
    pub kind: String,
    #[pyo3(get, set)]
    pub title: String,
    #[pyo3(get, set)]
    pub contents: String,
    #[pyo3(get, set)]
    pub foldable: bool,
}

#[pyclass]
#[derive(Debug, Clone, PartialEq)]
pub enum Token {
    Frontmatter { yaml: String }, // This can only appear as the first token
    Text { text: String },
    Tag { tag: String },
    Header { level: usize, heading: String },
    InternalLink { link: InternalLink },
    ExternalLink { link: ExternalLink },
    Code { lang: Option<String>, code: String },
    Callout { callout: Callout },
    Quote { contents: String },
    InlineMath { latex: String },
    DisplayMath { latex: String },
    Divider {},
}

#[pymethods]
impl Token {
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
            Token::Text { text } => format!("Text({})", string(text)),
            Token::Tag { tag } => format!("Tag({})", string(tag)),
            Token::Header { level, heading } => {
                format!("Header({} {})", "#".repeat(*level), string(heading))
            }
            Token::InternalLink { link } => format!("InternalLink({})", link.label()),
            Token::ExternalLink { link } => format!("ExternalLink({})", link.label()),
            Token::Code { lang, code } => match lang {
                Some(lang) => format!("Code({}: {})", string(lang), string(code)),
                None => format!("Code({})", string(code)),
            },
            Token::Callout { callout } => format!("Callout({})", string(&format!("{:?}", callout))),
            Token::Quote { contents } => format!("Quote({})", string(&format!("{:?}", contents))),
            Token::Frontmatter { yaml } => format!("Frontmatter({})", string(yaml)),
            Token::InlineMath { latex } => format!("InlineMath({})", string(latex)),
            Token::DisplayMath { latex } => format!("DisplayMath({})", string(latex)),
            Token::Divider {} => format!("Divider"),
        }
    }
}

impl Token {
    pub fn is_whitespace(&self) -> bool {
        match self {
            Token::Text { text } => text.chars().all(char::is_whitespace),

            Token::Tag { .. }
            | Token::Header { .. }
            | Token::InternalLink { .. }
            | Token::ExternalLink { .. }
            | Token::Code { .. }
            | Token::Callout { .. }
            | Token::Quote { .. }
            | Token::Frontmatter { .. }
            | Token::Divider {}
            | Token::InlineMath { .. }
            | Token::DisplayMath { .. } => false,
        }
    }
}

pub struct Lexer {
    cursor: usize,
    slow_cursor: usize,
    text: Vec<char>,
    queue: VecDeque<Token>,
    first_token: bool,
}

impl Lexer {
    pub fn new<S: ToString>(text: S) -> Self {
        let chars = text.to_string().chars().collect();
        Self {
            cursor: 0,
            slow_cursor: 0,
            text: chars,
            queue: Default::default(),
            first_token: true,
        }
    }

    pub fn from_file(path: &Path) -> Result<Self, LexerError> {
        let bytes = fs::read(path).map_err(LexerError::Io)?;
        let text = String::from_utf8(bytes).map_err(LexerError::Utf)?;
        Ok(Self::new(text))
    }

    fn peek(&self, offset: isize) -> Option<char> {
        let index = self.cursor as isize + offset;
        let index = usize::try_from(index).ok()?;
        self.text.get(index).copied()
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
        c.map(|a| match expect(a) {
            true => Some(a),
            false => None,
        })
        .flatten()
    }

    fn consume_expected(&mut self, expected: char) -> Option<char> {
        self.consume_expect(|c| c == expected)
    }

    fn consume_until(&mut self, cond: impl Fn(char) -> bool) -> String {
        let start = self.cursor;
        while self.current().map_or(false, |c| !cond(c)) {
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

    /// Get the text between the mark and the cursor
    fn extract(&self, start: usize) -> String {
        let start = start.min(self.text.len());
        let end = self.cursor.min(self.text.len());
        self.text[start..end].iter().collect()
    }

    fn queue_token(&mut self, token: Token) {
        self.queue.push_back(token);
    }
}

// Methods that construct tokens
impl Lexer {
    fn try_lex_heading(&mut self) -> Option<Token> {
        self.consume_expected('#')?;

        let mut level: usize = 1;
        while self.current() == Some('#') {
            self.consume();
            level += 1;
        }

        // Assert that there is white space
        self.consume_expect(|c| c.is_whitespace())?;
        _ = self.consume_whitespace();

        let start = self.cursor;
        while !matches!(self.current(), Some('\n') | None) {
            self.consume();
        }
        let heading = self.extract(start);
        Some(Token::Header { level, heading })
    }

    fn try_lex_tag(&mut self) -> Option<Token> {
        // Whitespace must lead a tag
        let prev = self.peek(-1);
        if prev.is_some() && !matches!(prev, Some(c) if c.is_whitespace()) {
            return None;
        }

        self.consume_expected('#')?;

        let tag = self.consume_until(|c| !c.is_alphabetic());

        if tag.is_empty() {
            return None;
        }

        Some(Token::Tag { tag })
    }

    fn try_lex_external_link(&mut self) -> Option<Token> {
        let mut render = false;
        match self.consume()? {
            '!' => {
                render = true;
                self.consume_expected('[')?;
            }
            '[' => {}
            _ => return None,
        }

        let show_how = self.consume_until(|c| c == ']');
        self.consume_assert_eq(']');

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

        Some(Token::ExternalLink {
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

        let inner_start = self.cursor;
        loop {
            self.consume_until(|c| c == ']');
            if self.peek(1)? == ']' {
                break;
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

        Some(Token::InternalLink {
            link: InternalLink {
                dest,
                position,
                show_how,
                options,
                render,
            },
        })
    }

    fn at_block_start(&self) -> Option<()> {
        // Block must start after newline or at the start of a file
        if !matches!(self.peek(-1), None | Some('\n')) {
            return None;
        }

        if !matches!(self.current(), Some('>')) {
            return None;
        }

        Some(())
    }

    /// Extract the text contained within a block prefixed with '>'
    fn try_extract_block(&mut self) -> Option<String> {
        self.at_block_start()?;

        let mut lines = vec![];

        loop {
            if !matches!(self.current(), Some('>')) {
                break;
            }
            self.consume(); // Consume '>'
            self.consume_if(|c| c == ' ');

            let line_start = self.cursor;
            self.consume_until(|c| c == '\n');
            self.consume();

            let line = self.extract(line_start);
            lines.push(line);
        }

        Some(lines.join(""))
    }

    fn try_lex_quote(&mut self) -> Option<Token> {
        let contents = self.try_extract_block()?;
        Some(Token::Quote { contents })
    }

    fn try_lex_callout(&mut self) -> Option<Token> {
        self.at_block_start()?;
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

        let contents = self.try_extract_block()?;

        Some(Token::Callout {
            callout: Callout {
                kind,
                title,
                contents,
                foldable,
            },
        })
    }

    fn try_lex_front_matter(&mut self) -> Option<Token> {
        if self.cursor != 0 {
            return None;
        }

        self.consume_expected('-')?;
        self.consume_expected('-')?;
        self.consume_expected('-')?;

        self.consume_until(|c| c != '-');
        self.consume_until(|c| !c.is_whitespace() || c == '\n');
        self.consume_expected('\n')?;

        let start = self.cursor;
        loop {
            self.consume_until(|c| c == '-');
            if self.peek(1)? == '-' && self.peek(2)? == '-' {
                break;
            }
            self.consume()?; // Consume single '-'
        }
        let yaml = self.extract(start);

        self.consume_expected('-')?;
        self.consume_expected('-')?;
        self.consume_expected('-')?;

        self.consume_until(|c| c != '-'); // Consume any remaining '-'

        // Consume any white space followed by a newline
        self.consume_until(|c| !c.is_whitespace() || c == '\n');
        self.consume_expected('\n')?;

        Some(Token::Frontmatter { yaml })
    }

    fn try_lex_divider(&mut self) -> Option<Token> {
        self.consume_expected('-')?;
        self.consume_expected('-')?;
        self.consume_expected('-')?;

        self.consume_until(|c| c != '-');
        self.consume_until(|c| !c.is_whitespace() || c == '\n');

        self.consume_if(|c| c == '\n');

        Some(Token::Divider {})
    }

    fn try_lex_code(&mut self) -> Option<Token> {
        self.consume_expected('`')?;
        self.consume_expected('`')?;
        self.consume_expected('`')?;

        let lang = self.consume_until(|c| c == '\n');
        self.consume()?; // consume newline

        let lang = match lang.is_empty() {
            true => None,
            false => Some(lang),
        };

        let code_start = self.cursor;
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

        Some(Token::Code { lang, code })
    }

    fn try_lex_display_math(&mut self) -> Option<Token> {
        self.consume_expected('$')?;
        self.consume_expected('$')?;

        let start = self.cursor.clone();
        loop {
            self.consume_until(|c| c == '$');
            if self.peek(1)? == '$' {
                break;
            }

            // Move past the single '$'
            self.consume()?;
        }

        let latex = self.text[start..self.cursor].iter().collect();

        self.consume_expected('$')?;
        self.consume_expected('$')?;

        Some(Token::DisplayMath { latex })
    }

    fn try_lex_inline_math(&mut self) -> Option<Token> {
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

        Some(Token::InlineMath { latex })
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
                        self.queue.push_back(Token::Text { text });
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
                let text = self.extract(self.slow_cursor);
                self.queue.push_back(Token::Text { text });
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

    #[test]
    fn test_lex_front_matter() {
        let mut lexer = Lexer::new("---\nkey: value\n-----\n# this is a heading");
        let token = lexer.next().unwrap();
        assert_eq!(
            token,
            Token::Frontmatter {
                yaml: "key: value\n".to_string()
            }
        );
    }

    #[test]
    fn test_lex_heading() {
        let mut lexer = Lexer::new("# Heading");
        let token = lexer.next().unwrap();
        assert_eq!(
            token,
            Token::Header {
                level: 1,
                heading: "Heading".to_string()
            }
        );
    }

    #[test]
    fn test_lex_tag() {
        let mut lexer = Lexer::new("#tag");
        let token = lexer.next().unwrap();
        assert_eq!(
            token,
            Token::Tag {
                tag: "tag".to_string()
            }
        );
    }

    #[test]
    fn test_lex_external_link() {
        let mut lexer = Lexer::new("![alt text](https://link.domain)");
        let token = lexer.next().unwrap();
        assert_eq!(
            token,
            Token::ExternalLink {
                link: ExternalLink {
                    url: "https://link.domain".to_string(),
                    show_how: "alt text".to_string(),
                    options: None,
                    position: None,
                    render: true,
                }
            }
        );

        let mut lexer = Lexer::new("[other alt text|options](https://example.com#pos)");
        let token = lexer.next().unwrap();
        assert_eq!(
            token,
            Token::ExternalLink {
                link: ExternalLink {
                    url: "https://example.com".to_string(),
                    show_how: "other alt text".to_string(),
                    options: Some("options".to_string()),
                    position: Some("pos".to_string()),
                    render: false,
                }
            }
        );
    }

    #[test]
    fn test_lex_internal_link() {
        let mut lexer = Lexer::new("![[other_note]]");
        let token = lexer.next().unwrap();
        assert_eq!(
            token,
            Token::InternalLink {
                link: InternalLink {
                    dest: "other_note".to_string(),
                    position: None,
                    show_how: None,
                    options: None,
                    render: true
                }
            }
        );

        let mut lexer = Lexer::new("[[other_note|alias]]");
        let token = lexer.next().unwrap();
        assert_eq!(
            token,
            Token::InternalLink {
                link: InternalLink {
                    dest: "other_note".to_string(),
                    show_how: Some("alias".to_string()),
                    position: None,
                    options: None,
                    render: false
                }
            }
        );

        let mut lexer = Lexer::new("[[other_note#some-heading]]");
        let token = lexer.next().unwrap();
        assert_eq!(
            token,
            Token::InternalLink {
                link: InternalLink {
                    dest: "other_note".to_string(),
                    show_how: None,
                    position: Some("some-heading".to_string()),
                    options: None,
                    render: false
                }
            }
        );

        let mut lexer = Lexer::new("[[other_note#page=13|center|alias]]");
        let token = lexer.next().unwrap();
        assert_eq!(
            token,
            Token::InternalLink {
                link: InternalLink {
                    dest: "other_note".to_string(),
                    show_how: Some("alias".to_string()),
                    position: Some("page=13".to_string()),
                    options: Some("center".to_string()),
                    render: false
                }
            }
        );
    }

    #[test]
    fn test_lex_divider() {
        let mut lexer = Lexer::new("---");
        let token = lexer.next().unwrap();
        assert_eq!(token, Token::Divider {});

        let mut lexer = Lexer::new("---------");
        let token = lexer.next().unwrap();
        assert_eq!(token, Token::Divider {});
    }

    #[test]
    fn test_lex_code() {
        let mut lexer = Lexer::new("```rust\nthis is some code```");
        let token = lexer.next().unwrap();
        assert_eq!(
            token,
            Token::Code {
                lang: Some("rust".to_string()),
                code: "this is some code".to_string()
            }
        );
    }

    #[test]
    fn test_lex_inline_math() {
        let mut lexer = Lexer::new("$a=b$");
        let token = lexer.next().unwrap();
        assert_eq!(
            token,
            Token::InlineMath {
                latex: "a=b".to_string()
            }
        );
    }

    #[test]
    fn test_lex_display_math() {
        let mut lexer = Lexer::new("$$a=b$$");
        let token = lexer.next().unwrap();
        assert_eq!(
            token,
            Token::DisplayMath {
                latex: "a=b".to_string()
            }
        );
    }

    #[test]
    fn test_lex_quote() {
        let mut lexer = Lexer::new("> 'fun quote!'\n> - Author");
        let token = lexer.next().unwrap();
        assert_eq!(
            token,
            Token::Quote {
                contents: "'fun quote!'\n- Author".to_string()
            }
        );
    }

    #[test]
    fn test_lex_callout() {
        let mut lexer = Lexer::new("> [!kind]- Title!\n> this\n> is contents");
        let token = lexer.next().unwrap();
        assert_eq!(
            token,
            Token::Callout {
                callout: Callout {
                    kind: "kind".to_string(),
                    title: "Title!".to_string(),
                    contents: "this\nis contents".to_string(),
                    foldable: true,
                }
            }
        );
    }
}
