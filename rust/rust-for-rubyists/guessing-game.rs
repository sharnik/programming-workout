use std::io;
use std::rand::Rng;

fn main() {
    let secret_number = std::rand::task_rng().gen_range(1i, 101);

    let mut counter = 0;
    let mut reader = io::stdin();
    loop {
        counter += 1;
        if counter > 5 {
            println!("You failed to guess {:d}!", secret_number);
            break;
        }

        println!("Your guess:");
        let input = reader.read_line().ok().expect("Failed to read line");
        let input_num: Option<int> = from_str(input.as_slice().trim());
        let num = match input_num {
            Some(number) => number,
            None => {
                println!("Number, I said.");
                continue;
            }
        };

        match num.cmp(&secret_number) {
            Less => println!("You shot too low."),
            Equal => {
                println!("Congratulation! You win.");
                break;
            },
            Greater => println!("You shot too high.")
        };
    }
}