mod helpers;

#[test]
fn test_set_1_challenge_2() {
    let string_1 = helpers::hex_to_byte_string("1c0111001f010100061a024b53535009181c".to_string());
    let string_2 = helpers::hex_to_byte_string("686974207468652062756c6c277320657965".to_string());
    let string_3 = helpers::hex_to_byte_string("746865206b696420646f6e277420706c6179".to_string());
    let test = helpers::xor_byte_strings(string_1, string_2);
    assert!(test == string_3)
}

#[test]
fn test_set_1_challenge_1() {
    assert!(helpers::byte_string_to_base64(helpers::hex_to_byte_string(
        "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d".to_string())) ==
        "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t".to_string());
}

