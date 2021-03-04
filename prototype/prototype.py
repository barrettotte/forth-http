# I've never written one of these, so I'm going to
# work through the logic with this prototype.

import sys

ISA = {
    'DAT': 000, # mem addr
    'COB': 000,
    'HLT': 000,
    'ADD': 100,
    'SUB': 200,
    'STA': 300,
    'LDA': 500,
    'BRA': 600,
    'BRZ': 700,
    'BRP': 800,
    'INP': 901,
    'OUT': 902
}

# read file into lines
def read_src(src_path):
    try:
        with open(src_path, 'r') as f:
            return [f.replace('\n', '') for f in f.readlines()]
    except FileNotFoundError:
        print(f"Could not find file {src_path}")
    except Exception as e:
        print(f"Unexpected error occurred reading {src_path}. {e}")
    sys.exit(1)

# lex LMC assembly, building dictionary of tokens and removing comments/spaces
def lex(src):
    all_tokens = {}
    for line_no, line in enumerate(src):
        i, tokens = 0, [t for t in line.split(' ') if t != '']

        while i < len(tokens) and tokens[i] != ';':
            if line_no not in all_tokens:
                all_tokens[line_no] = []

            all_tokens[line_no].append(tokens[i].upper())
            i += 1
    return all_tokens

# build symbol table
def find_symbols(lines):
    symbols, addr = {}, 0
    for _, line in lines.items():
        for i, tok in enumerate(line):
            if i == 0 and tok not in ISA.keys():
                symbols[line[0]] = addr
        addr += 1
    return symbols

# assemble LMC assembly to LMC machine code
def assemble(lines, symbols):
    mc = ''
    for _, line in lines.items():
        ins = 0
        for i, token in enumerate(line):
            if token in ISA.keys():
                ins += ISA[token]
            elif token in symbols.keys() and i != 0:
                ins += symbols[token]
            elif token.isdigit():
                ins += int(token)
        mc += str(ins).zfill(3)
    return mc

# interpret an assembled LMC program
def interpret(pgm):
    pc, acc, ins = 0, 0, 0
    mem = list(map(''.join, zip(*[iter(pgm)] * 3)))
    # print(mem)

    while ins != '000':
        ins = mem[pc]
        opcode, addr = int(ins[0]), int(ins[1:3])
        # print(pc, ':', opcode, str(addr).zfill(2))

        # ADD
        if opcode == 1:
            acc += int(mem[addr])
            if acc > 999:
                acc = 999
        # SUB
        elif opcode == 2:
            acc -= int(mem[addr])
            if acc < 0:
                acc = 0
        # STA
        elif opcode == 3:
            mem[addr] = acc
        # LDA
        elif opcode == 5:
            acc = int(mem[addr])
        # BRA
        elif opcode == 6:
            pc = addr
            continue
        # BRZ
        elif opcode == 7:
            if acc == 0:
                pc = addr
                continue
        # BRP
        elif opcode == 8:
            if acc > 0:
                pc = addr
                continue
        # INP
        elif ins == '901':
            acc = int(input('> '))
        # OUT
        elif ins == '902':
            print(acc)
        # HLT/COB
        elif ins == '000':
            break
        else:
            raise RuntimeError(f"Unknown instruction {ins}")
        pc += 1

def main():
    if len(sys.argv) != 2:
        print(f"Usage: prototype.py [FILE].asm")
        exit()
    src = read_src(sys.argv[1])
    lines = lex(src)
    symbols = find_symbols(lines)
    print(symbols)

    pgm = assemble(lines, symbols)
    interpret(pgm)

if __name__ == '__main__': main()