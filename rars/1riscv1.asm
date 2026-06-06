# Hazard-Free RISC-V Instruction Test (NOP-padded)

# Replace each `nop` with: addi x0, x0, 0

# Initialize base address

addi x1, x0, 0x100
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

# ========= ADD =========

addi x2, x0, 8
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

addi x3, x0, 3
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

add x10, x2, x3
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

sw x10, 0(x1)
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

# ========= SUB =========

addi x2, x0, 8
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

addi x3, x0, 3
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

sub x10, x2, x3
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

sw x10, 4(x1)
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

# ========= AND =========

addi x2, x0, 8
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

addi x3, x0, 3
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

and x10, x2, x3
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

sw x10, 8(x1)
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

# ========= OR =========

addi x2, x0, 8
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

addi x3, x0, 3
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

or x10, x2, x3
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

sw x10, 12(x1)
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

# ========= XOR =========

addi x2, x0, 8
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

addi x3, x0, 3
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

xor x10, x2, x3
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

sw x10, 16(x1)
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

# ========= SLL =========

addi x2, x0, 8
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

addi x3, x0, 2
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

sll x10, x2, x3
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

sw x10, 20(x1)
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

# ========= SRL =========

addi x2, x0, 8
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

addi x3, x0, 2
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

srl x10, x2, x3
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

sw x10, 24(x1)
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

# ========= SRA =========

addi x2, x0, -8
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

addi x3, x0, 2
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

sra x10, x2, x3
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

sw x10, 28(x1)
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

# ========= SLT =========

addi x2, x0, 3
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

addi x3, x0, 8
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

slt x10, x2, x3
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

sw x10, 32(x1)
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

# ========= SLTU =========

addi x2, x0, 3
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

addi x3, x0, 8
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

sltu x10, x2, x3
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

sw x10, 36(x1)
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

# ========= ADDI =========

addi x2, x0, 8
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

addi x10, x2, 5
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

sw x10, 40(x1)
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

# ========= SRAI =========

addi x2, x0, -8
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

srai x10, x2, 2
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

sw x10, 44(x1)
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

# ========= SLTI =========

addi x2, x0, 3
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

slti x10, x2, 8
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

sw x10, 48(x1)
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

# ========= SLTIU =========

addi x2, x0, 3
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

sltiu x10, x2, 8
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

sw x10, 52(x1)
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

# ========= STORE =========

addi x2, x0, 0x5a
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

sw x2, 56(x1)
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

# ========= LUI =========

lui x10, 0x12345
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

sw x10, 60(x1)
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

# ========= AUIPC =========

auipc x10, 0x0
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

sw x10, 64(x1)
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

# ========= BRANCH (SAFE) =========

addi x2, x0, 5
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

addi x3, x0, 5
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

beq x2, x3, branch_eq
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0   # kill fallthrough

branch_eq:
addi x10, x0, 1
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

sw x10, 68(x1)
addi x0, x0, 0 
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0

# ========= END =========

addi x0, x0, 0
