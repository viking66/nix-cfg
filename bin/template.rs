#!/usr/bin/env nix-shell
//! ```cargo
//! [dependencies]
//! time = "0.1.25"
//! ```
/*
#!nix-shell -i rust-script -p rustc -p rust-script -p cargo
*/
fn main() {
    for argument in std::env::args().skip(1) {
        println!("{}", argument);
    };
    println!("{}", std::env::var("HOME").expect(""));
    println!("{}", time::now().rfc822z());
}
