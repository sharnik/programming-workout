-- Haskell CIS194, week 4

-- Exercise 1, wholemeal programming

module Single where

fun1 :: [Integer] -> Integer
fun1 =  foldr (*) 1 . map (\x -> x - 2) . filter (\x -> (mod x 2) == 0)

-- TODO: Solve :sad_panda:
-- fun2 :: Integer -> Integer

-- Exercise 2, folds

xor :: [Bool] -> Bool
xor = foldr (
  \elem sum ->
    case () of _
                 | (elem || sum) && (not (elem && sum))-> True
                 | otherwise -> False
  )
  False

map' :: (a -> b) -> [a] -> [b]
map' f = foldr (\elem sum -> (f elem):sum) []

-- Exercise 4, Sieve of Sundaram

sieveSundaram :: Integer -> [Integer]
sieveSundaram =
  map (\x -> 2 * x + 1)
  . (\n ->
    let removables = [i + j + 2*i*j | i<-[1..n], j<-[i..n], i + j + 2*i*j <= n]
    in filter (\x -> (not (x `elem` removables))) [1..n]
  )

-- main = print (map' (\x -> x + 2) [1, 2, 3])
