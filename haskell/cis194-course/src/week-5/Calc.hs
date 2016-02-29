module Calc where
    import ExprT
    import Parser

    class Evaluable e where
        evaluate :: e -> Integer

    class Expr d where
        lit :: Integer -> d
        add :: d -> d -> d
        mul :: d -> d -> d

    instance Evaluable ExprT where
        evaluate (Lit x) = x
        evaluate (Add x y) = (evaluate x) + (evaluate y)
        evaluate (Mul x y) = (evaluate x) * (evaluate y)

    instance Expr ExprT where
        lit x = Lit x
        add x y = (Add x y)
        mul x y = (Mul x y)

    instance Expr Integer where
        lit x = x
        add x y = x + y
        mul x y = x * y

    instance Expr Bool where
        lit x
            | x > 0 = True
            | otherwise = False
        add x y = x || y
        mul x y = x && y

    newtype MinMax = MinMax Integer deriving (Eq, Show)

    instance Expr MinMax where
        lit x = MinMax x
        add (MinMax x) (MinMax y) = MinMax (max x y)
        mul (MinMax x) (MinMax y) = MinMax (min x y)

    newtype Mod7 = Mod7 Integer deriving (Eq, Show)

    instance Expr Mod7 where
        lit x = Mod7 x
        add (Mod7 x) (Mod7 y)  = Mod7 ((x + y) `mod` 7)
        mul (Mod7 x) (Mod7 y) = Mod7 ((x * y) `mod` 7)

    eval :: ExprT -> Integer
    eval x = evaluate x

    evalStr :: String -> Maybe Integer
    evalStr s =
        let e = parseExp Lit Add Mul s
        in case e of
            Nothing -> Nothing
            Just x -> Just (eval x)

    testExp :: Expr a => Maybe a
    testExp = parseExp lit add mul "(3 * -4) + 5"

    testInteger = testExp :: Maybe Integer
    testBool = testExp :: Maybe Bool
    testMinMax = testExp :: Maybe MinMax
    testMod7 = testExp :: Maybe Mod7

