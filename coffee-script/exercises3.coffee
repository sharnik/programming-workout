# Exercise 1: Display aphorism.

root = global ? window
root.aphorism = 'Fool me 8 or more times, shame on me'
do restoreOldAphorism = ->
  root.aphorism = 'Fool me once, shame on you'
  console.log aphorism
console.log aphorism

# Exercise 2: Genies.
Genie = ->
Genie::wishesLeft = 3
Genie::grantWish = ->
  if Genie::wishesLeft > 0
    console.log 'Your wish is granted!'
    Genie::wishesLeft--