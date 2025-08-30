//! This module defines the `Lexer` for parsing markdown notes into tokens.
use std::collections::VecDeque;

mod span;
pub mod tokens;

pub use span::Span;
use tokens::*;

#[derive(Debug, Clone, PartialEq)]
struct Mark(usize);
impl Copy for Mark {}

/// A lexer for parsing markdown into tokens.
pub struct Lexer {
    cursor: usize,
    slow_cursor: usize,
    chars: Vec<(usize, char)>,
    queue: VecDeque<Token>,
    skip_function: fn(&mut Self),
}

impl Lexer {
    /// Create a new lexer with the given text.
    pub fn new<S: ToString>(text: S) -> Self {
        let text = text.to_string().char_indices().collect::<Vec<_>>();
        Self {
            cursor: 0,
            slow_cursor: 0,
            chars: text,
            queue: Default::default(),
            skip_function: skip_funcs::no_skip,
        }
    }

    fn peek(&self, offset: isize) -> Option<char> {
        let index = self.cursor as isize + offset;
        if index < 0 {
            return None;
        }
        self.chars.get(index as usize).map(|(_, c)| *c)
    }

    fn current(&self) -> Option<char> {
        self.peek(0)
    }

    // Consume a character
    fn consume(&mut self) -> Option<char> {
        self.cursor += 1;
        (self.skip_function)(self);
        self.peek(-1)
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

    fn consume_while(&mut self, cond: impl Fn(char) -> bool) -> String {
        self.consume_until(|c| !cond(c))
    }

    fn consume_if(&mut self, cond: impl Fn(char) -> bool) -> bool {
        if self.current().is_some_and(cond) {
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

    fn chars_since(&self, mark: Mark) -> usize {
        let Mark(pos) = mark;
        self.cursor.saturating_sub(pos)
    }

    /// Get the text between the mark and the cursor
    fn extract(&self, start: Mark) -> String {
        self.extract_span(self.span(start))
    }

    fn extract_span(&self, span: Span) -> String {
        let Span { start, end } = span;
        if start >= self.chars.len() || end > self.chars.len() {
            return "".to_string();
        }
        self.chars[start..end].iter().map(|(_, c)| c).collect()
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
    pub fn no_skip(_: &mut Lexer) {}
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

        if self.peek(1)? != ']' {
            return None;
        }

        // If we hit a newline, this is not a valid internal link
        if self.current()? == '\n' {
            return None;
        }

        let inner = self.extract(inner_start);

        self.consume_expected(']')?;
        self.consume_expected(']')?;

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

    fn at_line_start(&self) -> Option<()> {
        if !matches!(self.peek(-1), None | Some('\n')) {
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

    // TODO: Fix "> " in latex tokens
    /// Extract the text contained within a block prefixed with '>'
    fn try_extract_block(&mut self) -> Option<(String, Vec<Token>)> {
        self.at_block_start()?;

        let start = self.mark();

        while self.at_block_start().is_some() {
            self.consume_until(|c| c == '\n');
            self.consume_expected('\n');
        }

        let text = self.extract(start);

        let mut lexer = Self::new(&text);
        lexer.skip_function = skip_funcs::skip_block_prefix;

        // Skip initial '> ' prefix to prevent infinite recursion
        skip_funcs::skip_block_prefix(&mut lexer);

        let mut tokens = lexer.collect::<Vec<_>>();

        // Shift all token spans by the start position
        let Mark(offset) = start;
        for token in &mut tokens {
            token.span_mut().shift(offset as isize);
        }

        Some((text, tokens))
    }

    fn try_lex_quote(&mut self) -> Option<Token> {
        let start = self.mark();
        let (text, tokens) = self.try_extract_block()?;
        let span = self.span(start);
        Some(Token::Quote { span, tokens, text })
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

        let (text, tokens) = self.try_extract_block()?;

        let span = self.span(start);

        Some(Token::Callout {
            span,
            callout: Callout {
                kind,
                title,
                text,
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

        let span = self.span(start);

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

        let span = self.span(start);

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

        let span = self.span(start);

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

        let span = self.span(start);

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

        let span = self.span(start);

        Some(Token::InlineMath { span, latex })
    }

    fn try_extract_checklist_item(&mut self) -> Option<CheckListItem> {
        self.at_line_start()?;

        let mut indent = 0;
        while self.consume_if(|c| c == ' ') {
            indent += 1;
        }

        self.consume_expected('-')?;
        self.consume_expected(' ')?;
        self.consume_expected('[')?;
        let checked = self.consume()? != ' ';
        self.consume_expected(']')?;

        let start = self.mark();
        self.consume_until(|c| c == '\n');
        self.consume_if(|c| c == '\n');
        let span = self.span(start);
        let content = self.extract(start);

        let tokens = Lexer::new(content).collect::<Vec<_>>();

        Some(CheckListItem {
            checked,
            indent,
            span,
            tokens,
        })
    }

    fn try_extract_list_item(&mut self) -> Option<ListItem> {
        self.at_line_start()?;

        let mut indent = 0;
        while self.consume_if(|c| c == ' ') {
            indent += 1;
        }

        self.consume_expected('-')?;
        self.consume_expected(' ')?;

        let start = self.mark();
        self.consume_until(|c| c == '\n');
        self.consume_if(|c| c == '\n');
        let span = self.span(start);
        let content = self.extract(start);

        let tokens = Lexer::new(content).collect::<Vec<_>>();

        Some(ListItem {
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

    fn try_lex_list(&mut self) -> Option<Token> {
        let start = self.mark();

        let mut items = Vec::with_capacity(0);

        while let Some(item) = self.try_extract_list_item() {
            items.push(item);
        }

        if items.is_empty() {
            return None;
        }

        Some(Token::List {
            span: self.span(start),
            items,
        })
    }

    fn try_lex_templater_command(&mut self) -> Option<Token> {
        let start = self.mark();

        self.consume_expected('<')?;
        self.consume_expected('%')?;

        let command_start = self.mark();
        self.consume_until(|c| c == '%');

        let command = self.extract(command_start).trim().to_string();

        self.consume_expected('%')?;
        self.consume_expected('>')?;

        let span = self.span(start);

        Some(Token::TemplaterCommand { span, command })
    }
}

impl Iterator for Lexer {
    type Item = Token;

    fn next(&mut self) -> Option<Self::Item> {
        loop {
            // This macro is used in the loop below and is core to the lexer logic.
            //
            // It attempts to lex a token using the specified method.
            //
            // If the method returns a token, that token is pushed to the lexer token queue.
            //
            // If the method does not return a token, the cursor is restored to the start position.
            // and the loop continues to try the next lexing method.
            macro_rules! please {
                ($method:ident) => {
                    let start = self.cursor;
                    let token = self.$method();
                    if let Some(token) = token {
                        if self.slow_cursor != start {
                            let span = Span {
                                start: self.slow_cursor,
                                end: start,
                            };
                            let text = self.extract_span(span);
                            self.queue.push_back(Token::Text { span, text });
                        }
                        self.queue.push_back(token);
                        self.slow_cursor = self.cursor;

                        // Jump to beginning of loop and try to lex all tokens again
                        continue;
                    }

                    // Restore the cursor to the start position if no token was found
                    // The next lexing method will be tried after this
                    self.cursor = start;
                };
            }

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
            please!(try_lex_checklist);
            please!(try_lex_list);
            please!(try_lex_templater_command);

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

/// Trait for converting an item into a Markdown string representation.
pub trait ToMarkdown {
    /// Converts the item to a Markdown string.
    fn to_markdown(&self) -> String;
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

#[cfg(test)]
mod tests {
    use super::*;

    macro_rules! test_lex_token {
        ($source:expr => $($token:tt)*) => {
            let mut lexer = Lexer::new($source);
            let token = lexer.next().unwrap();
            println!("\nRaw Source:\n{:?}", $source);
            println!("\nSource:\n{}", $source);
            println!("\nToken: {:#?}\n", token);
            assert_eq!(
                token,
                $($token)*
            );
        };
        ($source:expr) => {
            let mut lexer = Lexer::new($source);
            let token = lexer.next();
            println!("\nToken: {:#?}\n", token);
            todo!("No token expected");
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
            "> 'fun quote!'\n> \\- Author"
            => Token::Quote {
                span: Span { start: 0, end: 26 },
                text: "> 'fun quote!'\n> \\- Author".to_string(),
                tokens: vec![
                    Token::Text {
                        span: Span { start: 0, end: 26 },
                        text: "> 'fun quote!'\n> \\- Author".to_string(),
                    },
                ],
            }
        }
    }

    #[test]
    fn test_lex_templater_command() {
        test_lex_token! {
            "<% tp.file.include('path/to/file.md') %>"
            => Token::TemplaterCommand {
                span: Span { start: 0, end: 40 },
                command: "tp.file.include('path/to/file.md')".to_string(),
            }
        }
    }

    #[test]
    fn test_lex_callout() {
        test_lex_token! {
            "> [!kind]- Title!\n> this\n> is contents\n> #callout"
            => Token::Callout {
                span: Span { start: 0, end: 49 },
                callout: Callout {
                    kind: "kind".to_string(),
                    title: "Title!".to_string(),
                    text: "> this\n> is contents\n> #callout".to_string(),
                    tokens: vec![
                        Token::Text {
                            span: Span { start: 18, end: 41 },
                            text: "> this\n> is contents\n> ".to_string(),
                        },
                        Token::Tag {
                            span: Span { start: 41, end: 49 },
                            tag: "callout".to_string(),
                        }
                    ],
                    foldable: true,
                }
            }
        }
    }

    #[test]
    fn test_callout_with_math() {
        test_lex_token!(r">[!tip] Useful property
>$X$s do not have to be intependent.
>$$
>\mathbb{E}\left(\sum_{i}a_{i}X_{i} \right) = \sum_{i} a_{i} \mathbb{E}(X_{i})
>$$" => Token::Callout {
            span: Span {
                start: 0,
                end: 147,
            },
            callout: Callout {
                kind: "tip".to_string(),
                title: "Useful property".to_string(),
                text: ">$X$s do not have to be intependent.\n>$$\n>\\mathbb{E}\\left(\\sum_{i}a_{i}X_{i} \\right) = \\sum_{i} a_{i} \\mathbb{E}(X_{i})\n>$$".to_string(),
                tokens: vec![
                    Token::Text {
                        span: Span {
                            start: 24,
                            end: 25,
                        },
                        text: ">".to_string(),
                    },
                    Token::InlineMath {
                        span: Span {
                            start: 25,
                            end: 28,
                        },
                        latex: "X".to_string(),
                    },
                    Token::Text {
                        span: Span {
                            start: 28,
                            end: 62,
                        },
                        text: "s do not have to be intependent.\n>".to_string(),
                    },
                    Token::DisplayMath {
                        span: Span {
                            start: 62,
                            end: 147,
                        },
                        latex: "\n>\\mathbb{E}\\left(\\sum_{i}a_{i}X_{i} \\right) = \\sum_{i} a_{i} \\mathbb{E}(X_{i})\n>".to_string(),
                    },
                ],
                foldable: false,
            },
        }
        );
    }

    #[test]
    fn test_uneven_callout() {
        test_lex_token!(
                r">[!example]- Example of callout with uneven lines
>
>$$
>A=
>\left(
>\begin{array}{cc}
 >-5 & 2 \\
        >2 & -2 \\
>\end{array}
>\right)
>$$
>" => Token::Callout {
            span: Span {
                start: 0,
                end: 145,
            },
            callout: Callout {
                kind: "example".to_string(),
                title: "Example of callout with uneven lines".to_string(),
                tokens: vec![
                    Token::Text {
                        span: Span {
                            start: 50,
                            end: 53,
                        },
                        text: ">\n>".to_string(),
                    },
                    Token::DisplayMath {
                        span: Span {
                            start: 53,
                            end: 143,
                        },
                        latex:"\n>A=\n>\\left(\n>\\begin{array}{cc}\n >-5 & 2 \\\\\n        >2 & -2 \\\\\n>\\end{array}\n>\\right)\n>".to_string(),
                    },
                    Token::Text {
                        span: Span {
                            start: 143,
                            end: 145,
                        },
                        text: "\n>".to_string(),
                    },
                ],
                text:">\n>$$\n>A=\n>\\left(\n>\\begin{array}{cc}\n >-5 & 2 \\\\\n        >2 & -2 \\\\\n>\\end{array}\n>\\right)\n>$$\n>".to_string(),
                foldable: true,
            },
        });
    }

    #[test]
    fn test_lex_list() {
        test_lex_token! {
            "- item 1\n- item 2\n  - subitem\n  - [[link]]"
            => Token::List {
                span: Span {
                    start: 0,
                    end: 42,
                },
                items: vec![
                    ListItem {
                        span: Span {
                            start: 2,
                            end: 9,
                        },
                        indent: 0,
                        tokens: vec![
                            Token::Text {
                                span: Span {
                                    start: 0,
                                    end: 7,
                                },
                                text: "item 1\n".to_string(),
                            },
                        ],
                    },
                    ListItem {
                        span: Span {
                            start: 11,
                            end: 18,
                        },
                        indent: 0,
                        tokens: vec![
                            Token::Text {
                                span: Span {
                                    start: 0,
                                    end: 7,
                                },
                                text: "item 2\n".to_string(),
                            },
                        ],
                    },
                    ListItem {
                        span: Span {
                            start: 22,
                            end: 30,
                        },
                        indent: 2,
                        tokens: vec![
                            Token::Text {
                                span: Span {
                                    start: 0,
                                    end: 8,
                                },
                                text: "subitem\n".to_string(),
                            },
                        ],
                    },
                    ListItem {
                        span: Span {
                            start: 34,
                            end: 42,
                        },
                        indent: 2,
                        tokens: vec![
                            Token::InternalLink {
                                span: Span {
                                    start: 0,
                                    end: 8,
                                },
                                link: InternalLink {
                                    dest: "link".to_string(),
                                    position: None,
                                    show_how: None,
                                    options: None,
                                    render: false,
                                },
                            },
                        ],
                    },
                ],
            }
        };
    }

    #[test]
    fn test_lex_checklist() {
        test_lex_token! {
            "- [x] done item\n- [ ] todo item\n  - [ ] subitem\n  - [X] [[link]]"
            => Token::CheckList {
                span: Span {
                    start: 0,
                    end: 64,
                },
                items: vec![
                    CheckListItem {
                        checked: true,
                        span: Span {
                            start: 5,
                            end: 16,
                        },
                        indent: 0,
                        tokens: vec![
                            Token::Text {
                                span: Span {
                                    start: 0,
                                    end: 11,
                                },
                                text: " done item\n".to_string(),
                            },
                        ],
                    },
                    CheckListItem {
                        checked: false,
                        span: Span {
                            start: 21,
                            end: 32,
                        },
                        indent: 0,
                        tokens: vec![
                            Token::Text {
                                span: Span {
                                    start: 0,
                                    end: 11,
                                },
                                text: " todo item\n".to_string(),
                            },
                        ],
                    },
                    CheckListItem {
                        checked: false,
                        span: Span {
                            start: 39,
                            end: 48,
                        },
                        indent: 2,
                        tokens: vec![
                            Token::Text {
                                span: Span {
                                    start: 0,
                                    end: 9,
                                },
                                text: " subitem\n".to_string(),
                            },
                        ],
                    },
                    CheckListItem {
                        checked: true,
                        span: Span {
                            start: 55,
                            end: 64,
                        },
                        indent: 2,
                        tokens: vec![
                            Token::Text {
                                span: Span {
                                    start: 0,
                                    end: 1,
                                },
                                text: " ".to_string(),
                            },
                            Token::InternalLink {
                                span: Span {
                                    start: 1,
                                    end: 9,
                                },
                                link: InternalLink {
                                    dest: "link".to_string(),
                                    position: None,
                                    show_how: None,
                                    options: None,
                                    render: false,
                                },
                            },
                        ],
                    },
                ],
            }
        };
    }

    #[test]
    fn test_span_extraction() {
        let source = "This is å tæst string.";
        let mut lexer = Lexer::new(source);

        lexer.consume_until(|c| c == 't');
        let start = lexer.mark();
        lexer.consume_until(|c| c == '.');
        let span = lexer.span(start);

        println!("Span: {:?}", span);

        let extracted = lexer.extract_span(span);

        assert_eq!(extracted, "tæst string");
    }

    #[test]
    fn test_quote_span_extraction() {
        let source = "> This is [[å]] tæst string.\n> With inner [[en notææ|link]] lines.";

        println!("Source:\n{}\n", source);

        let mut lexer = Lexer::new(source);

        let token = lexer.next().unwrap();

        println!("{}: {:?}", token, token.span());

        // Test extracting of the link
        let Token::Quote { tokens, .. } = token else {
            panic!("Expected quote token");
        };

        for (i, token) in tokens.iter().enumerate() {
            let span = token.span();
            println!(
                "[{i}]    {}: {:?} => {:?}",
                token,
                span,
                span.extract(source)
            );
        }

        let link_spans: Vec<_> = tokens
            .iter()
            .filter_map(|t| match t {
                Token::InternalLink { span, .. } => Some(span),
                _ => None,
            })
            .collect();

        let extracted = lexer.extract_span(*link_spans[0]);
        assert_eq!(extracted, "[[å]]");

        let extracted = lexer.extract_span(*link_spans[1]);
        assert_eq!(extracted, "[[en notææ|link]]");
    }
}
