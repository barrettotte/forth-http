; Example from https://en.wikipedia.org/wiki/Little_man_computer
;
         INP
         STA FIRST
         INP
         STA SECOND
         LDA FIRST
         SUB SECOND
         OUT
         HLT           ; end program
FIRST    DAT
SECOND   DAT