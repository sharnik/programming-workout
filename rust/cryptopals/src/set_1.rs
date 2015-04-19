use helpers;

pub fn xor_against_single_char(string: Vec<u8>, xor_char: u8) -> Vec<u8> {
    let mut result : Vec<u8> = vec![];
    for idx in 0..string.len() {
        result.push(string[idx] ^ xor_char);
    };
    result
}

#[test]
fn test_single_char_xor() {
    let string = helpers::hex_to_byte_string("1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736".
        to_string());
    let xor_char : u8 = 88;
    let result = match String::from_utf8(xor_against_single_char(string.clone(), xor_char)) {
        Ok(v) => { v }
        Err(_) => { panic!("Wrong utf conversion") }
    };

    assert!(result == "Cooking MC\'s like a pound of bacon".to_string());
}
