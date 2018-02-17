/* Exercise decription: https://adventofcode.com/2017/day/3 */
/* This computes which "layer" around the starting point a particlar position is at: */
type inputDetails = {
  layer: int,
  relativePosition: int
};

let computeLayer = (position) => {
  let currentLayer = ref(0);
  let positionsLeft = ref(position - 1);
  while (positionsLeft^ > currentLayer^ * 8) {
    positionsLeft := positionsLeft^ - currentLayer^ * 8;
    currentLayer := currentLayer^ + 1
  };
  {layer: currentLayer^, relativePosition: positionsLeft^}
};

/* This computes the distance the data has to travel on the ring of the current layer */
let computeDistanceOnRing = (relativePosition, layer) => {
  let totalElementsInLayer = layer * 8;
  let totalElementsOnOneSide = totalElementsInLayer / 4;
  let relativePositionOnSide = relativePosition mod totalElementsOnOneSide;
  let positionOfCenterElementOnSide = totalElementsOnOneSide / 2;
  abs(relativePositionOnSide - positionOfCenterElementOnSide)
};

let manhattanDistance = (position) => {
  let parsedInput = computeLayer(position);
  parsedInput.layer + computeDistanceOnRing(parsedInput.relativePosition, parsedInput.layer)
};

let solution1 = (input) => manhattanDistance(input);

Js.log(solution1(347991));