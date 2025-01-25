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
    pub url: String,
    #[pyo3(get, set)]
    pub show_how: String,
    #[pyo3(get, set)]
    pub render: bool,
    // TODO:
    // pub options: Option<String>,
    // pub position: Option<String>,
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
    pub title: Vec<Token>,
    #[pyo3(get, set)]
    pub contents: Vec<Token>,
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
    Quote { contents: Vec<Token> },
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
        let index = (self.cursor as isize + offset) as usize;
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
    fn consume_internal_link(&mut self) -> Token {
        let mut fields = vec![String::new()];
        let mut shown = false;

        if self.current() == Some('!') {
            shown = true;
            self.consume();
        }

        assert_eq!(self.consume(), Some('['));
        assert_eq!(self.consume(), Some('['));

        while self.current() != Some(']') {
            match self.consume() {
                // Start new field
                Some('|') => fields.push(String::new()),

                // Add character to current field
                Some(c) => fields.last_mut().unwrap().push(c),

                None => break,
            };
        }

        assert_eq!(self.consume(), Some(']'));

        // TODO: Give good error message
        assert_eq!(self.consume(), Some(']'));

        let note_name = fields[0].clone();
        let (note_name, position) = match note_name.split_once('#') {
            Some((d, p)) => (d.to_string(), Some(p.to_string())),
            None => (note_name, None),
        };

        debug_assert!(!note_name.contains("#"));

        match fields.len() {
            0 => todo!("Emply link."),
            1 => Token::InternalLink {
                link: InternalLink {
                    dest: note_name.clone(),
                    position,
                    show_how: None,
                    options: None,
                    render: shown,
                },
            },
            2 => Token::InternalLink {
                link: InternalLink {
                    dest: note_name,
                    position,
                    show_how: Some(fields[1].clone()),
                    options: None,
                    render: shown,
                },
            },
            3 => Token::InternalLink {
                link: InternalLink {
                    dest: note_name,
                    position,
                    show_how: Some(fields[2].clone()),
                    options: Some(fields[1].clone()),
                    render: shown,
                },
            },
            n => panic!("Invalid amount of fields in link: `{n}`."),
        }
    }

    fn consume_external_link(&mut self) -> Token {
        let start = self.cursor;

        let mut render = false;

        if '!'
            == self
                .current()
                .expect("This function should never be called at the end of a file.")
        {
            render = true;
            self.consume();
        }

        let mut show_how = String::new();

        self.consume_expected('[');

        while let Some(c) = self.consume() {
            if c == ']' {
                break;
            }
            show_how.push(c);
        }

        // Return text if it was not a link after all
        if self.current() != Some('(') {
            return Token::Text {
                text: self.text[start..].iter().collect(),
            };
        }

        self.consume_expected('(');

        let mut url = String::new();

        while let Some(c) = self.consume() {
            if c == ')' {
                break;
            }
            url.push(c);
        }

        if self.current() == None {
            eprintln!("WARNING: Unclosed bracket.");
            self.cursor = start; // Reset cursor
            self.consume_expected('[');
            return Token::Text {
                text: "[".to_string(),
            };
        }

        Token::ExternalLink {
            link: ExternalLink {
                url,
                show_how,
                render,
            },
        }
    }

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

    // blocks of text beginning with '>'. Either Callout or quote.
    fn consume_block(&mut self) -> Token {

        // Find the starting character to determine if block is a callout
        assert_eq!(self.peek(0), Some('>'));
        let mut pointer: isize = 1;
        while match self.peek(pointer) {
            Some(c) => c.is_whitespace(),
            None => false,
        } {
            pointer += 1;
        }

        // Is the quote a callout?
        if (self.peek(pointer), self.peek(pointer + 1)) == (Some('['), Some('!')) {
            self.consume_callout()
        } else {
            Token::Quote {
                contents: self.consume_quote(),
            }
        }
    }

    fn consume_callout(&mut self) -> Token {
        // assert_eq!(self.consume(), Some('>'));
        // self.consume_whitespace();
        // assert_eq!(self.consume(), Some('['));
        // assert_eq!(self.consume(), Some('!'));
        // let mut kind = String::new();
        // while self.current() != Some(']') {
        //     let c = self.consume().unwrap();
        //     kind.push(c);
        // }
        // kind = kind.to_lowercase();
        // assert_eq!(self.consume(), Some(']'));
        // let mut foldable = false;
        // if self.current() == Some('-') {
        //     self.consume();
        //     foldable = true;
        // }
        // self.consume_whitespace();

//         let title = if self.peek(-1) != Some('\n') {
//             let mut title = self.consume_line();
//             match title.last() {
//                 Some(Token::Text { text: t }) if t.ends_with('\n') => {
//                     let mut t = t.clone();
//                     t.pop();
//                     title.pop();
//                     title.push(Token::Text { text: t })
//                 }
//                 _ => {}
//             }
//             title
//         } else {
//             // If the callout does not have a title
//             let mut name = kind.clone();
//             name = name[0..1].to_uppercase() + &name[1..];
//             vec![Token::Text { text: name }]
//         };

//         let contents = self.consume_quote();

//         Token::Callout {
//             callout: Callout {
//                 kind,
//                 title,
//                 contents,
//                 foldable,
//             },
//         }
        todo!()
    }

    fn consume_quote(&mut self) -> Vec<Token> {
        // let mut contents = Vec::new();
        // while self.current() == Some('>') {
        //     self.consume();

        //     // Ignore white space
        //     let _ = self.consume_whitespace();

        //     contents.extend(self.consume_line());
        // }
        // contents
        todo!()
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
                return Some(t)
            }

            please!(try_lex_heading);
            please!(try_lex_tag);
            please!(try_lex_code);
            please!(try_lex_display_math);
            please!(try_lex_inline_math);
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
        assert_eq!(token, Token::InlineMath { latex: "a=b".to_string() });
    }

    #[test]
    fn test_lex_display_math() {
        let mut lexer = Lexer::new("$$a=b$$");
        let token = lexer.next().unwrap();
        assert_eq!(token, Token::DisplayMath { latex: "a=b".to_string() });
    }

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

}
