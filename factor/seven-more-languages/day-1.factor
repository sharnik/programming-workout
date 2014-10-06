USING: kernel sequences prettyprint math math.functions math.ranges ascii ;
IN: day-1

: easy-1 ( -- ) 3 3 * 4 4 * + pprint ;
: easy-2 ( -- ) 3 sq 4 sq + sqrt pprint ;
: easy-3 ( -- ) "wojtek" "Hello, " swap append >upper pprint ;

: medium-1 ( -- ) { 1 4 17 9 11 } 0 [ + ] reduce pprint ;
: medium-2 ( -- ) 100 [1,b] 0 [ + ] reduce pprint ;
: medium-3 ( -- ) 10 [1,b] [ sq ] map pprint ;


MAIN: medium-3