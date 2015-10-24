n = a `div` length xs
    where
        a = 10
        xs = [1, 2, 3, 4, 5]my_product [] = 1
my_product (x : xs) = x * my_product xs

blah = my_product [2, 3, 4]
qsort [] = []
qsort (x : xs) = qsort larger ++ [x] ++ qsort smaller
  where smaller = [a | a <- xs, a <= x]
        larger = [b | b <- xs, b > x]

result = qsort [3, 5, 8, 9, 3, 2, 5, 1, 6]
