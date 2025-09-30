use super::*;
use pretty_assertions::assert_eq;

#[test]
fn test_peeking() {
    let src = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

    {
        let mut lexer = Lexer::new(src);
        for i in 0..src.len() {
            let c = lexer.consume();
            assert_eq!(c, src.chars().nth(i), "at index {}", i);
        }
    }

    {
        fn skip_func(lexer: &mut Lexer) {
            let seq = "CDEFG";
            if lexer.at_sequence(seq) {
                lexer.consume_expected_sequence(seq).unwrap()
            }
        }
        let expected = "ABHIJKLMNOPQRSTUVWXYZ";

        let mut lexer = Lexer::new_with_skip_function(src, skip_func);

        assert_eq!(&lexer.extract_all(), expected);

        assert_eq!(lexer.peek(0), Some('A'));
        assert_eq!(lexer.peek(1), Some('B'));
        assert_eq!(lexer.peek(2), Some('H'));
        assert_eq!(lexer.peek(3), Some('I'));

        assert!(lexer.at_sequence(expected));

        for i in 0..expected.len() {
            let c = lexer.consume();
            assert_eq!(c, expected.chars().nth(i), "at index {}", i);
        }
    }
}

#[test]
fn test_callout_peeking() {
    let source = "> [!kind]- Title!\n> this\n> is content\n> #callout";
    let mut lexer = Lexer::new_with_skip_function(source, skip_funcs::skip_block_prefix);
    assert_eq!(
        &lexer.extract_all(),
        "[!kind]- Title!\nthis\nis content\n#callout"
    );

    while lexer.current().is_some() {
        println!("\nCursor: {}", lexer.cursor);
        assert_eq!(lexer.at_block_start(), None, "at cursor {}", lexer.cursor);
        lexer.consume();
    }
}

