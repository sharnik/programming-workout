-- CIS194 Haskell exercises, week 3.
--
module Golf where

-- Exercise 1

skip_x :: Int -> [a] -> [a]
skip_x _ [] = []
skip_x step list
  | step < (length list) =
    let (el:new_list) = drop step list in
    el:(skip_x step new_list)
  | otherwise = []

skips :: [a] -> [[a]]
skips list =
  let function_list = map skip_x [0, 1..(length list) - 1] in
  map (\x -> x list) function_list

-- Exercise 2

localMaxima :: [Integer] -> [Integer]
localMaxima (left:middle:right:els)
  | middle > left && middle > right = [middle] ++ (localMaxima (middle:right:els))
  | otherwise = (localMaxima (middle:right:els))
localMaxima _ = []

-- Exercise 3

incrementResult :: [Int] -> Int -> [Int]
incrementResult xs index =
  let current_value = xs !! index in
  (take index xs) ++ [current_value + 1] ++ (drop (index + 1) xs)

countOccurences :: [Int] -> [Int]
countOccurences list =
  _countOccurences list (replicate 10 0)

_countOccurences :: [Int] -> [Int] -> [Int]
_countOccurences [] result = result
_countOccurences (x:xs) result =
  _countOccurences xs (incrementResult result x)

prepareLine :: Int -> [String] -> String
prepareLine index list = (map (\str -> str !! index) list)

histogram :: [Int] -> String
histogram list =
  let occurs = countOccurences list in
  let max = maximum occurs in
  let star_string = map (\x -> (replicate (max - x) ' ') ++ (replicate x '*')) occurs in
  let lines = map (\x -> (prepareLine x star_string)) [0, 1..max-1] in
  let underscore = "==========\n0123456789\n" in
  (unlines lines) ++ underscore

