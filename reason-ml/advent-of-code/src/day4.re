let massageInput = (text) => {
  let lines = Js.String.split("\n", text);
  Array.map(
    (line) => {
      let wordArray = Js.String.split(" ", line);
      Array.to_list(wordArray)
    },
    lines
  )
};

let validateUniqPassphrase = (phrase) => {
  let uniqWords = List.sort_uniq(Pervasives.compare, phrase);
  List.length(phrase) == List.length(uniqWords) ? 1 : 0
};

let validateAnagramPassphrase = (phrase) => {
  let sortedPassPhrase =
    List.map(
      (word) => {
        let letters = Array.to_list(Js.String.split("", word));
        List.sort(Pervasives.compare, letters)
      },
      phrase
    );
  let uniqWords = List.sort_uniq(Pervasives.compare, sortedPassPhrase);
  List.length(phrase) == List.length(uniqWords) ? 1 : 0
};

let solution1 = (input) =>
  Array.fold_left((total, line) => total + validateUniqPassphrase(line), 0, massageInput(input));

let solution2 = (input) =>
  Array.fold_left(
    (total, line) => total + validateAnagramPassphrase(line),
    0,
    massageInput(input)
  );

Js.log(solution1("aa bb cc dd ee"));

Js.log(solution1("aa bb cc dd aa"));

Js.log(solution1("aa bb cc dd aaa"));

Js.log("Part 2");

Js.log(solution2("abcde fghij"));

Js.log(solution2("abcde xyz ecdab"));

Js.log(solution2("a ab abc abd abf abj"));

Js.log(solution2("iiii oiii ooii oooi oooo"));

Js.log(solution2("oiii ioii iioi iiio"));