macro_rules! test_lex_token {
        ($source:expr => [$($tokens:tt)*]) => {
            let lexer = Lexer::new($source);
            let tokens = lexer.collect::<Vec<_>>();
            println!("\nRaw Source:\n{:?}", $source);
            println!("\nSource:\n{}", $source);
            println!("\nSourch Length: {}", $source.len());

            if tokens.len() == 1 {
                println!("\nToken: {:#?}\n", tokens[0]);
                let expected = vec![$($tokens)*][0].clone();
                assert_eq!(
                    expected,
                    tokens[0],
                );
            } else {
                println!("\nTokens: {:#?}\n", tokens);
                let expected = vec![$($tokens)*];

                if expected.len() != tokens.len() {
                    eprintln!(
                        "\nExpected Tokens: {:#?}\n",
                        expected
                    );
                    panic!(
                        "Number of tokens does not match: expected {}, got {}",
                        expected.len(),
                        tokens.len()
                    );
                }

                for (i, (expected, actual)) in expected.iter().zip(tokens.iter()).enumerate() {
                    assert_eq!(
                        expected,
                        actual,
                        "Token {} does not match",
                        i
                    );
                }
            }
        };
        ($source:expr => $($tokens:tt)*) => {
            test_lex_token!($source => [$($tokens)*]);
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
        "---\nkey: value\n---\n# this is a heading"
        => [
            Token::Frontmatter {
                span: Span { start: 0, end: 19 },
                yaml: "key: value\n".to_string()
            },
            Token::Header {
                span: Span { start: 19, end: 38 },
                level: 1,
                heading: "this is a heading".to_string()
            }
        ]
    };

    test_lex_token! {
        "---\nkey: value"
        => [
            Token::Divider {
                span: Span {
                    start: 0,
                    end: 4,
                },
            },
            Token::Text {
                span: Span {
                    start: 4,
                    end: 14,
                },
                text: "key: value".to_string(),
            }
        ]
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

    test_lex_token! {
        "### Heading"
        => Token::Header {
            span: Span { start: 0, end: 11 },
            level: 3,
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

    test_lex_token! {
        "this is not a tag: #@notag"
        => Token::Text {
            span: Span {
                start: 0,
                end: 26,
            },
            text: "this is not a tag: #@notag".to_string(),
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

    test_lex_token! {
        "[unfinished link](This is missing a closing parenthesis"
            => Token::Text {
            span: Span {
                start: 0,
                end: 55,
            },
            text: "[unfinished link](This is missing a closing parenthesis".to_string(),
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
        => [
            Token::InternalLink {
                span: Span { start: 0, end: 15 },
                link: InternalLink {
                    dest: "other_note".to_string(),
                    position: None,
                    show_how: None,
                    options: None,
                    render: true
                }
            },
            Token::Text {
                span: Span {
                    start: 15,
                    end: 16,
                },
                text: ".".to_string(),
            }
        ]
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

    test_lex_token! {
        "[[link\nwith newline]]"
            => Token::Text {
            span: Span {
                start: 0,
                end: 21,
            },
            text: "[[link\nwith newline]]".to_string(),
        }
    }

    test_lex_token! {
        "[[unfinished link]"
            => Token::Text {
            span: Span {
                start: 0,
                end: 18,
            },
            text: "[[unfinished link]".to_string(),
        }
    }
    test_lex_token! {
        "[[very unfinished link "
            => Token::Text {
            span: Span {
                start: 0,
                end: 23,
            },
            text: "[[very unfinished link ".to_string(),
        }
    }

    test_lex_token! {
        "[[]]"
            => Token::Text {
            span: Span {
                start: 0,
                end: 4,
            },
            text: "[[]]".to_string(),
        }
    }

    test_lex_token! {
        "[[don't|know|what|to do here]]"
            => Token::Text {
            span: Span {
                start: 0,
                end: 30,
            },
            text: "[[don't|know|what|to do here]]".to_string(),
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

    test_lex_token! {
        "```language\n```"
        => Token::Code {
            span: Span { start: 0, end: 15 },
            lang: Some("language".to_string()),
            code: "".to_string()
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

    test_lex_token! {
        "$$not ended"
        =>
        Token::InlineMath {
            span: Span {
                start: 0,
                end: 2,
            },
            latex: "".to_string(),
        },
        Token::Text {
            span: Span {
                start: 2,
                end: 11,
            },
            text: "not ended".to_string(),
        }
    }
}

#[test]
fn test_lex_quote() {
    test_lex_token! {
        "> 'fun quote!'\n> \\- Author"
        => Token::Quote {
            span: Span { start: 0, end: 26 },
            tokens: vec![
                Token::Text {
                    span: Span { start: 0, end: 26 },
                    text: "'fun quote!'\n\\- Author".to_string(),
                },
            ],
        }
    }
}

#[test]
fn test_lex_nested_quote() {
    test_lex_token! {
        "> Outer quote\n> > Inner #quote\n> Back to outer"
        => Token::Quote {
        span: Span {
            start: 0,
            end: 46,
        },
        tokens: vec![
            Token::Text {
                span: Span {
                    start: 0,
                    end: 16,
                },
                text: "Outer quote\n".to_string(),
            },
            Token::Quote {
                span: Span {
                    start: 16,
                    end: 33,
                },
                tokens: vec![
                    Token::Text {
                        span: Span {
                            start: 16,
                            end: 24,
                        },
                        text: "Inner ".to_string(),
                    },
                    Token::Tag {
                        span: Span {
                            start: 24,
                            end: 30,
                        },
                        tag: "quote".to_string(),
                    }
                ],
            },
            Token::Text {
                span: Span {
                    start: 33,
                    end: 46,
                },
                text: "Back to outer".to_string(),
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

    test_lex_token! {
        "<% unended command"
        => Token::Text {
            span: Span { start: 0, end: 18 },
            text: "<% unended command".to_string(),
        }
    }
}

#[test]
fn test_lex_callout() {
    test_lex_token! {
        "> [!kind]- Title!\n> this\n> is content\n> #callout"
        => Token::Callout {
            span: Span { start: 0, end: 48 },
            callout: Callout {
                kind: "kind".to_string(),
                title: "Title!".to_string(),
                tokens: vec![
                    Token::Text {
                        span: Span { start: 18, end: 40 },
                        text: "this\nis content\n".to_string(),
                    },
                    Token::Tag {
                        span: Span { start: 40, end: 48 },
                        tag: "callout".to_string(),
                    }
                ],
                foldable: true,
            }
        }
    }

    test_lex_token! {
        "> [!broken" =>
            Token::Quote {
                span: Span { start: 0, end: 10 },
                tokens: vec![
                    Token::Text {
                        span: Span { start: 0, end: 10 },
                        text: "[!broken".to_string(),
                    }
                ],
            }
    }

    test_lex_token! {
        "> [!info] Hello" =>
            Token::Quote {
                span: Span { start: 0, end: 15 },
                tokens: vec![
                    Token::Text {
                        span: Span { start: 0, end: 15 },
                        text: "[!info] Hello".to_string(),
                    }
                ],
            }
    }
}

#[test]
fn test_lex_nested_callout() {
    test_lex_token! {
        "> [!note] Outer callout\n> > [!link]- Inner callout\n> > [[Some link]]\n> Back to outer"
            => Token::Callout {
            span: Span {
                start: 0,
                end: 84,
            },
            callout: Callout {
                kind: "note".to_string(),
                title: "Outer callout".to_string(),
                tokens: vec![
                    Token::Text {
                        span: Span {
                            start: 24,
                            end: 26,
                        },
                        text: "".to_string(),
                    },
                    Token::Callout {
                        span: Span {
                            start: 26,
                            end: 71,
                        },
                        callout: Callout {
                            kind: "link".to_string(),
                            title: "Inner callout".to_string(),
                            tokens: vec![
                                Token::Text {
                                    span: Span {
                                        start: 29,
                                        end: 31,
                                    },
                                    text: "".to_string(),
                                },
                                Token::InternalLink {
                                    span: Span {
                                        start: 31,
                                        end: 44,
                                    },
                                    link: InternalLink {
                                        dest: "Some link".to_string(),
                                        position: None,
                                        show_how: None,
                                        options: None,
                                        render: false,
                                    },
                                },
                            ],
                            foldable: true,
                        },
                    },
                    Token::Text {
                        span: Span {
                            start: 71,
                            end: 84,
                        },
                        text: "Back to outer".to_string(),
                    },
                ],
                foldable: false,
            },
        }
    }
}

#[test]
fn test_nested_callout_with_code() {
    test_lex_token! {
        ">[!multi-column]\n>>[!blank-container]\n>>```dataviewjs\n>>```"
        => Token::Callout {
            span: Span {
                start: 0,
                end: 59,
            },
            callout: Callout {
                kind: "multi-column".to_string(),
                title: "".to_string(),
                tokens: vec![
                    Token::Text {
                        span: Span {
                            start: 17,
                            end: 18,
                        },
                        text: "".to_string(),
                    },
                    Token::Callout {
                        span: Span {
                            start: 18,
                            end: 59,
                        },
                        callout: Callout {
                            kind: "blank-container".to_string(),
                            title: "".to_string(),
                            tokens: vec![
                                Token::Text {
                                    span: Span {
                                        start: 22,
                                        end: 23,
                                    },
                                    text: "".to_string(),
                                },
                                Token::Code {
                                    span: Span {
                                        start: 23,
                                        end: 41,
                                    },
                                    lang: Some(
                                        "dataviewjs".to_string(),
                                    ),
                                    code: "".to_string(),
                                },
                            ],
                            foldable: false,
                        },
                    },
                ],
                foldable: false,
            },
        }
    };
}

#[test]
fn test_callout_with_math() {
    test_lex_token!(">[!tip] Useful property\n>$X$s do not have to be intependent.\n>$$\n>\\mathbb{E}\\left(\\sum_{i}a_{i}X_{i} \\right) = \\sum_{i} a_{i} \\mathbb{E}(X_{i})\n>$$" => Token::Callout {
        span: Span {
            start: 0,
            end: 147,
        },
        callout: Callout {
            kind: "tip".to_string(),
            title: "Useful property".to_string(),
            tokens: vec![
                Token::Text {
                    span: Span {
                        start: 24,
                        end: 25,
                    },
                    text: "".to_string(),
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
                    text: "s do not have to be intependent.\n".to_string(),
                },
                Token::DisplayMath {
                    span: Span {
                        start: 62,
                        end: 147,
                    },
                    latex: "\n\\mathbb{E}\\left(\\sum_{i}a_{i}X_{i} \\right) = \\sum_{i} a_{i} \\mathbb{E}(X_{i})\n".to_string(),
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
            end: 141,
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
                    text: "\n".to_string(),
                },
                Token::DisplayMath {
                    span: Span {
                        start: 53,
                        end: 139,
                    },
                    latex:"\nA=\n\\left(\n\\begin{array}{cc}\n-5 & 2 \\\\\n2 & -2 \\\\\n\\end{array}\n\\right)\n".to_string(),
                },
                Token::Text {
                    span: Span {
                        start: 139,
                        end: 141,
                    },
                    text: "\n".to_string(),
                },
            ],
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
                        end: 8,
                    },
                    indent: 0,
                    tokens: vec![
                        Token::Text {
                            span: Span {
                                start: 0,
                                end: 6,
                            },
                            text: "item 1".to_string(),
                        },
                    ],
                },
                ListItem {
                    span: Span {
                        start: 11,
                        end: 17,
                    },
                    indent: 0,
                    tokens: vec![
                        Token::Text {
                            span: Span {
                                start: 0,
                                end: 6,
                            },
                            text: "item 2".to_string(),
                        },
                    ],
                },
                ListItem {
                    span: Span {
                        start: 22,
                        end: 29,
                    },
                    indent: 2,
                    tokens: vec![
                        Token::Text {
                            span: Span {
                                start: 0,
                                end: 7,
                            },
                            text: "subitem".to_string(),
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
fn test_lex_numeric_list() {
    test_lex_token! {
    "1. item 1\n2. item 2\n  1. subitem\n  2. [[link]]"
    => Token::NumericList {
        span: Span {
            start: 0,
            end: 46,
        },
        items: vec![
            NumericListItem {
                span: Span {
                    start: 3,
                    end: 9,
                },
                number: 1,
                indent: 0,
                tokens: vec![
                    Token::Text {
                        span: Span {
                            start: 0,
                            end: 6,
                        },
                        text: "item 1".to_string(),
                    },
                ],
            },
            NumericListItem {
                span: Span {
                    start: 13,
                    end: 19,
                },
                number: 2,
                indent: 0,
                tokens: vec![
                    Token::Text {
                        span: Span {
                            start: 0,
                            end: 6,
                        },
                        text: "item 2".to_string(),
                    },
                ],
            },
            NumericListItem {
                span: Span {
                    start: 25,
                    end: 32,
                },
                number: 1,
                indent: 2,
                tokens: vec![
                    Token::Text {
                        span: Span {
                            start: 0,
                            end: 7,
                        },
                        text: "subitem".to_string(),
                    },
                ],
            },
            NumericListItem {
                span: Span {
                    start: 38,
                    end: 46,
                },
                number: 2,
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
                        start: 6,
                        end: 15,
                    },
                    indent: 0,
                    tokens: vec![
                        Token::Text {
                            span: Span {
                                start: 0,
                                end: 9,
                            },
                            text: "done item".to_string(),
                        },
                    ],
                },
                CheckListItem {
                    checked: false,
                    span: Span {
                        start: 22,
                        end: 31,
                    },
                    indent: 0,
                    tokens: vec![
                        Token::Text {
                            span: Span {
                                start: 0,
                                end: 9,
                            },
                            text: "todo item".to_string(),
                        },
                    ],
                },
                CheckListItem {
                    checked: false,
                    span: Span {
                        start: 40,
                        end: 47,
                    },
                    indent: 2,
                    tokens: vec![
                        Token::Text {
                            span: Span {
                                start: 0,
                                end: 7,
                            },
                            text: "subitem".to_string(),
                        },
                    ],
                },
                CheckListItem {
                    checked: true,
                    span: Span {
                        start: 56,
                        end: 64,
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
