import Data.Set as Set
import System.Environment

nextLocation :: Char -> (Int, Int) -> (Int, Int)
nextLocation direction (locationX, locationY) =
    case direction of
        '^' -> (locationX, locationY + 1)
        'v' -> (locationX, locationY - 1)
        '>' -> (locationX + 1, locationY)
        '<' -> (locationX - 1, locationY)

countHouses :: [Char] -> Set (Int, Int) -> (Int, Int) -> Int
countHouses [] houses _ = Set.size houses
countHouses (next : instructions) houses oldLocation =
    let newLocation = nextLocation next oldLocation in
    countHouses instructions (Set.insert newLocation houses) newLocation

countRoboHouses :: [Char] -> Set (Int, Int) -> (Int, Int) -> (Int, Int) -> [Char] -> Int
countRoboHouses [] houses _ _ _ = Set.size houses
countRoboHouses (next : instructions) houses santaLocation roboLocation turn =
    let newSantaLocation = nextLocation next santaLocation in
    let newRoboLocation = nextLocation next roboLocation in
    case turn of
        "Santa" -> countRoboHouses instructions (Set.insert newSantaLocation houses) newSantaLocation roboLocation "Robot"
        "Robot" -> countRoboHouses instructions (Set.insert newRoboLocation houses) santaLocation newRoboLocation "Santa"

main = do input <- getArgs
          print (countRoboHouses (head input) (Set.insert (0, 0) Set.empty) (0, 0) (0,0) "Santa")
