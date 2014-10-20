USING: vectors sequences kernel accessors math io prettyprint ;
IN: examples.cart-items
CONSTANT: vat 0.23
TUPLE: cart-item name price quantity ;
TUPLE: checkout item-count base-price taxes ;

: <pricey-cart-item> ( price -- cart-item ) "default name" swap 1 cart-item boa ;
: cart-item-count ( cart -- count ) [ quantity>> ] map sum ;
: cart-item-price ( cart-item -- price ) [ price>> ] [ quantity>> ] bi * ;
: cart-base-price ( cart -- price ) [ cart-item-price ] map sum ;

: discount-item ( discount-rate cart-item -- cart-item )
    dup price>> rot 100.0 swap - * 100.0 / swap dup name>> swap quantity>> rot swap
    cart-item boa ;


: sum ( seq -- n ) 0 [ + ] reduce ;

: <base-checkout> ( item-count base-price -- checkout )
    f checkout boa ;

: <checkout> ( cart -- checkout )
    [ cart-item-count ] [ cart-base-price ] bi <base-checkout> ;

: with-vat ( price -- taxes ) vat * ;
: no-vat ( price -- taxes ) drop 0.0 ;

: add-taxes ( checkout taxes-strategy -- taxed-checkout )
    [ dup base-price>> ] dip call >>taxes ; inline

: total ( checkout -- price )
    [ with-vat ] add-taxes [ taxes>> ] [ base-price>> ] bi + ;

: test ( -- ) { } 100.0 <pricey-cart-item> prefix 50 <pricey-cart-item> prefix
    <checkout> total pprint flush ;

MAIN: test
