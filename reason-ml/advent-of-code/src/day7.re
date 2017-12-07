type node = {
  name: string,
  weight: int,
  content: list(string)
};

let massageInput = (text) => {
  let lines = Array.to_list(Js.String.split("\n", text));
  List.map(
    (line) => {
      /* Structure: fwft (72) -> ktlj, cntj, xhth */
      let lineData = Js.String.split(" ", line);
      {
        name: lineData[0],
        weight: int_of_string(Js.String.slice(~from=1, ~to_=(-1), lineData[1])),
        content:
          List.map(
            (name) => Js.String.replace(",", "", name),
            Array.to_list(Js.Array.slice(~start=3, ~end_=(-1), lineData))
          )
      }
    },
    lines
  )
};

let findLeaves = (nodes) => List.filter((node) => node.content == [], nodes);

let removeLeavesReferences = (nodes, leavesToTrim) => {
  let trimmedNodes = List.filter((node) => node.content != [], nodes);
  List.map(
    (node) => {
      ...node,
      content:
        List.filter(
          (contentElementName) => {
            let shouldBeTrimmed =
              List.exists((nodeToTrim) => contentElementName == nodeToTrim.name, leavesToTrim);
            shouldBeTrimmed ? false : true
          },
          node.content
        )
    },
    trimmedNodes
  )
};

let solution1 = (input) => {
  let inputNodes = ref(input);
  while (List.length(inputNodes^) > 1) {
    let leavesToTrim = findLeaves(inputNodes^);
    inputNodes := removeLeavesReferences(inputNodes^, leavesToTrim)
  };
  List.hd(inputNodes^)
};

let inputExample = "pbga (66)\nxhth (57)\nebii (61)\nhavc (66)\nktlj (57)\nfwft (72) -> ktlj, cntj, xhth\nqoyq (66)\npadx (45) -> pbga, havc, qoyq\ntknk (41) -> ugml, padx, fwft\njptl (61)\nugml (68) -> gyxo, ebii, jptl\ngyxo (61)\ncntj (57)";

Js.log(solution1(massageInput(inputExample)));