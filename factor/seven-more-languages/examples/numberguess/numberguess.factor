USING: math.parser random io kernel math prettyprint namespaces strings sequences ;
IN: examples.numberguess
SYMBOL: number

: greet ( -- ) "We're going to play a game. Guess the number:" print flush ;

: guess-number ( -- ) 100 random number set ;

: take-turn ( -- )
    readln string>number dup
    number get =
    [
        drop "You win!" print flush
    ]
    [
        number get <
        [ "My number is higher. Try again:" print flush ]
        [ "My number is lower. Try again:" print flush ]
        if
        take-turn
    ]
    if ;

: play ( -- ) greet guess-number take-turn ;

MAIN: play
