-- Easy 1:

import Mouse
import Signal (Signal, map2)
import Text (asText, append)

connect position state = asText ((toString position) ++ (toString state))
main = map2 connect Mouse.position Mouse.isDown


-- Easy 2:

import Mouse
import Signal (Signal, map2)
import Text (plainText)

output condition position = if condition then (plainText (toString position)) else (plainText "Press mouse button")
main = map2 output Mouse.isDown Mouse.y

-- Medium 1:

import Mouse
import Color (black, red, white)
import Graphics.Collage (filled, rect, move, moveY, collage, circle)
import Signal (Signal, map2)

carBottom = filled black (rect 160 50)
carTop =    filled black (rect 100 60)
tire = filled red (circle 24)
moustache condition = filled (if condition then black else white) (rect 100 25)

draw (position_x, position_y) button_pressed = collage (position_x * 2) (position_y * 2)
       [ carBottom
         , carTop |> moveY 30
         , tire |> move (-40, -28)
         , tire |> move ( 40, -28)
         , moustache button_pressed |> move (0, -100)
         ]

main = map2 draw Mouse.position Mouse.isDown

-- Medium 2:

import Mouse
import Text (asText)
import Signal (Signal, map)
import Time (second, every)

main = map asText (every second)
