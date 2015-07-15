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

    eval :: ExprT -> Integer
    eval x = evaluate x

    evalStr :: String -> Maybe Integer
    evalStr s =
        let e = parseExp Lit Add Mul s
        in case e of
            Nothing -> Nothing
            Just x -> Just (eval x)

