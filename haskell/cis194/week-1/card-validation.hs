-- Exercise 1-4 for CIS194 course, week 1
-- https://www.cis.upenn.edu/~cis194/lectures.html

toDigits :: Integer -> [Integer]
toDigits int
  | int <= 0 = []
  | otherwise = toDigits (quot int 10) ++ [int `mod` 10]

toDigitsRev :: Integer -> [Integer]
toDigitsRev int = reverse (toDigits int)

doubleEveryOther :: [Integer] -> [Integer]
doubleEveryOther [] = []
doubleEveryOther [x] = [x]
doubleEveryOther (list) =
  let not_changed = last list in
  let changed = list !! (length list - 2) in
  let shortened_list = take (length list - 2) list in
  doubleEveryOther shortened_list ++ [changed * 2] ++ [not_changed]

sumDigits :: [Integer] -> Integer
sumDigits [] = 0
sumDigits (x:xs)
  | x < 10 = x + (sumDigits xs)
  | otherwise = (mod x 10) + sumDigits ([(quot x 10)] ++ xs)

main = print (sumDigits [16, 7, 12, 5])
