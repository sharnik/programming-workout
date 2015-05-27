-- Haskell CIS194, week 4

-- Exercise 1, wholemeal programming

fun1 :: [Integer] -> Integer
fun1 =  foldr (*) 1 . map (\x -> x - 2) . filter (\x -> (mod x 2) == 0)

-- TODO: Solve :sad_panda:
-- fun2 :: Integer -> Integer

main = print (fun1 [3,4,5,6,7])