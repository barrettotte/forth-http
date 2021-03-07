\ file I/O utils

0 value fd-in
0 value fd-out

\ open input file at given path as read-only
: open-infile ( addr -- )
    dup count swap drop \ str len
    r/o open-file throw to fd-in 
    drop 
;

\ close input file given its handle
: close-infile ( -- ) fd-in close-file throw ;
