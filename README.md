# Forth-LMC
Little Man Computer (LMC) emulator and assembler written to practice Forth


## Little Man Computer (LMC)
The Little Man Computer (LMC) is an educational von Neumann architecture usually
used as a student's introduction to computer architecture.


### Instruction Set

| Opcode | Mnemonic | Description |
| ---- | ---- | ---- |
| ```000``` | ```HLT``` | Halt |
| ```1xx``` | ```ADD``` | Add |
| ```2xx``` | ```SUB``` | Subtract |
| ```3xx``` | ```STA``` | Store |
| ```5xx``` | ```LDA``` | Load |
| ```6xx``` | ```BRA``` | Branch always (unconditional) |
| ```7xx``` | ```BRZ``` | Branch if zero (conditional) |
| ```8xx``` | ```BRP``` | Branch if positive (conditional) |
| ```901``` | ```INP``` | Input |
| ```902``` | ```OUT``` | Output |
| | ```DAT``` | Data |


## Assembler


## Prototype
I've never written anything involving the LMC and I'm not very good at forth. So, I figured I would prototype things in python first.

Invoke prototype with ```python3 prototype/lmc.py asm/test.ams```


## References

- [Little man computer wiki](https://en.wikipedia.org/wiki/Little_man_computer)
- [LMC Instruction Set](http://www.yorku.ca/sychen/research/LMC/LMCInstructions.html)
- [Gforth Manual](https://www.complang.tuwien.ac.at/forth/gforth/Docs-html/)
- [And so Forth...](https://thebeez.home.xs4all.nl/ForthPrimer/Forth_primer.html)