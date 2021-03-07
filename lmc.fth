\ Little Man Computer (LMC)
\ Reference: https://en.wikipedia.org/wiki/Little_man_computer
\
\ Calls assembler to assemble source file and passes "binary"
\ to emulator for execution.


256 constant line-width

0 value fd-in
0 value fd-out

create asmpath$ 128 allot             \ path to ASM file
create line-buff line-width 2 + allot  \ line of a file


\ copy string constant to string variable
: place$ over over >r >r char+ swap chars cmove r> r> c! ;

\ copy string variable to another string variable
: copy$ swap dup count 1+ swap drop rot swap cmove ;

\ print string
: print$ count type ;

\ get length of string
: length$ count swap drop ;

\ load arguments from stdin, exit if bad arguments
: load-stdin
    argc @ 2 < if
        sourcefilename pad place$
        ." usage:" space pad print$ space
        ." ASM_FILE_PATH" cr
        bye
    else
        1 arg swap asmpath$ copy$  \ load file path
    endif
;

\ open input file at given path as read-only
: open-infile ( straddr -- )
    dup length$
    r/o open-file throw to fd-in 
    drop 
;

\ close input file given its handle
: close-infile ( -- ) fd-in close-file throw ;

\ print input file contents to console
: print-infile ( -- )
    begin
        line-buff line-width fd-in read-line throw
    while
        line-buff swap 
        type cr
    repeat
;

load-stdin

asmpath$ open-infile

print-infile

close-infile

cr bye