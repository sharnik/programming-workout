import Data.Char

let2int :: Char -> Int
let2int c
    | isLower c = ord c - ord 'a'
    | otherwise = ord c - ord 'A'

int2let :: Int -> Char
int2let n
    | n > 25 = chr (ord 'a' + n - 26)
    | otherwise = chr (ord 'A' + n)

shift :: Int -> Char -> Char
shift n c
    | isLower c = int2let ((let2int c + n) `mod` 26 + 26)
    | isUpper c = int2let ((let2int c + n) `mod` 26)
    | otherwise = c

encode :: Int -> String -> String
encode n xs = [shift n x | x <- xs]

result = encode 13 "Think like a Fundamentalist Code like a Hacker"

xs = 1 : [x + 1 | x <- xs]