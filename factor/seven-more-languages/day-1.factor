USING: kernel sequences prettyprint math math.functions ascii ;
IN: day-1

: easy-1 ( -- ) 3 3 * 4 4 * + pprint ;
: easy-2 ( -- ) 3 sq 4 sq + sqrt pprint ;
: easy-3 ( -- ) "wojtek" "Hello, " swap append >upper pprint ;

MAIN: easy-3