-- CIS194 course, week 1
-- https://www.cis.upenn.edu/~cis194/lectures.html

-- Exercises 1-4
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

validate :: Integer -> Bool
validate number =
  let sum = sumDigits (doubleEveryOther (toDigits number)) in
  (mod sum 10) == 0


-- Exercise 5

type Peg = String
type Move = (Peg, Peg)

hanoi :: Integer -> Peg -> Peg -> Peg -> [Move]
hanoi 1 peg_a peg_b peg_c = [(peg_a, peg_b)]
hanoi x peg_a peg_b peg_c =
  (hanoi (x-1) peg_a peg_c peg_b) ++ [(peg_a, peg_b)] ++ (hanoi (x-1) peg_c peg_b peg_a)

main = print (hanoi 3 "a" "b" "c")

