module Lib
    ( someFunc
    ) where

import CardValidation

someFunc :: IO ()
someFunc = print (hanoi 3 "a" "b" "c")

