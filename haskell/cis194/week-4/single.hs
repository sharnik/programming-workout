-- Haskell CIS194, week 4

-- Exercise 1, wholemeal programming

fun1 :: [Integer] -> Integer
fun1 =  foldr (*) 1 . map (\x -> x - 2) . filter (\x -> (mod x 2) == 0)

-- TODO: Solve :sad_panda:
-- fun2 :: Integer -> Integer

-- Exercise 3, Sieve of Sundaram

sieveSundaram :: Integer -> [Integer]
sieveSundaram =
  map (\x -> 2 * x + 1)
  . (\n ->
    let removables = [i + j + 2*i*j | i<-[1..n], j<-[i..n], i + j + 2*i*j <= n]
    in filter (\x -> (not (x `elem` removables))) [1..n]
  )

main = print (sieveSundaram 15)