extern crate rustc_serialize;

use rustc_serialize::hex::FromHex;
use rustc_serialize::base64::{ToBase64, STANDARD, Config};

fn hex_to_byte_string(hex: String) -> Vec<u8> {
    match hex.from_hex() {
        Ok(v) => { v }
        Err(e) => { panic!("Can't parse hex: {:?}, error: {:?}", hex, e) }
    }
}

fn byte_string_to_base64(bytes: Vec<u8>) -> String {
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

#[test]
fn test_hex_to_byte_string() {
    assert!(hex_to_byte_string("666f6f20626172".to_string()) == "foo bar".to_string().into_bytes());
}

#[test]
fn test_set_1_challenge_1() {
    assert!(byte_string_to_base64(hex_to_byte_string(
        "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d".to_string())) ==
        "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t".to_string());
}
