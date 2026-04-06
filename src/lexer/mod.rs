//! This module defines the `Lexer` for parsing markdown notes into tokens.
use std::collections::VecDeque;

mod span;
mod to_markdown;
pub mod tokens;

#[cfg(test)]
mod tests;

use enumset::{EnumSet, EnumSetType};
pub use span::Span;
pub use to_markdown::ToMarkdown;
use tokens::{
    Callout, CheckListItem, ExternalLink, InternalLink, ListItem, NumericListItem, Table,
    TableAlignment, Token, Tokens,
};

#[cfg(feature = "python")]
pub use to_markdown::py_to_markdown;

#[derive(Debug, Clone, PartialEq)]
struct Mark(usize);
impl Copy for Mark {}

impl Mark {
    const START: Self = Mark(0);
}

impl From<Mark> for usize {
    fn from(val: Mark) -> Self {
        val.0
    }
}

type TokenGroupSet = EnumSet<TokenGroup>;

/// Groups of tokens which can be enabled or disabled in the lexer.
#[derive(EnumSetType, Default)]
pub enum TokenGroup {
    /// Tokens that can span multiple lines.
    Multiline,
    /// Tokens that are lexed and inserted inline.
    #[default]
    Inline,
}

impl TokenGroup {
    /// Get a set containing all token groups.
    pub fn all() -> TokenGroupSet {
        EnumSet::all()
    }

    /// Get a set containing all token groups except the given one.
    pub fn without(group: TokenGroup) -> TokenGroupSet {
        let mut all = Self::all();
        all.remove(group);
        all
    }
}

/// Configuration options for the lexer.
#[derive(Clone)]
pub struct LexerConfig {
    /// Enabled token groups.
    pub token_groups: TokenGroupSet,
    /// Offset added to all tokens what the lexer produces
    pub offset: usize,
}

impl Default for LexerConfig {
    fn default() -> Self {
        Self {
            token_groups: TokenGroup::all(),
            offset: 0,
        }
    }
}

/// A lexer for parsing markdown into tokens.
#[derive(Clone)]
pub struct Lexer {
    cursor: usize,
    slow_cursor: usize,
    chars: Vec<(usize, char, bool)>, // (position, char, skipped)
    queue: VecDeque<Token>,
    config: LexerConfig,
}

impl Lexer {
    /// Create a new lexer with the given text.
    pub fn new<S: ToString>(text: S) -> Self {
        Self::new_with_config(text, LexerConfig::default())
    }

    /// Set the offset of spans generated with this lexer
    pub fn with_offset(self, offset: usize) -> Self {
        let config = LexerConfig {
            offset,
            ..self.config
        };
        Self { config, ..self }
    }

    /// Create a new lexer with the given text and configuration.
    pub fn new_with_config<S: ToString>(text: S, config: LexerConfig) -> Self {
        let chars = text
            .to_string()
            .char_indices()
            .map(|(p, c)| (p, c, false))
            .collect::<Vec<_>>();
        Self {
            cursor: 0,
            slow_cursor: 0,
            chars,
            queue: Default::default(),
            config,
        }
    }

    /// Create a new lexer with the given text and a function to skip characters.
    pub fn new_with_skip_function<S: ToString>(text: S, skip_function: fn(&mut Self)) -> Self {
        let mut lexer = Self::new(text);

        lexer.mark_skipped(skip_function);

        // Skip initial '> ' prefix to prevent infinite recursion
        skip_funcs::skip_block_prefix(&mut lexer);
        lexer.mark_skipped_chunk(Mark::START);

        lexer
    }

    /// Run the lexer and return all tokens.
    pub fn run(&mut self) -> Tokens {
        Vec::from_iter(self)
    }

    fn peek(&self, mut offset: isize) -> Option<char> {
        let mut index = self.cursor as isize;

        while offset != 0 {
            index += offset.signum();

            let (_, _, skipped) = self.chars.get(usize::try_from(index).ok()?)?;

            if !*skipped {
                offset -= offset.signum();
            }
        }

        self.chars.get(index as usize).map(|(_, c, _)| *c)
    }

    fn current(&self) -> Option<char> {
        self.peek(0)
    }

