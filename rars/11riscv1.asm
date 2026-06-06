# =============================================================
# RISC-V Pipeline Bug Test Suite
# Each section tests a specific suspected bug.
# Results stored to data memory starting at 0x2000.
# Conventions:
#   x1  = scratch / temp
#   x2  = memory pointer (data base address)
#   x28 = section result accumulator
# =============================================================

.text
.global _start
_start:

    # ---- Setup ----
    lui  x2, 0x0        # x2 = 0x2000 (data memory base)

# =============================================================
# TEST 1 — EXE→EXE forwarding (Bug #5)
# If fwd_rs1/rs2 use PC_ALU_DMEM instead of alu_out,
# back-to-back dependent instructions read a stale value.
#
# Expected: x5 = 3, x6 = 5
# Buggy:    x5 = 1 (ADD reads x3=0 before it's forwarded)
#           x6 = wrong (chain breaks)
# =============================================================

    addi x3, x0, 1      # x3 = 1
    add  x4, x3, x3     # x4 = x3+x3 = 2  (needs EXE→EXE fwd of x3)
    add  x5, x4, x3     # x5 = x4+x3 = 3  (needs EXE→EXE fwd of x4)
    add  x6, x5, x4     # x6 = x5+x4 = 5  (needs EXE→EXE fwd of x5,x4)

    sw   x5, 0(x2)      # mem[0x2000] = 3  (expect 0x00000003)
    sw   x6, 4(x2)      # mem[0x2004] = 5  (expect 0x00000005)

# =============================================================
# TEST 2 — Load-use stall + forwarding after stall (Bug #6)
# A load followed immediately by a use must stall one cycle.
# The result after the stall should still forward correctly.
#
# Expected: x9 = 0xAB, x10 = 0x156 (0xAB + 0xAB)
# Buggy (no stall): x9 = stale value (0 or garbage)
# =============================================================

    addi x1, x0, 0xAB
    sw   x1, 8(x2)       # pre-store 0xAB to mem[0x2008]
    lw   x8, 8(x2)       # load 0xAB → x8  (load-use hazard on next line)
    add  x9, x8, x0      # x9 = x8; if no stall x8 is garbage
    add  x10, x8, x8     # x10 = 0x156; tests forwarding after stall

    sw   x9,  12(x2)     # mem[0x200C] = 0x000000AB
    sw   x10, 16(x2)     # mem[0x2010] = 0x00000156

# =============================================================
# TEST 3 — Branch flush (Bug #4: EXE stage not flushed)
# If the instruction in EXE is not squashed on a taken branch,
# it will complete a side effect (store or reg write).
#
# We put a SW in the shadow of a branch. If bug #4 exists,
# the SW executes and poisons mem[0x2050].
#
# Expected: mem[0x2050] = 0xDEAD (written before branch, unchanged after)
# Buggy:    mem[0x2050] = 0xBAD  (shadow SW executes)
# =============================================================

    addi x1, x0, 0          # x1 = 0
    addi x11, x0, 0         # use x11 as poison detector

    # Write a sentinel
    lui  x3, 0xDEAD0
    srli x3, x3, 4          # x3 = 0x0000DEAD  (avoid sign issues)
    addi x3, x3, 0xD        # Actually let's just load 0xDEAD directly:

    # Cleaner: build 0xDEAD
    addi x3, x0, 0
    addi x3, x3, 0x7FF      # 2047
    slli x3, x3, 4           # 0x7FF0
    addi x3, x3, 0xF         # 0x7FFF — not quite, let's do it simply:

    # Simplest: just use a recognizable value
    addi x3, x0, 0x111
    sw   x3, 0x50(x2)       # mem[0x2050] = sentinel = 0x111

    beq  x1, x1, skip_shadow  # always taken branch

    # SHADOW INSTRUCTIONS — must be flushed
    addi x11, x0, 0x222     # should be squashed
    sw   x11, 0x50(x2)      # MUST NOT execute — would overwrite sentinel

skip_shadow:
    sw   x11, 0x54(x2)      # mem[0x2054] = 0 if flush correct, else 0x222

# =============================================================
# TEST 4 — BNE branch correctness + branch target PC (Bug #3)
# Verifies that the branch resolves to the right target PC.
# Uses a counter loop: increment x12 three times.
#
# Expected: x12 = 3
# Buggy (wrong target PC): loop runs wrong number of times,
# or jumps to wrong address (likely crash / infinite loop)
# =============================================================

    addi x12, x0, 0         # counter = 0
    addi x13, x0, 3         # limit = 3

loop_top:
    addi x12, x12, 1        # counter++
    bne  x12, x13, loop_top # branch back if counter != 3

    sw   x12, 0x20(x2)      # mem[0x2020] = 3  (expect 0x00000003)

