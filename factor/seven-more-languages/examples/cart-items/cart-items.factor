USING: vectors sequences kernel accessors math io prettyprint ;
IN: examples.cart-items
TUPLE: cart-item name price quantity ;
TUPLE: checkout item-count base-price taxes shipping total-price ;

: <pricey-cart-item> ( price -- cart-item ) "default name" swap 1 cart-item boa ;
: cart-item-count ( cart -- count ) [ quantity>> ] map sum ;
: cart-item-price ( cart-item -- price ) [ price>> ] [ quantity>> ] bi * ;
: cart-base-price ( cart -- price ) [ cart-item-price ] map sum ;

: discount-item ( discount-rate cart-item -- cart-item )
    dup price>> rot 100.0 swap - * 100.0 / swap dup name>> swap quantity>> rot swap
    cart-item boa ;


: sum ( seq -- n ) 0 [ + ] reduce ;

: <base-checkout> ( item-count base-price -- checkout )
    f f f checkout boa ;

: <checkout> ( cart -- checkout )
    [ cart-item-count ] [ cart-base-price ] bi <base-checkout> ;


: test ( -- ) { 100.0 <pricey-cart-item> 50 <pricey-cart-item> } pprint flush ;

MAIN: test
