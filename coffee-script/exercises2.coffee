# Exercise 4: Check whether an arbitrary object contains a given value
objContains = (obj, val) ->
  for _, v of obj
    if v is val
      return true

  false

obj = [1, 2, 3]
console.log objContains(obj, 1)
console.log objContains(obj, 4)

# Exercise 5: Write a do-while function:
doAndRepeatUntil = (loop_func, condition) ->
  loop_func()
  loop_func() until condition()

user =
  harangue: ->
    console.log 'Blah blah bla'

  paidInFull: true
doAndRepeatUntil user.harangue, -> user.paidInFull

# Exercise 6: List comprehension to get shortest word from a dictionary.
shortestWordLength = (array) ->
  Math.min (word.length for word in array)...

console.log shortestWordLength(['blah', 'blah', 'car'])