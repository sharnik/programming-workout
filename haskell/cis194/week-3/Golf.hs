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

