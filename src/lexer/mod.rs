//! This module defines the `Lexer` for parsing markdown notes into tokens.
use std::collections::VecDeque;

mod span;
mod to_markdown;
pub mod tokens;

#[cfg(test)]
mod tests;

pub use span::Span;
pub use to_markdown::ToMarkdown;
use tokens::*;

#[cfg(feature = "python")]
pub use to_markdown::py_to_markdown;

#[derive(Debug, Clone, PartialEq)]
struct Mark(usize);
impl Copy for Mark {}

impl Mark {
    const START: Self = Mark(0);
}

/// A lexer for parsing markdown into tokens.
pub struct Lexer {
    cursor: usize,
    slow_cursor: usize,
    chars: Vec<(usize, char, bool)>, // (position, char, skipped)
    queue: VecDeque<Token>,
}

impl Lexer {
    /// Create a new lexer with the given text.
    pub fn new<S: ToString>(text: S) -> Self {
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
    pub fn run(&mut self) -> Vec<Token> {
        Vec::from_iter(self)
    }

    fn peek(&self, mut offset: isize) -> Option<char> {
        let mut index = self.cursor as isize;

        while offset != 0 {
            if index < 0 {
                return None;
            }

            index += offset.signum();

            let (_, _, skipped) = self.chars.get(index as usize)?;

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

    fn consume_expected_sequence(&mut self, seq: &str) -> Option<()> {
        for expected in seq.chars() {
            self.consume_expected(expected)?;
        }
        Some(())
    }

    fn consume_until(&mut self, cond: impl Fn(char) -> bool) -> String {
        let start = self.mark();
        while self.current().is_some_and(|c| !cond(c)) {
            self.consume();
        }
        self.extract(start)
    }

    fn at_sequence(&self, seq: &str) -> bool {
        let mut found = true;
        for (i, c) in seq.chars().enumerate() {
            if self.peek(i as isize) != Some(c) {
                found = false;
                break;
            }
        }
        found
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
        if self.current().is_some_and(cond) {
            self.consume();
            return true;
        }
        false
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

    /// Extract the text contained within a block prefixed with '>'
    fn try_extract_block(&mut self) -> Option<Vec<Token>> {
        self.at_block_start()?;

        let start = self.mark();

        while self.at_block_start().is_some() {
            self.consume_until(|c| c == '\n');
            self.consume_expected('\n');
        }

        let source = self.extract(start);
        let source = source.strip_suffix('\n').unwrap_or(&source);

        let mut lexer = Self::new_with_skip_function(source, skip_funcs::skip_block_prefix);

        let mut tokens = lexer.run();

        // Shift all token spans by the start position
        let Mark(offset) = start;
        for token in &mut tokens {
            token.span_mut().shift(offset as isize);
        }

        Some(tokens)
    }

    fn try_lex_quote(&mut self) -> Option<Token> {
        let start = self.mark();
        let tokens = self.try_extract_block()?;
        let span = self.span(start);
        Some(Token::Quote { span, tokens })
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

        let tokens = self.try_extract_block()?;

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
        self.consume_until_sequence("```");

        let code = self.extract(code_start);

        self.consume_expected('`')?;
        self.consume_expected('`')?;
        self.consume_expected('`')?;
        self.consume_if(|c| c == '\n');

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
            please!(try_lex_numeric_list);
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
