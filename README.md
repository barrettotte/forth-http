# Forth-LMC
Little Man Computer (LMC) emulator and assembler written to practice Forth


## Little Man Computer (LMC)
The Little Man Computer (LMC) is an educational von Neumann architecture usually
used as a student's introduction to computer architecture.


### Instruction Set

| Opcode | Mnemonic | Description |
| ---- | ---- | ---- |
| ```1xx``` | ```ADD``` | Add |
| ```2xx``` | ```SUB``` | Subtract |
| ```3xx``` | ```STA``` | Store |
| ```5xx``` | ```LDA``` | Load |
| ```6xx``` | ```BRA``` | Branch always (unconditional) |
| ```7xx``` | ```BRZ``` | Branch if zero (conditional) |
| ```8xx``` | ```BRP``` | Branch if positive (conditional) |
| ```901``` | ```INP``` | Input |
| ```902``` | ```OUT``` | Output |
| ```000``` | ```HLT/COB``` | Halt / Coffee Break |
| | ```DAT``` | Data |


## Assembler



## References

- [Little man computer wiki](https://en.wikipedia.org/wiki/Little_man_computer)
- [LMC Instruction Set](http://www.yorku.ca/sychen/research/LMC/LMCInstructions.html)

