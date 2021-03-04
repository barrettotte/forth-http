; Example from https://en.wikipedia.org/wiki/Little_man_computer
;
         INP
         OUT           ; Initialize output 
LOOP     BRZ QUIT      ; Label this memory address as LOOP. If the accumulator value is 0, jump to the memory address labeled QUIT
         SUB ONE       ; Subtract the value stored at address ONE from the accumulator
         OUT           ;
         BRA LOOP      ; Jump (unconditionally) to the memory address labeled LOOP
QUIT     HLT           ; Label this memory address as QUIT
ONE      DAT 1         ; Store the value 1 in this memory address, and label it ONE (variable declaration)