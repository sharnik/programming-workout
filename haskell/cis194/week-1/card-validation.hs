-- Exercise 1-4 for CIS194 course, week 1
-- https://www.cis.upenn.edu/~cis194/lectures.html

toDigits :: Integer -> [Integer]
toDigits int
  | int <= 0 = []
  | otherwise = toDigits (quot int 10) ++ [int `mod` 10]

toDigitsRev :: Integer -> [Integer]
toDigitsRev int = reverse (toDigits int)

main = print (toDigitsRev 1343)
