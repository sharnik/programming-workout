fibonacci_add a b x
    | (a + b) < 4000000 = fibonacci_add (a+b) a ((a+b):x)
    | otherwise = x

main = print (sum [x | x <- (fibonacci_add 2 1 [2, 1]), even (x) ])
