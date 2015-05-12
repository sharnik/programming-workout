use std::fs::File;
use std::io::prelude::*;

mod helpers;
mod set_1;

#[test]
fn test_set_1_challenge_1() {
    assert!(helpers::byte_string_to_base64(helpers::hex_to_byte_string(
        "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d")) ==
        "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t".to_string());
}

#[test]
fn test_set_1_challenge_2() {
    let string_1 = helpers::hex_to_byte_string("1c0111001f010100061a024b53535009181c");
    let string_2 = helpers::hex_to_byte_string("686974207468652062756c6c277320657965");
    let string_3 = helpers::hex_to_byte_string("746865206b696420646f6e277420706c6179");
    let test = helpers::xor_byte_strings(string_1, string_2);
    assert!(test == string_3)
}

#[test]
fn test_set_1_challenge_3() {
    let broken_code = set_1::break_single_char_xor(
        vec!["1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736"]);
    assert!(broken_code == "Cooking MC\'s like a pound of bacon".to_string().into_bytes());
}

#[test]
fn test_set_1_challenge_4() {
    let mut file = match File::open("fixtures/set-1-challenge-4.txt") {
        Ok(v) => { v }
        Err(e) => { panic!("Can't open file, error: {:?}", e) }
    };
    let mut s = String::new();
    match file.read_to_string(&mut s) {
        Ok(_) => { ; }
        Err(e) => { panic!("Can't read file, error: {:?}", e) }
    };
    let string_collection : Vec<&str> = s.lines().collect();
    let da_vinci_string = set_1::break_single_char_xor(string_collection);
    assert!(da_vinci_string == "Now that the party is jumping\n".to_string().into_bytes());
}

#[test]
fn test_set_1_challenge_5() {
    assert!(set_1::repeating_key_xor("Burning 'em, if you ain't quick and nimble\nI go crazy when I hear a cymbal", "ICE") ==
        "0b3637272a2b2e63622c2e69692a23693a2a3c6324202d623d63343c2a26226324272765272a282b2f20430a652e2c652a3124333a653e2b2027630c692b20283165286326302e27282f");
}

#[test]
fn test_set_1_challenge_6() {
    set_1::break_repeating_key_xor("blah");
    assert!(false);
}
