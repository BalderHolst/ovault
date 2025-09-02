#![allow(unused)]

pub(crate) const WHITE: &str = "\x1b[37m";
pub(crate) const BLUE: &str = "\x1b[34m";
pub(crate) const YELLOW: &str = "\x1b[33m";
pub(crate) const RED: &str = "\x1b[31m";
pub(crate) const RESET: &str = "\x1b[0m";

/// Logs an debug message to the console in white color.
#[macro_export]
macro_rules! debug {
    ($($arg:tt)*) => ({
        println!("{color}[DEBUG] {msg}{reset}",
            msg   = format!($($arg)*,),
            color = crate::logging::WHITE,
            reset = crate::logging::RESET
        );
    })
}

/// Logs an info message to the console in blue color.
#[macro_export]
macro_rules! info {
    ($($arg:tt)*) => ({
        println!("{color}[INFO] {msg}{reset}",
            msg   = format!($($arg)*,),
            color = crate::logging::BLUE,
            reset = crate::logging::RESET
        );
    })
}

/// Logs a warning message to the console in yellow color.
#[macro_export]
macro_rules! warn {
    ($($arg:tt)*) => ({
        eprintln!("{color}[WARN] {msg}{reset}",
            msg   = format!($($arg)*,),
            color = crate::logging::YELLOW,
            reset = crate::logging::RESET
        );
    })
}

/// Logs an error message to the console in red color.
#[macro_export]
macro_rules! error {
    ($($arg:tt)*) => ({
        eprintln!("{color}[ERROR] {msg}{reset}",
            msg   = format!($($arg)*,),
            color = crate::logging::RED,
            reset = crate::logging::RESET
        );
    })
}
