// This binary implementation is only meant to be for debugging

mod lexer;

fn main() {
    let mut args = std::env::args();
    let _program = args.next();

    let cmd = args.next().expect("Expected a command");

    match cmd.as_str() {
        "tokenize" => {
            let path = args.next().expect("Expected a file path");
            let text = std::fs::read_to_string(path).unwrap();
            for (i, token) in lexer::Lexer::new(text).enumerate() {
                println!("{i}: {token:?}");
            }
        }
        "lint" => {
            let path = args.next().expect("Expected a file path");
            let text = std::fs::read_to_string(path).unwrap();
            let tokens = lexer::Lexer::new(text).run();
            let md = lexer::tokens_to_markdown(&tokens);
            println!("{md}")
        }
        other => eprintln!("Unknown command: {other}"),
    }
}
