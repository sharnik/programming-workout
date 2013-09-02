GRID_SIZE = 5

inRange = (x, y) ->
  0 <= x < GRID_SIZE and 0 <= y < GRID_SIZE

isInteger = (num) ->
  num is Math.round(num)

strToCoordinates = (input) ->
  halves = input.split(',')
  if halves.length is 2
    x = parseFloat halves[0]
    y = parseFloat halves[1]
    if !isInteger(x) or !isInteger(y)
      console.log 'Each coordinate must be an integer.'
    else if not inRange(x - 1, y - 1)
      console.log "Each coordinate must be between 1 and #{GRID_SIZE}"
    else
      {x, y}
  else
    console.log 'Inpust must be of the form `x, y`.'

stdin = process.openStdin()
stdin.setEncoding 'utf8'

inputCallback = null
stdin.on 'data', (input) -> inputCallback input

promptForTile1 = ->
  console.log 'Please enter coordinates of the first tile:'
  inputCallback = (input) ->
    promptForTile2() if strToCoordinates input

promptForTile2 = ->
  console.log 'Please enter coordinates of the second tile:'
  inputCallback = (input) ->
    if strToCoordinates input
      console.log 'Swapping tiles… Done!'
      promptForTile1()

console.log 'Welcome to 5x5!'
promptForTile1()