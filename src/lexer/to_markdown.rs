#[cfg(feature = "python")]
use super::tokens::*;

/// Trait for converting an item into a Markdown string representation.
///
/// Token spans have no effect on the output.
pub trait ToMarkdown {
    /// Converts the item to a Markdown string.
    fn to_markdown(&self) -> String;
}

fn tokens_to_markdown(tokens: &[Token]) -> String {
    tokens.iter().map(|t| t.to_markdown()).collect()
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
            Token::Code {
                span: _,
                lang,
                code,
            } => format!("```{}\n{}\n```\n", lang.as_deref().unwrap_or(""), code),
            Token::Quote {
                span: _,
                tokens,
                text: _,
            } => format!(
                "> {content}\n",
                content = tokens_to_markdown(tokens).replace('\n', "\n> ")
            ),
            Token::InlineMath { span: _, latex } => format!("${latex}$"),
            Token::DisplayMath { span: _, latex } => format!("$${latex}$$"),
            Token::Divider { span: _ } => format!("---\n"),
            Token::Callout { span: _, callout } => callout.to_markdown(),
            Token::InternalLink { span: _, link } => link.to_markdown(),
            Token::ExternalLink { span: _, link } => link.to_markdown(),
            Token::List { span: _, items } => items
                .iter()
                .map(ListItem::to_markdown)
                .collect::<Vec<_>>()
                .join(""),
            Token::CheckList { span: _, items } => items
                .iter()
                .map(CheckListItem::to_markdown)
                .collect::<Vec<_>>()
                .join(""),
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
            text: _,
            foldable,
        } = self;
        format!(
            "> [!{kind}]{dash} {title}\n>{content}\n",
            dash = if *foldable { "-" } else { "" },
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
