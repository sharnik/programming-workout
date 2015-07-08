module Calc where
    import ExprT

    class Evaluable e where
        evaluate :: e -> Integer

    instance Evaluable ExprT where
        evaluate (Lit x) = x
        evaluate (Add x y) = (evaluate x) + (evaluate y)
        evaluate (Mul x y) = (evaluate x) * (evaluate y)

    eval :: ExprT -> Integer
    eval x = evaluate x
