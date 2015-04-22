use helpers;

pub fn xor_against_single_char(string: Vec<u8>, xor_char: u8) -> Vec<u8> {
    let mut result : Vec<u8> = vec![];
    for idx in 0..string.len() {
        result.push(string[idx] ^ xor_char);
    };
    result
}

fn scan_letter_frequency(string: Vec<u8>) -> [u16; 26] {
    let mut result : [u16; 26] = [0; 26];
    for letter in string {
        println!("{}", letter);
        if letter >= 65 && letter <= 90 {
            let idx : u8 = letter - 65;
            result[idx as usize] += 1;
        } else if letter >= 97 && letter <= 122 {
            let idx : u8 = letter - 97;
            result[idx as usize] += 1;
        };
    }

    result
}

// Scores the string if it's close to natural frequency. The lower, the beter.
fn score_string(occurence: [u16; 26], length: u16) -> u16 {
    // This is expected (usual) frequency of particular letters in English phrases
    let expected_frequency = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    let mut scores = [0; 26];
    for idx in 0..25 {
        let letter_score = occurence[idx] * 100 / length;
        scores[idx] = expected_frequency[idx] - letter_score // TODO: absolute value of score
    };

    let mut final_score : u16= 0;
    for score in scores.iter() { final_score += *score };

    final_score
}

#[test]
fn test_score_string() {
    // Let's test "Foo bar"
    let input = [1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0];
    println!("{:?}", score_string(input, 7));

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

#[test]
fn test_scan_letter_frequency() {
    assert!(scan_letter_frequency("Foo bar".to_string().into_bytes()) ==
        [1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0]
    )
}
