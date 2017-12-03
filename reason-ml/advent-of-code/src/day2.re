let massageInput = (text) => {
  let lines = Js.String.split("\n", text);
  Array.map((line) => Array.map(float_of_string, Js.String.split("\t", line)), lines)
};

let getChecksum = (line) => {
  let min = Array.fold_left((min, elem) => elem < min ? elem : min, line[0], line);
  let max = Array.fold_left((max, elem) => elem > max ? elem : max, line[0], line);
  int_of_float(max -. min)
};

let getDivisionChecksum = (line) => {
  let divisionMatrix =
    Array.map((divider) => Array.to_list(Array.map((dividee) => divider /. dividee, line)), line);
  let divisionFound =
    List.find(
      (element) => element != 1.0 && element == floor(element),
      List.flatten(Array.to_list(divisionMatrix))
    );
  int_of_float(divisionFound)
};

let solution1 = (input) =>
  Array.fold_left((total, line) => total + getChecksum(line), 0, massageInput(input));

let solution2 = (input) =>
  Array.fold_left((total, line) => total + getDivisionChecksum(line), 0, massageInput(input));

Js.log(solution1("5\t1\t9\t5\n7\t5\t3\n2\t4\t6\t8"));

Js.log(solution2("5\t9\t2\t8\n9\t4\t7\t3\n3\t8\t6\t5"));