    fn mark_skipped_chunk(&mut self, start: Mark) {
        let Mark(start) = start;
        let end = self.cursor;
        for i in start..end {
            if let Some((_, _, skipped)) = self.chars.get_mut(i) {
                *skipped = true;
            }
        }
    }

    fn mark_skipped(&mut self, skip_function: fn(&mut Self)) {
        let start = self.mark();
        while self.current().is_some() {
            let skip_start = self.mark();
            (skip_function)(self);
            self.mark_skipped_chunk(skip_start);
            self.consume();
        }
        self.rewind(start);
    }

    // Consume a character
    fn consume(&mut self) -> Option<char> {
        let c = self.current()?;
        loop {
            self.cursor += 1;
            let Some((_, _, skipped)) = self.chars.get(self.cursor) else {
                break;
            };

            if !*skipped {
                break;
            }
        }
        Some(c)
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
        while self.current().is_some_and(|c| !cond(c)) {
            self.consume();
        }
        self.extract(start)
    }

    fn at_sequence(&self, seq: &str) -> bool {
        for (i, c) in seq.chars().enumerate() {
            if self.peek(i as isize) != Some(c) {
                return false;
            }
        }
        true
    }

    /// Consume a sequence of characters, returning None if the sequence is not found.
    fn consume_expected_sequence(&mut self, seq: &str) -> Option<()> {
        for expected in seq.chars() {
            self.consume_expected(expected)?;
        }
        Some(())
    }

    fn consume_until_sequence(&mut self, seq: &str) -> Option<()> {
        while !self.at_sequence(seq) {
            self.consume()?;
        }
        Some(())
    }

    fn consume_while(&mut self, cond: impl Fn(char) -> bool) -> String {
        self.consume_until(|c| !cond(c))
    }

    fn consume_if(&mut self, cond: impl Fn(char) -> bool) -> bool {
        if !self.current().is_some_and(cond) {
            return false;
        }
        self.consume();
        true
    }

    fn consume_whitespace(&mut self) -> String {
        self.consume_until(|c| !c.is_whitespace())
    }

    fn consume_integer(&mut self) -> Option<u32> {
        let start = self.mark();
        let s = self.consume_while(|c| c.is_ascii_digit());
        match s.parse() {
            Ok(i) => Some(i),
            Err(_) => {
                self.cursor = start.0;
                None
            }
        }
    }

    fn mark(&self) -> Mark {
        Mark(self.cursor)
    }

    fn rewind(&mut self, mark: Mark) {
        let Mark(pos) = mark;
        self.cursor = pos;
    }

    /// Get the text between the mark and the cursor
    fn extract(&self, start: Mark) -> String {
        self.extract_span(self.span(start))
    }

    #[allow(unused)]
    fn extract_all(&self) -> String {
        self.extract_span(Span {
            start: 0,
            end: self.chars.len(),
        })
    }

    fn extract_span(&self, span: Span) -> String {
        let Span { start, end } = span;
        if start >= self.chars.len() || end > self.chars.len() {
            return "".to_string();
        }
        self.chars[start..end]
            .iter()
            .filter_map(|(_, c, skipped)| (!skipped).then_some(c))
            .collect()
    }

    fn span(&self, start: Mark) -> Span {
        let Mark(start) = start;
        let Mark(end) = self.mark();
        let max = self.chars.len();
        let start = start.min(max);
        let end = end.min(max);
        Span { start, end }
    }
}

mod skip_funcs {
    use super::*;
    pub fn skip_block_prefix(lexer: &mut Lexer) {
        (|| {
            lexer.at_block_start()?;
            lexer.consume_while(|c| c == ' ');
            lexer.consume(); // Consume '>'
            lexer.consume_if(|c| c == ' ');
            Some(())
        })();
    }
}

