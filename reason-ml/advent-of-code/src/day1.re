/* Part 1 */
let massagedInput = (text) => {
  let splitArray = Js.String.split("", text);
  Array.map(int_of_string, splitArray)
};

let sumJumpedDigits = (digits, jump) => {
  let length = Array.length(digits);
  Array.fold_left(
    (total, elem) => total + elem,
    0,
    Array.mapi(
      (index, element) => {
        let nextElement =
          if (index + jump >= length) {
            digits[index + jump - length]
          } else {
            digits[index + jump]
          };
        if (element == nextElement) {
          element
        } else {
          0
        }
      },
      digits
    )
  )
};

let solution1 = (text) => sumJumpedDigits(massagedInput(text), 1);

let solution2 = (text) => sumJumpedDigits(massagedInput(text), String.length(text) / 2);

Js.log("Part 1!");

Js.log(solution1("1122"));

Js.log(solution1("1111"));

Js.log(solution1("1234"));

Js.log(solution1("91212129"));

Js.log("Part 2!");

Js.log(solution2("1212"));

Js.log(solution2("1221"));

Js.log(solution2("123425"));

Js.log(solution2("123123"));

Js.log(solution2("12131415"));