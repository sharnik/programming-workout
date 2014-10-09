USING: tools.test io io.streams.null kernel namespaces sequences examples.strings
    examples.sequences prettyprint tools.test.private ;
IN: examples.test-suite

: test-all-examples ( -- )
    [ "examples" test ] with-null-writer
    test-failures get empty?
    [ "All tests passed." print ]
    [ "Tests failed: " print test-failures get length pprint flush :test-failures ]
    if ;

: test-cli ( -- )
    readln dup "all" =
    [ drop test-all-examples ]
    [ test-vocab ]
    if ;

MAIN: test-cli