macro_rules! lex_inline_fn {
    ($name:ident: [$($marker:expr),*] => $output:ident) => {
        fn $name(&mut self) -> Option<Token> {
            const MARKERS: &[&str] = &[$($marker),*];

            // Check that we are at a start marker
            let marker = MARKERS.iter().find(|s| self.at_sequence(s))?;

            let start = self.mark();

            self.consume_expected_sequence(marker)
                .expect("We just checked for start marker");

            let content_start = self.mark();


            while !self.at_sequence(marker) || self.peek(-1) == Some('\\') {
                let c = self.consume()?;
                if c == '\n' {
                    // Inline markers cannot span newlines
                    return None;
                }
            }

            let mut content_span = self.span(content_start);

            // Find the rightmost matching end marker
            loop {
                let last_pos = self.mark();
                self.consume()?;
                if !self.at_sequence(marker) {
                    self.rewind(last_pos);
                    break;
                }

                content_span.end = self.cursor;
            }

            let content = self.extract_span(content_span);

            if content.chars().all(|c| c.is_whitespace()) {
                // Content cannot be all whitespace
                return None;
            }

            let tokens = Lexer::new_with_config(&content, LexerConfig {
                token_groups: TokenGroup::without(TokenGroup::Multiline),
                offset: content_span.start,
            }).run();

            self.consume_expected_sequence(marker).expect("We just checked for end marker");

            let span = self.span(start);

            Some(Token::$output { span, marker: Some(marker.to_string()), tokens })
        }
    };
}

/// Function type for token lexing functions.
type TryLexFn = fn(&mut Lexer) -> Option<Token>;

// Methods that construct tokens
impl Lexer {
    lex_inline_fn!(try_lex_bold:          ["__", "**"] => Bold);
    lex_inline_fn!(try_lex_italic:        ["_", "*"]   => Italic);
    lex_inline_fn!(try_lex_strikethrough: ["~~"]       => Strikethrough);
    lex_inline_fn!(try_lex_highlight:     ["=="]       => Highlight);

    fn try_lex_escaped_character(&mut self) -> Option<Token> {
        let start = self.mark();
        self.consume_expected('\\')?;
        let character = self.consume()?;
        let span = self.span(start);
        Some(Token::Escaped { span, character })
    }

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

        self.consume_if(|c| c == '\n');

        let span = self.span(start);
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

        let tag = self.consume_while(|c| c.is_alphabetic() || c.is_ascii_digit());

        if tag.is_empty() {
            return None;
        }

        let span = self.span(start);

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
        self.consume_expected(')')?;

        let (show_how, options) = match show_how.split_once('|') {
            Some((show_how, options)) => (show_how.to_string(), Some(options.to_string())),
            None => (show_how, None),
        };

        let (position, url) = match url.split_once('#') {
            Some((url, position)) => (Some(position.to_string()), url.to_string()),
            None => (None, url),
        };

        let span = self.span(start);

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
        self.consume_until(|c| matches!(c, ']' | '\n'));
        let inner_end = self.mark();

        if inner_start == inner_end {
            return None;
        }

        // If we hit a newline, this is not a valid internal link
        if self.current()? == '\n' {
            return None;
        }

        self.consume_expected(']')
            .expect(r"We just checked for '\n' and `None`");
        self.consume_expected(']')?;

        let inner = self.extract_span(Span::new(inner_start, inner_end));

        let mut dest;
        let mut position = None;
        let mut show_how = None;
        let mut options = None;

