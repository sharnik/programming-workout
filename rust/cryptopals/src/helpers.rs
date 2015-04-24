extern crate rustc_serialize;

use self::rustc_serialize::hex::FromHex;
use self::rustc_serialize::base64::{ToBase64, STANDARD, Config};

pub fn pretty_print(string: Vec<u8>) -> String {
    match String::from_utf8(string) {
        Ok(v) => { v }
        Err(_) => { "UNPRINTABLE".to_string() }
    }
}

pub fn hex_to_byte_string(hex: &str) -> Vec<u8> {
    match hex.from_hex() {
        Ok(v) => { v }
        Err(e) => { panic!("Can't parse hex: {:?}, error: {:?}", hex, e) }
    }
}

#[test]
fn test_hex_to_byte_string() {
    assert!(hex_to_byte_string("666f6f20626172") == "foo bar".to_string().into_bytes());
}

pub fn byte_string_to_base64(bytes: Vec<u8>) -> String {
    let config = Config {
        char_set: STANDARD.char_set,
        newline: STANDARD.newline,
        pad: false,
        line_length: STANDARD.line_length,
    };
    bytes.to_base64(config)
}

#[test]
fn test_byte_string_to_base64() {
    let input = "foo bar".
        to_string().into_bytes();
    let output = "Zm9vIGJhcg".to_string();

    assert!(byte_string_to_base64(input) == output);
}

pub fn xor_byte_strings(string_a: Vec<u8>, string_b: Vec<u8>) -> Vec<u8> {
    let mut string_c : Vec<u8> = vec![];
    for idx in 0..string_a.len() {
        string_c.push(string_a[idx] ^ string_b[idx]);
    }
    string_c
}

