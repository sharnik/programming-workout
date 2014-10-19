USING: kernel accessors math io prettyprint ;
IN: examples.cart-items
TUPLE: cart-item name price quantity ;

: <pricey-cart-item> ( price -- cart-item ) "default name" swap 1 cart-item boa ;
: discount-item ( discount-rate cart-item -- cart-item )
    dup price>> rot 100.0 swap - * 100.0 / swap dup name>> swap quantity>> rot swap
    cart-item boa ;

: test ( -- ) 25 100.0 <pricey-cart-item> discount-item pprint flush ;

MAIN: test
