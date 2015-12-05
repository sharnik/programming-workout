import Data.List.Split
import Data.List
import System.Environment

paper_per_present :: Int -> Int -> Int -> Int
paper_per_present length width height =
    let dim_1 = length * width in
    let dim_2 = width * height in
    let dim_3 =  height * length in
    let slack = min (min dim_1 dim_2) dim_3 in
    2 * (dim_1 + dim_2 + dim_3) + slack

compute_paper :: [String] -> Int
compute_paper [] = 0
compute_paper (present : tail) =
    let length : width : height : _ = splitOn "x" present in
    paper_per_present (read length :: Int) (read width :: Int) (read height :: Int) + compute_paper tail

ribbon_per_present :: Int -> Int -> Int -> Int
ribbon_per_present length width height =
    let faces = take 2 (sort [length, width, height]) in
    let wrap = 2 * ((faces !! 0) + (faces !! 1)) in
    let bow = length * width * height in
    wrap + bow

compute_ribbon :: [String] -> Int
compute_ribbon [] = 0
compute_ribbon (present : tail) =
    let length : width : height : _ = splitOn "x" present in
    ribbon_per_present (read length :: Int) (read width :: Int) (read height :: Int) + compute_ribbon tail

main = do input <- getArgs
          print (compute_ribbon input)
