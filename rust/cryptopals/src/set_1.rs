use helpers;
use std::str::from_utf8;

pub fn break_single_char_xor(string: &str ) -> Vec<u8> {
    let byte_string = helpers::hex_to_byte_string(string.to_string());
    let mut tmp_score : f32 = (byte_string.len() as f32) * 10.0;
    let mut tmp_result : Vec<u8> = "💩 ".to_string().into_bytes();
    for k in 0..128 {
        let result = xor_against_single_char(byte_string.clone(), k);
        let length = result.len() as u16;
        let result_score = score_string(scan_letter_frequency(result.clone()), length);
        if result_score < tmp_score {
            tmp_score = result_score.clone();
            tmp_result = result.clone();
        };
        println!("k: {:?}, result: {:?}, score: {:?}", k, from_utf8(&result), result_score);
    }
    println!("Final result: {:?}", from_utf8(&tmp_result));
    tmp_result
}

fn xor_against_single_char(string: Vec<u8>, xor_char: u8) -> Vec<u8> {
    let mut result : Vec<u8> = vec![];
    for idx in 0..string.len() {
        result.push(string[idx] ^ xor_char);
    };
    result
}

// Scans the string and counts letter occurences
fn scan_letter_frequency(string: Vec<u8>) -> [u16; 26] {
    let mut result : [u16; 26] = [0; 26];
    for letter in string {
        if letter >= 65 && letter <= 90 {
            let idx : u8 = letter - 65;
            result[idx as usize] += 1;
        } else if letter >= 97 && letter <= 122 {
            let idx : u8 = letter - 97;
            result[idx as usize] = result[idx as usize ] + 1;
        };
    }

    result
}

// Scores the string if it's close to natural frequency. The lower, the beter.
fn score_string(occurence: [u16; 26], length: u16) -> f32 {
    // This is expected (usual) frequency of particular letters in English phrases
    let expected_frequency = [8.167, 1.492, 2.782, 4.253, 12.702, 2.228, 2.015, 6.094, 6.966, 0.153,
        0.772, 4.025, 2.406, 6.749, 7.507, 1.929, 0.095, 5.987, 6.327, 9.056, 2.758, 0.978, 2.360,
        0.150, 1.974, 0.074];
    let mut scores = [0.0; 26];
    for idx in 0..26 {
        let letter_score : f32 = (occurence[idx] as f32) * 100.0 / (length as f32);
        scores[idx] = (expected_frequency[idx] - letter_score).abs();
    };

    let mut final_score : f32 = 0.0;
    for score in scores.iter() { final_score = final_score + *score };

    final_score
}

#[test]
fn test_score_string() {
    // Let's test "Foo bar"
    let input = [1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0];
    assert!(score_string(input, 7) == 134.951294);
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
