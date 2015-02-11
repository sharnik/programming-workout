module LanguageHead where

import Keyboard
import Mouse
import Random
import Text

data State = Play | Pause | GameOver

type Input = { space:Bool, x:Int, delta:Time, rand:Int }
type Head = { x:Float, y:Float, vx:Float, vy:Float }
type Player = { x:Float, score:Int }
type Game = { state:State, heads:[Head], player:Player }

defaultHead n = {x = 100.0, y = 75, vx = 60, vy = 0.0, img = headImage n }
defaultGame = { state   = Pause,
                heads   = [],
                player  = {x = 0.0, score = 0} }

headImage n =
  if | n == 0 -> "/img/brucetate.png"
     | n == 1 -> "/img/davethomas.png"
     | n == 2 -> "/img/evanczaplicki.png"
     | n == 3 -> "/img/joearmstrong.png"
     | n == 4 -> "/img/josevalim.png"
     | otherwise -> ""
bottom = 550

secsPerFrame = 1.0 / 50.0
delta = inSeconds <~ fps 50

input = sampleOn delta (Input <~ Keyboard.space
                               ~ Mouse.x
                               ~ delta
                               ~ Random.range 0 4 (every secsPerFrame))

main = lift display gameState

gameState = foldp stepGame defaultGame input

stepGame input game =
  case game.state of
    Play -> stepGamePlay input game
    Pause -> stepGamePaused input game
    GameOver -> stepGameFinished input game

stepGamePlay {space, x, delta, rand} ({state, heads, player} as game) =
  { game | state <-  stepGameOver x heads
         , heads <- stepHeads heads delta x player.score rand
         , player <- stepPlayer player x heads }

stepGameOver x heads =
  if allHeadsSafe (toFloat x) heads then Play else GameOver

allHeadsSafe x heads =
    all (headSafe x) heads

headSafe x head =
    head.y < bottom || abs (head.x - x) < 50

stepHeads heads delta x score rand =
  spawnHead score heads rand
  |> bounceHeads
  |> removeComplete
  |> moveHeads delta

spawnHead score heads rand =
  let addHead = length heads < (score // 5000 + 1)
    && all (\head -> head.x > 107.0) heads in
  let randomHead = defaultHead rand in
  if addHead then { randomHead - vx | vx = (20 + rand * 30) } :: heads else heads

bounceHeads heads = map bounce heads

bounce head =
  { head | vy <- if head.y > bottom && head.vy > 0
                 then -head.vy * 0.95
                 else head.vy }

removeComplete heads = filter (\x -> not (complete x)) heads

complete {x} = x > 750

moveHeads delta heads = map moveHead heads

moveHead ({x, y, vx, vy} as head) =
  { head | x <- x + vx * secsPerFrame
         , y <- y + vy * secsPerFrame
         , vy <- vy + secsPerFrame * 400 }


stepPlayer player mouseX heads =
  { player | score <- stepScore player heads
           , x <- toFloat mouseX }

stepScore player heads =
  player.score +
  1 +
  1000 * (length (filter complete heads))

stepGamePaused {space, x, delta} ({state, heads, player} as game) =
  { game | state <- stepState space state
         , player <- { player |  x <- toFloat x } }

stepGameFinished {space, x, delta} ({state, heads, player} as game) =
  if space then defaultGame
  else { game | state <- GameOver
              , player <- { player |  x <- toFloat x } }

stepState space state = if space then Play else state

display ({state, heads, player} as game) =
  let (w, h) = (800, 600)
  in collage w h
       ([ drawRoad w h
       , drawBuilding w h
       , drawPaddle w h player.x
       , drawScore w h player
       , drawMessage w h state] ++
       (drawHeads w h heads))

drawRoad w h =
  filled gray (rect (toFloat w) 100)
  |> moveY (-(half h) + 50)

drawBuilding w h =
  filled red (rect 100 (toFloat h))
  |> moveX (-(half w) + 50)

drawHeads w h heads = map (drawHead w h) heads

drawHead w h head =
  let x = half w - head.x
      y = half h - head.y
      src = head.img
  in toForm (image 75 75 src)
     |> move (-x, y)
     |> rotate (degrees (x * 2 - 100))

drawPaddle w h x =   -- (18)
  filled black (rect 80 10)
  |> moveX (x +  10 -  half w)
  |> moveY (-(half h - 30))

half x = toFloat x / 2

drawScore w h player =
  toForm (fullScore player)
  |> move (half w - 150, half h - 40)

fullScore player = txt (Text.height 50) (show player.score)

txt f = leftAligned << f << monospace << Text.color blue << toText

drawMessage w h state =
  toForm (txt (Text.height 50) (stateMessage state))
  |> move (50, 50)

stateMessage state =
  if | state == GameOver -> "Game Over"
     | state == Play -> "LanguageHead"
     | state == Pause -> "Press SPACE to play"
