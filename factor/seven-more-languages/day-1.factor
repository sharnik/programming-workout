USING: kernel sequences prettyprint math math.functions math.ranges math.parser ascii strings ;
IN: day-1

: easy-1 ( -- ) 3 3 * 4 4 * + pprint ;
: easy-2 ( -- ) 3 sq 4 sq + sqrt pprint ;
: easy-3 ( -- ) "wojtek" "Hello, " swap append >upper pprint ;

: medium-1 ( -- ) { 1 4 17 9 11 } 0 [ + ] reduce pprint ;
: medium-2 ( -- ) 100 [1,b] 0 [ + ] reduce pprint ;
: medium-3 ( -- ) 10 [1,b] [ sq ] map pprint ;

: hard-1 ( -- ) 42 [ 10 /i ] [ 10 mod ] bi swap pprint pprint ;
: hard-2 ( -- ) 123456 number>string [ 1string string>number pprint ] each ;


MAIN: hard-2