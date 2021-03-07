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

\ lex source file
: lex ( -- )
    begin
        line-buff line-width fd-in read-line throw
    while
        line-buff line-width upper$
        
        line-buff swap type cr
    repeat
;

load-stdin
asmpath$ open-infile

lex

close-infile
cr bye

\ to do list
\   - continue loop when ';' encountered
\   - gather up to 3 tokens per line