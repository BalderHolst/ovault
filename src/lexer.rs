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
    Text { text: String },
    Tag { tag: String },
    Header { level: usize, heading: String },
    InternalLink { link: InternalLink },
    ExternalLink { link: ExternalLink },
    Callout { callout: Callout },
    Quote { contents: Vec<Token> },
    InlineMath { latex: String },
    DisplayMath { latex: String },
    Divider {},
    Frontmatter { yaml: String }, // This can only appear as the first token
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
                format!("Header({}, {})", level, string(heading))
            }
            Token::InternalLink { link } => format!("InternalLink({})", link.label()),
            Token::ExternalLink { link } => format!("ExternalLink({})", link.label()),
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
            Token::Tag { .. } => false,
            Token::Header { .. } => false,
            Token::InternalLink { .. } => false,
            Token::ExternalLink { .. } => false,
            Token::Callout { .. } => false,
            Token::Quote { .. } => false,
            Token::Frontmatter { .. } => false,
            Token::Divider {} => false,
            Token::InlineMath { .. } => false,
            Token::DisplayMath { .. } => false,
        }
    }
}

pub struct Lexer {
    cursor: usize,
    text: Vec<char>,
    queue: VecDeque<Token>,
    first_token: bool,
}

impl Lexer {
    pub fn new(text: String) -> Self {
        let chars = text.chars().collect();
        Self {
            cursor: 0,
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

    fn peak(&self, offset: isize) -> Option<char> {
        let index = (self.cursor as isize + offset) as usize;
        self.text.get(index).copied()
    }

    // Consume a character
    fn consume(&mut self) -> Option<char> {
        self.cursor += 1;
        self.peak(-1)
    }

    fn consume_expect(&mut self, expected: char) {
        let c = self.consume();
        if Some(expected) != c {
            panic!("Found unexpected char: '{}'", expected); // TODO: return error
        }
    }

    fn current(&self) -> Option<char> {
        self.peak(0)
    }

    fn consume_whitespace(&mut self) -> String {
        let mut s = String::new();
        while match self.current() {
            Some(c) => c.is_whitespace(),
            None => false,
        } {
            let c = self.consume().unwrap();
            s.push(c);
        }
        s
    }

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

        self.consume_expect('[');

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

        self.consume_expect('(');

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
            self.consume_expect('[');
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

    // TODO: Find a way to remove. This messes things up with quotes and callouts. Maybe rename to
    // `consume_text` and just return a single token
    fn consume_line(&mut self) -> Vec<Token> {
        // The vector of tokens for this line
        let mut tokens = Vec::new();

        // The string we are currently building
        let mut s = String::new();

        // Wether the line ends the entire file.
        let mut found_eof = false;

        while !matches!(self.current(), Some('\n') | None) {
            match (self.current(), self.peak(1), self.peak(2)) {
                (Some('['), Some('['), _) | (Some('!'), Some('['), Some('[')) => {
                    tokens.push(Token::Text { text: s.clone() });
                    s.clear();
                    tokens.push(self.consume_internal_link());
                }
                (Some('['), Some(_), _) | (Some('!'), Some('['), _) => {
                    tokens.push(Token::Text { text: s.clone() });
                    s.clear();
                    tokens.push(self.consume_external_link());
                }
                (Some('$'), Some('$'), _) => {
                    tokens.push(Token::Text { text: s.clone() });
                    s.clear();
                    tokens.push(self.consume_display_math());
                }
                (Some('$'), _, _) => {
                    tokens.push(Token::Text { text: s.clone() });
                    s.clear();
                    tokens.push(self.consume_inline_math());
                }
                (Some(c), _, _) => {
                    self.consume();
                    s.push(c);
                }
                (None, _, _) => {
                    found_eof = true;
                }
            }
        }
        if !found_eof {
            // Consume newline
            self.consume();
            s.push('\n');
        }
        tokens.push(Token::Text { text: s });
        tokens
    }

    fn consume_heading(&mut self) -> Token {
        assert_eq!(self.current(), Some('#'));
        let mut level: usize = 0;
        while self.current() == Some('#') {
            self.consume();
            level += 1;
        }
        let _ = self.consume_whitespace();
        let start = self.cursor;
        while !matches!(self.current(), Some('\n') | None) {
            self.consume();
        }
        let heading = self.text[start..self.cursor].iter().collect();
        Token::Header { level, heading }
    }

    fn consume_tag(&mut self) -> Token {
        assert_eq!(self.consume(), Some('#'));
        let mut text = String::new();
        while match self.current() {
            Some(c) => !c.is_whitespace(),
            None => false,
        } {
            let c = self.consume().unwrap();
            text.push(c);
        }
        Token::Tag { tag: text }
    }

    // blocks of text beginning with '>'. Either Callout or quote.
    fn consume_block(&mut self) -> Token {
        // Find the starting character to determine if block is a callout
        assert_eq!(self.peak(0), Some('>'));
        let mut pointer: isize = 1;
        while match self.peak(pointer) {
            Some(c) => c.is_whitespace(),
            None => false,
        } {
            pointer += 1;
        }

        // Is the quote a callout?
        if (self.peak(pointer), self.peak(pointer + 1)) == (Some('['), Some('!')) {
            self.consume_callout()
        } else {
            Token::Quote {
                contents: self.consume_quote(),
            }
        }
    }

    fn consume_callout(&mut self) -> Token {
        assert_eq!(self.consume(), Some('>'));
        self.consume_whitespace();
        assert_eq!(self.consume(), Some('['));
        assert_eq!(self.consume(), Some('!'));
        let mut kind = String::new();
        while self.current() != Some(']') {
            let c = self.consume().unwrap();
            kind.push(c);
        }
        kind = kind.to_lowercase();
        assert_eq!(self.consume(), Some(']'));
        let mut foldable = false;
        if self.current() == Some('-') {
            self.consume();
            foldable = true;
        }
        self.consume_whitespace();

        let title = if self.peak(-1) != Some('\n') {
            let mut title = self.consume_line();
            match title.last() {
                Some(Token::Text { text: t }) if t.ends_with('\n') => {
                    let mut t = t.clone();
                    t.pop();
                    title.pop();
                    title.push(Token::Text { text: t })
                }
                _ => {}
            }
            title
        } else {
            // If the callout does not have a title
            let mut name = kind.clone();
            name = name[0..1].to_uppercase() + &name[1..];
            vec![Token::Text { text: name }]
        };

        let contents = self.consume_quote();

        Token::Callout {
            callout: Callout {
                kind,
                title,
                contents,
                foldable,
            },
        }
    }

    fn consume_quote(&mut self) -> Vec<Token> {
        let mut contents = Vec::new();
        while self.current() == Some('>') {
            self.consume();

            // Ignore white space
            let _ = self.consume_whitespace();

            contents.extend(self.consume_line());
        }
        contents
    }

    fn consume_front_matter(&mut self) -> Result<Token, ScanError> {
        assert_eq!(self.consume(), Some('-'));
        assert_eq!(self.consume(), Some('-'));
        assert_eq!(self.consume(), Some('-'));

        let mut yaml = String::new();

        while (self.peak(0), self.peak(1), self.peak(2)) != (Some('-'), Some('-'), Some('-'))
            && self.peak(2).is_some()
        {
            yaml.push(
                self.consume()
                    .expect("The check for Some is already done here."),
            );
        }

        // TODO: make good error message if frontmatter is not ended correctly
        assert_eq!(self.consume(), Some('-'));
        assert_eq!(self.consume(), Some('-'));
        assert_eq!(self.consume(), Some('-'));

        Ok(Token::Frontmatter { yaml })
    }

    fn consume_divider(&mut self) -> Token {
        debug_assert_eq!(self.consume(), Some('-'));
        debug_assert_eq!(self.consume(), Some('-'));
        debug_assert_eq!(self.consume(), Some('-'));
        while self.current() == Some('-') {
            self.consume();
        }
        while self.current() == Some(' ') {
            self.consume();
        }
        debug_assert!(matches!(self.consume(), Some('\n') | None));
        Token::Divider {}
    }

    fn consume_display_math(&mut self) -> Token {
        assert_eq!(self.consume(), Some('$'));
        assert_eq!(self.consume(), Some('$'));

        let start = self.cursor.clone();
        while !matches!(
            (self.current(), self.peak(1)),
            (Some('$'), Some('$')) | (None, _) | (_, None)
        ) {
            self.consume();
        }

        let inline_math = self.text[start..self.cursor].iter().collect();

        assert_eq!(self.consume(), Some('$'));
        assert_eq!(self.consume(), Some('$'));
        Token::DisplayMath { latex: inline_math }
    }

    fn consume_inline_math(&mut self) -> Token {
        assert_eq!(self.consume(), Some('$'));

        let start = self.cursor.clone();
        while !matches!(self.current(), Some('$') | None) {
            self.consume();
        }

        let inline_math = self.text[start..self.cursor].iter().collect();

        assert_eq!(self.consume(), Some('$'));
        Token::InlineMath { latex: inline_math }
    }
}

impl Iterator for Lexer {
    type Item = Token;

    fn next(&mut self) -> Option<Self::Item> {
        if !self.queue.is_empty() {
            return Some(
                self.queue
                    .pop_front()
                    .expect("We should not get to here if the queue is empty."),
            );
        }

        let token = match self.current()? {
            '#' => {
                let next = self.peak(1);
                if next == Some(' ') || next == Some('#') {
                    Some(self.consume_heading())
                } else {
                    Some(self.consume_tag())
                }
            }
            '>' => Some(self.consume_block()),
            '-' if self.first_token && (self.peak(1), self.peak(2)) == (Some('-'), Some('-')) => {
                match self.consume_front_matter() {
                    Ok(t) => Some(t),
                    Err(e) => {
                        eprintln!("ERROR: Could not parse frontmatter: {}", e);
                        Some(Token::Text {
                            text: "".to_string(),
                        })
                    }
                }
            }
            '-' if (self.peak(1), self.peak(2)) == (Some('-'), Some('-')) => {
                Some(self.consume_divider())
            }
            '$' if self.peak(1) == Some('$') => Some(self.consume_display_math()),
            '$' => Some(self.consume_inline_math()),
            c if c.is_whitespace() => Some(Token::Text { text: self.consume_whitespace() }),
            _ => {
                for token in self.consume_line() {
                    self.queue.push_back(token);
                }
                self.queue.pop_front()
            }
        };
        if self.first_token {
            self.first_token = false
        }
        token
    }
}
