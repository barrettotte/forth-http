\ Little Man Computer (LMC)
\ Reference: https://en.wikipedia.org/wiki/Little_man_computer
\
\ Calls assembler to assemble source file and passes "binary"
\ to emulator for execution.

include str.fth
include files.fth

256 constant line-width

variable line-buff line-width 2 + allot  \ line of a file

variable asmpath$ 128 allot  \ path to ASM file
variable memory 100 allot    \ "mailboxes"


\ opcodes
000 constant op-DAT  \ data
000 constant op-COB  \ coffee break
000 constant op-HLT  \ halt
100 constant op-ADD  \ add
200 constant op-SUB  \ subtract
300 constant op-STA  \ store
500 constant op-LDA  \ load
600 constant op-BRA  \ branch always
700 constant op-BRZ  \ branch if zero
800 constant op-BRP  \ branch if positive
901 constant op-INP  \ input 
902 constant op-OUT  \ output


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

: get-char
    over over swap
    chars + c@
;

\ strip comment from string
: comment-
    over + over swap over ( buf dst limit src )
    do
        i c@ 59 = if
            leave
        else
            \ i c@ emit space
            i c@ over c! char+
        then
    loop
    over -
;

\ lex source file
: lex ( -- )
    begin
        line-buff line-width fd-in read-line throw
    while
        line-buff upper$         \ convert to uppercase
        line-buff swap comment-  \ strip comments
                
        line-buff swap type cr   \ output (debug)
    repeat
;

\ entry point
: lmc
    load-stdin
    asmpath$ open-infile

    lex

    close-infile
;

lmc cr bye