# I've never written one of these, so I'm going to
# work through the logic with this prototype.

import sys

ISA = {
    'DAT': 000, # mem addr
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

def read_src(src_path):
    try:
        with open(src_path, 'r') as f:
            return f.readlines()
    except FileNotFoundError:
        print(f"Could not find file {src_path}")
    except Exception as e:
        print(f"Unexpected error occurred reading {src_path}. {e}")
    sys.exit(1)

def assemble(src):
    pass
    

def main():
    if len(sys.argv) != 2:
        print(f"Usage: prototype.py [FILE].asm")
        exit()
    src = read_src(sys.argv[1])
    assemble(src)

if __name__ == '__main__': main()