        let fields: Vec<_> = inner.split('|').collect();
        match fields.len() {
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
        if dest_fields.len() == 2 {
            position = Some(dest_fields[1].to_string());
            dest = dest_fields[0].to_string();
        }

        let span = self.span(start);

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

    fn at(&self, expect: char) -> Option<()> {
        if self.current() != Some(expect) {
            return None;
        }
        Some(())
    }

    fn at_line_start(&self) -> Option<()> {
        if !matches!(self.peek(-1), None | Some('\n')) {
            return None;
        }
        Some(())
    }

    fn at_line_end(&self) -> Option<()> {
        if !matches!(self.current(), None | Some('\n')) {
            return None;
        }
        Some(())
    }

    fn at_block_start(&self) -> Option<()> {
        self.at_line_start()?;

        let mut pos = 0;

        while self.peek(pos) == Some(' ') {
            pos += 1;
        }

        if !matches!(self.peek(pos), Some('>')) {
            return None;
        }

        Some(())
    }

    /// Extract the text contained within a block prefixed with '>'
    fn try_extract_block(&mut self) -> Option<String> {
        self.at_block_start()?;

        let start = self.mark();

        while self.at_block_start().is_some() {
            self.consume_until(|c| c == '\n');
            self.consume_expected('\n');
        }

        let source = self.extract(start);

        Some(source)
    }

    fn lex_block(source: &str, source_start: Mark) -> Tokens {
        let source = source.strip_suffix('\n').unwrap_or(source);
        let Mark(offset) = source_start;
        let mut lexer =
            Self::new_with_skip_function(source, skip_funcs::skip_block_prefix).with_offset(offset);
        lexer.run()
    }

    fn try_lex_quote(&mut self) -> Option<Token> {
        let start = self.mark();

        let source = self.try_extract_block()?;
        let mut source = source.trim();

        let parsed_author = (|| {
            let last_line = source.lines().last()?;
            let src_end = source.len() - last_line.len();
            let author = last_line
                .trim()
                .strip_prefix('>')?
                .trim_start()
                .strip_prefix(r"\-")?
                .trim_start();
            Some((author, src_end))
        })();

        let mut author = None;

        if let Some((name, src_end)) = parsed_author {
            source = &source[..src_end];
            source = source.strip_suffix('\n').unwrap_or(source);
            author = Some(name.to_string());
        }

        let tokens = Self::lex_block(source, start);

        let span = self.span(start);
        Some(Token::Quote {
            span,
            tokens,
            author,
        })
    }

    fn try_lex_callout(&mut self) -> Option<Token> {
        self.at_block_start()?;

        let start = self.mark();

        self.consume_expected('>')?;
        self.consume_until(|c| !c.is_whitespace() || c == '\n');

        self.consume_expected('[')?;
        self.consume_expected('!')?;
        let kind = self.consume_until(|c| c == ']');
        self.consume_expected(']')?;

        let mut foldable = false;
        if self.consume_if(|c| c == '-') {
            foldable = true;
        }

        self.consume_until(|c| c != ' ');
        let title = self.consume_until(|c| c == '\n');
        self.consume_expected('\n')?;

        let block_start = self.mark();
        let source = self.try_extract_block()?;
        let tokens = Self::lex_block(&source, block_start);

        let span = self.span(start);

        Some(Token::Callout {
            span,
            callout: Callout {
                kind,
                title,
                tokens,
                foldable,
            },
        })
    }

    fn try_lex_front_matter(&mut self) -> Option<Token> {
        if self.cursor != 0 {
            return None;
        }

        let start = self.mark();

        self.consume_expected_sequence("---")?;

        self.consume_until(|c| c != '-');
        self.consume_until(|c| !c.is_whitespace() || c == '\n');
        self.consume_expected('\n')?;

        let yaml_start = self.mark();
        loop {
            self.consume_until(|c| c == '-');
            if self.at_sequence("---") {
                break;
            }
            self.consume()?; // Consume single '-'
        }
        let yaml = self.extract(yaml_start);

        self.consume_expected_sequence("---")?;

        self.consume_until(|c| c != '-'); // Consume any remaining '-'

        // Consume any white space followed by a newline
        self.consume_until(|c| !c.is_whitespace() || c == '\n');
        self.consume_if(|c| c == '\n');

        let span = self.span(start);

        Some(Token::Frontmatter { span, yaml })
    }

    fn try_lex_comment(&mut self) -> Option<Token> {
        let start = self.mark();

        self.consume_expected_sequence("%%")?;

        let comment_start = self.mark();
        self.consume_until_sequence("%%")?;

        let comment = self.extract(comment_start);

        self.consume_expected_sequence("%%")?;

        let span = self.span(start);

        Some(Token::Comment { span, comment })
    }

    fn try_lex_divider(&mut self) -> Option<Token> {
        const DIVIDER_CHARS: &[char] = &['-', '*', '_'];

        self.at_line_start()?;

        let start = self.mark();

        let divider_char = self.current()?;

        if !DIVIDER_CHARS.contains(&divider_char) {
            return None;
        }

        // Consume at least 3 divider characters
        self.consume_expected(divider_char)?;
        self.consume_if(|c| c == ' ');
        self.consume_expected(divider_char)?;
        self.consume_if(|c| c == ' ');
        self.consume_expected(divider_char)?;
        self.consume_if(|c| c == ' ');

        // Consume any additional divider characters
        while self.current() == Some(divider_char) {
            self.consume_expected(divider_char)?;
            self.consume_if(|c| c == ' ');
        }

        self.consume_while(|c| c.is_whitespace() && c != '\n');

        self.at_line_end()?;

        self.consume_if(|c| c == '\n');

        let span = self.span(start);

        Some(Token::Divider { span })
    }

    fn try_lex_inline_code(&mut self) -> Option<Token> {
        let start = self.mark();

        self.consume_expected('`')?;

        let code_start = self.mark();
        self.consume_until(|c| c == '`');

        let code = self.extract(code_start);

        if code.is_empty() {
            return None;
        }

        self.consume_expected('`')?;

        let span = self.span(start);

        Some(Token::InlineCode { span, code })
    }

    fn try_lex_code(&mut self) -> Option<Token> {
        let start = self.mark();

        self.consume_expected_sequence("```")?;

        let lang = self.consume_until(|c| c == '\n');
        self.consume()?; // consume newline

        let lang = match lang.is_empty() {
            true => None,
            false => Some(lang),
        };

        let code_start = self.mark();
        self.consume_until_sequence("```")?;

        let code = self.extract(code_start);

        self.consume_expected_sequence("```")
            .expect("We just checked for '```'");
        self.consume_if(|c| c == '\n');

        let span = self.span(start);

        Some(Token::Code { span, lang, code })
    }

    fn try_lex_display_math(&mut self) -> Option<Token> {
        let start = self.mark();

        self.consume_expected_sequence("$$")?;

        let latex_start = self.mark();

        self.consume_until_sequence("$$")?;

        let latex = self.extract(latex_start);

        self.consume_expected_sequence("$$")
            .expect("We just checked for '$$'");

        let span = self.span(start);

        Some(Token::DisplayMath { span, latex })
    }

    fn try_lex_inline_math(&mut self) -> Option<Token> {
        let start = self.mark();

        self.consume_expected('$')?;

        let latex = self.consume_until(|c| c == '$');

        self.consume()?; // Consume '$'

        let span = self.span(start);

        Some(Token::InlineMath { span, latex })
    }

    fn try_extract_list_item(&mut self) -> Option<ListItem> {
        self.at_line_start()?;
        let start = self.mark();

        let mut indent = 0;
        while self.consume_if(|c| c == ' ') {
            indent += 1;
        }

        if !self.at_sequence("- ") {
            self.rewind(start);
            return None;
        }

        self.consume_expected_sequence("- ").unwrap();

        let start = self.mark();
        self.consume_until(|c| c == '\n');
        let span = self.span(start);
        let content = self.extract(start);

        self.consume_if(|c| c == '\n');

        let tokens = Lexer::new(content).collect::<Vec<_>>();

        Some(ListItem {
            indent,
            span,
            tokens,
        })
    }

    fn try_lex_list(&mut self) -> Option<Token> {
        let start = self.mark();

        let mut items = Vec::with_capacity(0);

        while let Some(item) = self.try_extract_list_item() {
            items.push(item);
        }

        if items.is_empty() {
            return None;
        }

        let span = self.span(start);

        Some(Token::List { span, items })
    }

    fn try_extract_numeric_list_item(&mut self) -> Option<NumericListItem> {
        self.at_line_start()?;
        let start = self.mark();

        let mut indent = 0;
        while self.consume_if(|c| c == ' ') {
            indent += 1;
        }

        let Some(number) = (|| {
            let number = self.consume_integer()?;
            self.consume_expected('.')?;
            self.consume_expected(' ')?;
            Some(number)
        })() else {
            self.rewind(start);
            return None;
        };

        self.consume_if(|c| c == ' ');

        let start = self.mark();
        self.consume_until(|c| c == '\n');
        let span = self.span(start);
        let content = self.extract(start);

        self.consume_if(|c| c == '\n');

        let tokens = Lexer::new(content).collect::<Vec<_>>();

        Some(NumericListItem {
            span,
            number,
            indent,
            tokens,
        })
    }

    fn try_lex_numeric_list(&mut self) -> Option<Token> {
        let start = self.mark();

        let mut items = Vec::with_capacity(0);

        while let Some(item) = self.try_extract_numeric_list_item() {
            items.push(item);
        }

        if items.is_empty() {
            return None;
        }

        Some(Token::NumericList {
            span: self.span(start),
            items,
        })
    }

    fn try_extract_checklist_item(&mut self) -> Option<CheckListItem> {
        self.at_line_start()?;
        let start = self.mark();

        let mut indent = 0;
        while self.consume_if(|c| c == ' ') {
            indent += 1;
        }

        let Some(checked) = (|| {
            self.consume_expected('-')?;
            self.consume_expected(' ')?;
            self.consume_expected('[')?;
            let checked = self.consume()? != ' ';
            self.consume_expected(']')?;
            self.consume_if(|c| c == ' ');
            Some(checked)
        })() else {
            self.rewind(start);
            return None;
        };

        let start = self.mark();
        self.consume_until(|c| c == '\n');
        let span = self.span(start);
        let content = self.extract(start);

        self.consume_if(|c| c == '\n');

        let tokens = Lexer::new(content).collect::<Vec<_>>();

        Some(CheckListItem {
            checked,
            indent,
            span,
            tokens,
        })
    }

    fn try_lex_checklist(&mut self) -> Option<Token> {
        let start = self.mark();
        let mut items = Vec::with_capacity(0);

        while let Some(item) = self.try_extract_checklist_item() {
            items.push(item);
        }

        if items.is_empty() {
            return None;
        }

        Some(Token::CheckList {
            span: self.span(start),
            items,
        })
    }

    fn try_lex_table(&mut self) -> Option<Token> {
        self.at_line_start()?;

        let start = self.mark();

        self.consume_whitespace();

        let walls = self.at('|').is_some();

        // First we get the header line
        let header_line = self.consume_until(|c| c == '\n');
        self.consume_expected('\n')?;

        let header_line = header_line.trim();

        // ... and the divider line. e.g. "----|----|----" or "| ---- | ---- | ---- |"
        let divider_line = self.consume_until(|c| c == '\n');
        _ = self.consume_expected('\n');

        fn line_to_cells(line: &str, walls: bool) -> Option<Vec<String>> {
            let line_chars: Vec<char> = line.trim().chars().collect();

            if line_chars.is_empty() {
                return None;
            }

            // Make sure walls are present if required
            if walls {
                if line_chars.first().is_none_or(|c| *c != '|') {
                    return None;
                }
                if line_chars.last().is_none_or(|c| *c != '|') {
                    return None;
                }
            }

            // Remove leading and trailing '|' if present
            let line_chars = line_chars.strip_prefix(&['|']).unwrap_or(&line_chars);
            let line_chars = line_chars.strip_suffix(&['|']).unwrap_or(line_chars);

            let mut cells: Vec<String> = Vec::new();

            let mut current_cell = String::new();

            let mut iter = line_chars.iter().peekable();

            loop {
                let Some(char) = iter.next() else {
                    cells.push(current_cell.trim().to_string());
                    break;
                };

                if *char == '\\' {
                    if let Some('|') = iter.peek() {
                        iter.next();
                        current_cell.push('|');
                        continue;
                    }
                }

                if *char == '|' {
                    cells.push(current_cell.trim().to_string());
                    current_cell.clear();
                    continue;
                }

                current_cell.push(*char);
            }

            Some(cells)
        }

        let headers: Vec<String> = line_to_cells(header_line, walls)?;
        let row_count = headers.len();

        if row_count == 0 {
            return None;
        }

        if !walls && row_count < 2 {
            return None;
        }

        let mut alignments = vec![TableAlignment::default(); row_count];

        // Make sure divider line is valid
        let divider_cells: Vec<String> = line_to_cells(&divider_line, walls)?;
        if divider_cells.len() != row_count {
            return None;
        }
        for (cell, align) in divider_cells.iter().zip(alignments.iter_mut()) {
            if cell.len() < 2 {
                return None;
            }

            let first_colon = cell.starts_with(':');
            let last_colon = cell.ends_with(':');

            let mut chars = cell.chars();

            // Remove colons for alignment checking
            if first_colon {
                chars.next();
            }
            if last_colon {
                chars.next_back();
            }

            if !chars.all(|c| c == '-') {
                return None;
            }

            *align = match (first_colon, last_colon) {
                (true, true) => TableAlignment::Center,
                (true, false) => TableAlignment::Left,
                (false, true) => TableAlignment::Right,
                (false, false) => TableAlignment::None,
            };
        }

        let mut rows: Vec<Vec<Tokens>> = Vec::new();

        loop {
            let line = self.consume_until(|c| c == '\n');
            _ = self.consume_expected('\n');

            let Some(row_string) = line_to_cells(&line, walls) else {
                break;
            };

            if row_string.len() != row_count {
                break;
            }

            let row_tokens: Vec<Tokens> = row_string
                .into_iter()
                .map(|cell| {
                    Lexer::new_with_config(
                        cell,
                        LexerConfig {
                            token_groups: TokenGroup::without(TokenGroup::Multiline),
                            offset: 0,
                        },
                    )
                    .run()
                })
                .collect();

            rows.push(row_tokens);
        }

        let span = self.span(start);
        Some(Token::Table {
            span,
            table: Table {
                headers,
                rows,
                alignments,
            },
        })
    }

    fn try_lex_templater_command(&mut self) -> Option<Token> {
        let start = self.mark();

        self.consume_expected_sequence("<%")?;

        let command_start = self.mark();

        self.consume_until_sequence("%>")?;

        let command = self.extract(command_start).trim().to_string();

        self.consume_expected_sequence("%>")
            .expect("We just checked for '%>'");

        let span = self.span(start);

        Some(Token::TemplaterCommand { span, command })
    }
}

impl Iterator for Lexer {
    type Item = Token;

