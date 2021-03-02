// test program for assembler
        INP
        STA FIRST
        INP
        STA SECOND
        LDA FIRST
        SUB SECOND
        OUT
        HLT
FIRST   DAT
SECOND  DAT