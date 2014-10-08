USING: kernel sequences prettyprint math strings ;
IN: examples.strings

: shorten ( seq -- seq ) 0 swap remove-nth dup length 1 - swap remove-nth ;
: check-limits ( seq -- bool ) dup length 0 = [ drop t ] [ dup first 1string swap last 1string = ] if ;
: palindrome? ( seq -- y ) dup length 2 < [ drop t ] [ shorten dup check-limits [ palindrome? ] [ drop f ] if ] if ;

: test ( -- ) "racecar" palindrome? pprint ;

MAIN: test
