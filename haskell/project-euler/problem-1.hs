solution :: Integer -> Integer
solution upper_bound = sum [x | x <- [1..upper_bound], x `mod` 3 == 0 || x `mod` 5 == 0]

main = print (solution 999)