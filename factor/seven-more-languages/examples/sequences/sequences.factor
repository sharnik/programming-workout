USING: kernel sequences prettyprint math quotations ;
IN: examples.sequences

: find-first ( seq callable -- elem )
    swap dup length 0 =
    [ drop drop null ]
    [ swap dup rot dup first rot call( x -- bool )
        [ swap drop first ]
        [ swap 0 rot remove-nth swap find-first ]
        if
    ]
    if ;
