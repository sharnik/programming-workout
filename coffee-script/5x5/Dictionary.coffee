class Dictionary
  constructor: (@originalWordList, grid) ->
    @setGrid grid if grid?

  setGrid: (@grid) ->
    @wordList = @originalWordList.slice(0)
    @wordList = (word for word in @wordList when word.length <= @grid.size)
    @minWordLength = Math.min.apply Math, (w.length for w in @wordList)
    @usedWords = []
    for x in [0...@gridSize]
      for y in [0...@gridSize]
        @markUsed word for word in @wordsThroughTile x, y

  markUsed: (str) ->
    if str in @usedWords
      false
    else
      @usedWords.push str
      true

  isWord: (str) -> str in @wordList
  isNewWord: (str) -> str in @wordList and str not in @usedWords

  wordsThroughTile: (x, y) ->
    strings = []
    grid = @grid
    for length in [@minWordLength..@grid.size]
      range = length - 1
      addTiles = (func) ->
        strings.push (func(i) for i in [0..range]).join ''
      for offset in [0...length]
        # Vertical
        if @grid.inRange(x - offset, y) and @grid.inRange(x - offset + range, y)
          addTiles (i) -> grid.tiles[x-offset + i][y]
        # Horizontal
        if @grid.inRange(x, y - offset) and @grid.inRange(x, y - offset + range)
          addTiles (i) -> grid.tiles[x][y - offset + 1]
        # Diagonal (upper-left to lower-right)
        if @grid.inRange(x - offset, y - offset) and @grid.inRange(x - offset + range, y - offset + range)
          addTiles (i) -> grid.tiles[x - offset + i][y - offset + i]
        # Diagonal (lower-left to upper-right)
        if @grid.inRange(x - offset, y + offset) and @grid.inRange(x - offset + range, y + offset - range)
          addTiles (i) -> grid.tiles[x - offset + i][y + offset - i]

    str for str in strings when @isWord str

root = exports ? window
root.Dictionary = Dictionary
