tileCounts =
  A: 9, B: 2, C: 2, D: 4, E: 12, F: 2, G: 3, H: 2, I: 9, J: 1, K: 1, L: 4
  M: 2, N: 6, O: 8, P: 2, Q: 1, R: 6, S: 4, T: 6, U: 4, V: 2, W: 2, X: 1
  Y: 2, Z: 1

tileValues =
  A: 1, B: 3, C: 3, D: 2, E: 1, F: 4, G: 2, H: 4, I: 1, J: 8, K: 5, L: 1
  M: 3, N: 1, O: 1, P: 3, Q: 10, R: 1, S: 1, T: 1, U: 1, V: 4, W: 4, X: 8,
  Y: 4, Z: 10

totalTiles = 0
totalTiles += count for letter, count of tileCounts
alphabet = (letter for letter of tileCounts).sort()

randomLetter = ->
  randomNumber = Math.ceil Math.random() * totalTiles
  x = 1
  for letter in alphabet
    x += tileCounts[letter]
    return letter if x > randomNumber

class Grid
  constructor: ->
    @size = size = 5
    @tiles = for x in [0...size]
      for y in [0...size]
        randomLetter()

  inRange: (x, y) ->
    0 <= x < @size and 0 <= y < @size

  swap: ({x1, y1, x2, y2}) ->
    [@tiles[x1][y1], @tiles[x2][y2]] = [@tiles[x2][y2], @tiles[x1][y1]]

  rows: ->
    for x in [0...@size]
      for y in [0...@size]
        @tiles[y][x]

  printGrid: ->
    rows = for x in [0...@size]
      for y in [0...@size]
        @tiles[y][x]
    rowStrings = (' ' + row.join(' | ') for row in rows)
    rowSeparator = ('-' for i in [1..@size * 4]).join('')
    console.log '\n' + rowStrings.join("\n#{rowSeparator}\n") + '\n'

  scoreMove: (dictionary, swapCoordinates) ->
    {x1, x2, y1, y2} = swapCoordinates
    words = dictionary.wordsThroughTile(x1, y1).concat dictionary.wordsThroughTile(x2, y2)
    moveScore = multiplier = 0
    newWords = []
    for word in words when word not in dictionary.usedWords and word not in newWords
      multiplier++
      moveScore += tileValues[letter] for letter in word
      newWords.push word
    dictionary.usedWords = dictionary.usedWords.concat newWords
    moveScore *= multiplier
    {moveScore, newWords}


root = exports ? window
root.Grid = Grid