# =============================================================
# TEST 5 — JAL return address (Bug #1/#3)
# JAL must save PC+4 into rd. If the bias 0x3000 is added,
# the saved address will be PC+4+0x3000, which is wrong.
#
# We capture the return address and compare it to the
# instruction address after the JAL (computed via AUIPC).
#
# Expected: x15 == x16  (return addr == addr of instruction after JAL)
# Store difference: mem[0x2024] = 0 if correct
# =============================================================

    jal  x14, jal_target     # x14 = PC+4 (return addr), jump forward

after_jal:
    # x14 holds the return address; x15 = AUIPC of this location
    auipc x15, 0             # x15 = PC of this instruction (after_jal)
    sub   x16, x14, x15      # difference: should be 0 if JAL saves correctly
    sw    x16, 0x24(x2)      # mem[0x2024] = 0 if correct, else 0x3000 or similar
    j     post_jal_test
    
jal_target:
    jalr x0, x14, 0          # return

post_jal_test:

# =============================================================
# TEST 6 — AUIPC value correctness (Bug #1)
# AUIPC should produce PC + upper_imm.
# If 0x3000 is added spuriously, result is too large.
#
# Strategy: two back-to-back AUIPCs with imm=0.
# Their difference should equal 4 (one instruction apart).
#
# Expected: x19 = 4
# Buggy:    x19 = 4 (AUIPC bias cancels in subtraction — bug
#           may not show here, so also check absolute value)
# =============================================================

    auipc x17, 0             # x17 = PC_here
    auipc x18, 0             # x18 = PC_here + 4
    sub   x19, x18, x17      # x19 = 4 always (bias cancels if consistent)
    sw    x19, 0x28(x2)      # mem[0x2028] = 4  (expect 0x00000004)

    # Absolute check: AUIPC + known offset should match a JAL's return addr
    # (reuses x14 from Test 5 — x14 = address of after_jal label)
    # We can't easily get the label PC at runtime without more JALs,
    # so the subtraction test above is the best portable check.

# =============================================================
# TEST 7 — JALR target address (Bug #2)
# JALR target = (rs1 + imm) & ~1.
# If 0x3000 is subtracted from rs1, the jump lands wrong.
#
# Strategy: jump to a known offset from current PC using JALR.
# Capture where we actually land by reading the return address.
#
# Expected: x21 = x22 (landed at correct target)
# =============================================================

    auipc x20, 0             # x20 = PC of this instruction
    addi  x20, x20, 16       # x20 = address of jalr_target below
                             # (auipc=0, addi=4, jalr=8, nop_pad=12, target=16)
    jalr  x21, x20, 0        # jump to x20+0; x21 = PC+4 (return addr)
    addi  x0, x0, 0          # nop / padding so target offset = 16
jalr_target:
    auipc x22, 0             # x22 = actual landing PC
    sub   x23, x22, x20      # should be 0 if we landed exactly at x20
    sw    x23, 0x2C(x2)      # mem[0x202C] = 0 if correct

# =============================================================
# TEST 8 — MEM→EXE forwarding (complement to Test 1)
# One instruction gap between producer and consumer — should
# use MEM→EXE forward path, not the EXE→EXE path.
#
# Expected: x25 = 10, x26 = 20
# =============================================================

    addi x24, x0, 10
    addi x1,  x0, 0         # gap instruction (no dependency)
    add  x25, x24, x0       # x25 = x24 = 10  (MEM→EXE forward)
    addi x1,  x0, 0
    add  x26, x25, x25      # x26 = 20
    sw   x25, 0x30(x2)      # mem[0x2030] = 10
    sw   x26, 0x34(x2)      # mem[0x2034] = 20

# =============================================================
# TEST 9 — BLT / BGE signed branch (checks forwarding into branch)
# Also stresses EXE-stage forwarding into the branch comparator.
#
# Expected: x27 = 0x77 (both branches taken correctly)
# =============================================================

    addi x27, x0, 0
    addi x1,  x0, -1        # x1 = -1 (0xFFFFFFFF)
    addi x28, x0, 1         # x28 = 1

    blt  x1, x28, blt_ok    # -1 < 1: should be taken
    addi x27, x27, 0x100    # poison — must not execute
blt_ok:
    addi x27, x27, 0x77

    bge  x28, x1, bge_ok    # 1 >= -1: should be taken
    addi x27, x27, 0x200    # poison — must not execute
bge_ok:
    sw   x27, 0x38(x2)      # mem[0x2038] = 0x77 if both branches correct

# =============================================================
# END — write a completion canary
# =============================================================

    addi x1, x0, 0xFF
    sw   x1, 0x3C(x2)       # mem[0x203C] = 0xFFF  (reached end of test)

    # Halt (infinite loop or environment call)