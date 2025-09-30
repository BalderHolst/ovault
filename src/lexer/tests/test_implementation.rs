use super::*;

#[test]
fn test_peek_range() {
    let source = "# Hello!";
    let mut lexer = Lexer::new(source);

    for i in 0..source.len() {
        assert_eq!(lexer.peek(i as isize), Some(source.as_bytes()[i] as char));
    }

    assert_eq!(lexer.peek(source.len() as isize), None);
    assert_eq!(lexer.peek(-1), None);

    for _ in 0..2 {
        lexer.consume();
    }

    assert_eq!(lexer.peek(0), Some('H'));
    assert_eq!(lexer.peek(-1), Some(' '));
    assert_eq!(lexer.peek(-2), Some('#'));
    assert_eq!(lexer.peek(-3), None);
    assert_eq!(lexer.peek(6), None);
}

#[test]
fn test_consume_if() {
    let source = "# Hello!";
    let mut lexer = Lexer::new(source);

    lexer.consume_if(|c| c == '#');

    assert_eq!(lexer.cursor, 1);
    lexer.consume_if(|c| c == ' ');
    assert_eq!(lexer.cursor, 2);

    lexer.consume_if(|c| c == 'ø');
    lexer.consume_if(|c| c == 'ø');

    assert_eq!(lexer.cursor, 2);
}
