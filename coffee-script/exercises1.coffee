# Exercise 1.1:
clearArray = (arr) ->
  arr.splice 0, arr.length

console.log "clearArray([1, 2, 3]): #{clearArray([1, 2, 3])}"


clearArrayReturningOriginalArray = (arr) ->
  arr.splice 0, arr.length
  return arr

console.log "clearArrayReturningOriginalArray([1, 2, 3]): #{clearArrayReturningOriginalArray([1, 2, 3])}"


clearArrayReturningNothing = (arr) ->
  arr.splice 0, arr.length
  return

console.log "clearArrayReturningNothing([1, 2, 3]): #{clearArrayReturningNothing([1, 2, 3])}"


# Exercise 1.2:
run = (func, args...) ->
  func.apply this, args

console.log run(Math.round, 3.42)

# Exercise 1.3:
console.log 'Foo!' if true

# Exercise 1.6
xInContext = ->
  console.log @x
what = {x: 'quantum entanglement'}

xInContext.call what