    fn next(&mut self) -> Option<Self::Item> {
        use TokenGroup::*;

        #[rustfmt::skip]
        const LEXER_FUNCS: &[(TryLexFn, TokenGroup)] = &[
            (Lexer::try_lex_escaped_character, Inline),
            (Lexer::try_lex_heading,           Inline),
            (Lexer::try_lex_front_matter,      Inline),
            (Lexer::try_lex_divider,           Inline),
            (Lexer::try_lex_bold,              Inline),
            (Lexer::try_lex_italic,            Inline),
            (Lexer::try_lex_strikethrough,     Inline),
            (Lexer::try_lex_highlight,         Inline),
            (Lexer::try_lex_tag,               Inline),
            (Lexer::try_lex_code,              Inline),
            (Lexer::try_lex_inline_code,       Inline),
            (Lexer::try_lex_display_math,      Inline),
            (Lexer::try_lex_inline_math,       Inline),
            (Lexer::try_lex_internal_link,     Inline),
            (Lexer::try_lex_external_link,     Inline),
            (Lexer::try_lex_callout,           Multiline),
            (Lexer::try_lex_quote,             Multiline),
            (Lexer::try_lex_checklist,         Multiline),
            (Lexer::try_lex_list,              Multiline),
            (Lexer::try_lex_numeric_list,      Multiline),
            (Lexer::try_lex_table,             Inline),
            (Lexer::try_lex_comment,           Inline),
            (Lexer::try_lex_templater_command, Inline),
        ];

        'restart: loop {
            // Try all the lexer functions, to see if any can produce a token
            for (try_lex_func, group) in LEXER_FUNCS.iter() {
                if let Some(mut t) = self.queue.pop_front() {
                    // Shift the token span by the offset specified in the configuration
                    //
                    // This is done at the very latest moment, as the span is used internally
                    // to access text within the lexer source code.
                    t.span_mut().shift(self.config.offset as isize);

                    return Some(t);
                }

                if self.config.token_groups.contains(*group) {
                    let start = self.cursor;
                    let token = try_lex_func(self);
                    if let Some(token) = token {
                        // Add text between yielded tokens if any
                        if self.slow_cursor != start {
                            let span = Span {
                                start: self.slow_cursor,
                                end: start,
                            };
                            let text = self.extract_span(span);
                            self.queue.push_back(Token::Text { span, text });
                        }

                        // Push the found token to the queue
                        self.queue.push_back(token);
                        self.slow_cursor = self.cursor;

                        // Jump to beginning of loop and try to lex all tokens again
                        //
                        // This will pop the parsed token from the queue and return it
                        continue 'restart;
                    }

                    // Restore the cursor to the start position if no token was found
                    // The next lexing method will be tried after this
                    self.cursor = start;
                }
            }

            // Check if we are at the end of the file
            if self.current().is_none() {
                if self.slow_cursor >= self.chars.len() {
                    return None;
                }
                let start = Mark(self.slow_cursor);
                let text = self.extract(start);
                let span = self.span(start);
                self.queue.push_back(Token::Text { span, text });
                self.slow_cursor = self.cursor;
            }

            // Consume a text character
            self.consume();
        }
    }
}
