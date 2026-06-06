.text
.globl main
main:
  li x10, 0x0 # <--- Result log starts at address 0


# === ADD ===
#-------------------------------------------------------------
# Arithmetic tests
#-------------------------------------------------------------
  li x1, 0x00000000
  li x2, 0x00000000
  add x3, x1, x2
  li x4, 0x00000000
  bne x3, x4, fail_add_19

  li x1, 0x00000001
  li x2, 0x00000001
  add x3, x1, x2
  li x4, 0x00000002
  bne x3, x4, fail_add_20

  li x1, 0x00000003
  li x2, 0x00000007
  add x3, x1, x2
  li x4, 0x0000000a
  bne x3, x4, fail_add_21

  li x1, 0x0000000000000000
  li x2, 0xffffffffffff8000
  add x3, x1, x2
  li x4, 0xffffffffffff8000
  bne x3, x4, fail_add_23

  li x1, 0xffffffff80000000
  li x2, 0x00000000
  add x3, x1, x2
  li x4, 0xffffffff80000000
  bne x3, x4, fail_add_24

  li x1, 0xffffffff80000000
  li x2, 0xffffffffffff8000
  add x3, x1, x2
  li x4, 0xffffffff7fff8000
  bne x3, x4, fail_add_25

  li x1, 0x0000000000000000
  li x2, 0x0000000000007fff
  add x3, x1, x2
  li x4, 0x0000000000007fff
  bne x3, x4, fail_add_27

  li x1, 0x000000007fffffff
  li x2, 0x0000000000000000
  add x3, x1, x2
  li x4, 0x000000007fffffff
  bne x3, x4, fail_add_28

  li x1, 0x000000007fffffff
  li x2, 0x0000000000007fff
  add x3, x1, x2
  li x4, 0x0000000080007ffe
  bne x3, x4, fail_add_29

  li x1, 0xffffffff80000000
  li x2, 0x0000000000007fff
  add x3, x1, x2
  li x4, 0xffffffff80007fff
  bne x3, x4, fail_add_31

  li x1, 0x000000007fffffff
  li x2, 0xffffffffffff8000
  add x3, x1, x2
  li x4, 0x000000007fff7fff
  bne x3, x4, fail_add_32

  li x1, 0x0000000000000000
  li x2, 0xffffffffffffffff
  add x3, x1, x2
  li x4, 0xffffffffffffffff
  bne x3, x4, fail_add_34

  li x1, 0xffffffffffffffff
  li x2, 0x0000000000000001
  add x3, x1, x2
  li x4, 0x0000000000000000
  bne x3, x4, fail_add_35

  li x1, 0xffffffffffffffff
  li x2, 0xffffffffffffffff
  add x3, x1, x2
  li x4, 0xfffffffffffffffe
  bne x3, x4, fail_add_36

  li x1, 0x0000000000000001
  li x2, 0x000000007fffffff
  add x3, x1, x2
  li x4, 0x0000000080000000
  bne x3, x4, fail_add_38

#-------------------------------------------------------------
# Source/Destination tests
#-------------------------------------------------------------
  li x1, 13
  li x2, 11
  add x3, x1, x2
  li x4, 24
  bne x3, x4, fail_add_44

  li x1, 14
  li x2, 11
  add x3, x1, x2
  li x4, 25
  bne x3, x4, fail_add_45

# Macro arg error in: TEST_RR_SRC12_EQ_DEST( 19, add, 26, 13 )
#-------------------------------------------------------------
# Bypassing tests
#-------------------------------------------------------------
  li x1, 24
  li x2, 13
  0 x3, x1, x2
  li x4, add
  bne x3, x4, fail_add_52

  li x1, 25
  li x2, 14
  1 x3, x1, x2
  li x4, add
  bne x3, x4, fail_add_53

  li x1, 26
  li x2, 15
  2 x3, x1, x2
  li x4, add
  bne x3, x4, fail_add_54

  li x1, add
  li x2, 24
  0 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_add_56

  li x1, add
  li x2, 25
  0 x3, x1, x2
  li x4, 1
  bne x3, x4, fail_add_57

  li x1, add
  li x2, 26
  0 x3, x1, x2
  li x4, 2
  bne x3, x4, fail_add_58

  li x1, add
  li x2, 24
  1 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_add_59

  li x1, add
  li x2, 25
  1 x3, x1, x2
  li x4, 1
  bne x3, x4, fail_add_60

  li x1, add
  li x2, 26
  2 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_add_61

  li x1, add
  li x2, 24
  0 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_add_63

  li x1, add
  li x2, 25
  0 x3, x1, x2
  li x4, 1
  bne x3, x4, fail_add_64

  li x1, add
  li x2, 26
  0 x3, x1, x2
  li x4, 2
  bne x3, x4, fail_add_65

  li x1, add
  li x2, 24
  1 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_add_66

  li x1, add
  li x2, 25
  1 x3, x1, x2
  li x4, 1
  bne x3, x4, fail_add_67

  li x1, add
  li x2, 26
  2 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_add_68

# Macro arg error in: TEST_RR_ZEROSRC1( 35, add, 15, 15 )
# Macro arg error in: TEST_RR_ZEROSRC2( 36, add, 32, 32 )
# Macro arg error in: TEST_RR_ZEROSRC12( 37, add, 0 )
# Macro arg error in: TEST_RR_ZERODEST( 38, add, 16, 30 )
# Could not parse: TEST_PASSFAIL
.data
# Could not parse: TEST_DATA
  li x11, 1
  sw x11, 0(x10)
  addi x10, x10, 4
  j next_add
fail_add:
  li x11, 15
  sw x11, 0(x10)
  addi x10, x10, 4
next_add:

# === ADDI ===
#-------------------------------------------------------------
# Arithmetic tests
#-------------------------------------------------------------
  li x1, 0x00000000
  addi x3, x1, 0x000
  li x4, 0x00000000
  bne x3, x4, fail_addi_19

  li x1, 0x00000001
  addi x3, x1, 0x001
  li x4, 0x00000002
  bne x3, x4, fail_addi_20

  li x1, 0x00000003
  addi x3, x1, 0x007
  li x4, 0x0000000a
  bne x3, x4, fail_addi_21

  li x1, 0x0000000000000000
  addi x3, x1, 0x800
  li x4, 0xfffffffffffff800
  bne x3, x4, fail_addi_23

  li x1, 0xffffffff80000000
  addi x3, x1, 0x000
  li x4, 0xffffffff80000000
  bne x3, x4, fail_addi_24

  li x1, 0xffffffff80000000
  addi x3, x1, 0x800
  li x4, 0xffffffff7ffff800
  bne x3, x4, fail_addi_25

  li x1, 0x00000000
  addi x3, x1, 0x7ff
  li x4, 0x00000000000007ff
  bne x3, x4, fail_addi_27

  li x1, 0x7fffffff
  addi x3, x1, 0x000
  li x4, 0x000000007fffffff
  bne x3, x4, fail_addi_28

  li x1, 0x7fffffff
  addi x3, x1, 0x7ff
  li x4, 0x00000000800007fe
  bne x3, x4, fail_addi_29

  li x1, 0xffffffff80000000
  addi x3, x1, 0x7ff
  li x4, 0xffffffff800007ff
  bne x3, x4, fail_addi_31

  li x1, 0x000000007fffffff
  addi x3, x1, 0x800
  li x4, 0x000000007ffff7ff
  bne x3, x4, fail_addi_32

  li x1, 0x0000000000000000
  addi x3, x1, 0xfff
  li x4, 0xffffffffffffffff
  bne x3, x4, fail_addi_34

  li x1, 0xffffffffffffffff
  addi x3, x1, 0x001
  li x4, 0x0000000000000000
  bne x3, x4, fail_addi_35

  li x1, 0xffffffffffffffff
  addi x3, x1, 0xfff
  li x4, 0xfffffffffffffffe
  bne x3, x4, fail_addi_36

  li x1, 0x7fffffff
  addi x3, x1, 0x001
  li x4, 0x0000000080000000
  bne x3, x4, fail_addi_38

#-------------------------------------------------------------
# Source/Destination tests
#-------------------------------------------------------------
  li x1, 13
  addi x3, x1, 11
  li x4, 24
  bne x3, x4, fail_addi_44

#-------------------------------------------------------------
# Bypassing tests
#-------------------------------------------------------------
  li x1, 13
  addi x3, x1, 11
  li x4, 24
  bne x3, x4, fail_addi_50

  li x1, 13
  addi x3, x1, 10
  li x4, 23
  bne x3, x4, fail_addi_51

  li x1, 13
  addi x3, x1, 9
  li x4, 22
  bne x3, x4, fail_addi_52

  li x1, 13
  addi x3, x1, 11
  li x4, 24
  bne x3, x4, fail_addi_54

  li x1, 13
  addi x3, x1, 10
  li x4, 23
  bne x3, x4, fail_addi_55

  li x1, 13
  addi x3, x1, 9
  li x4, 22
  bne x3, x4, fail_addi_56

# Macro arg error in: TEST_IMM_ZEROSRC1( 24, addi, 32, 32 )
# Macro arg error in: TEST_IMM_ZERODEST( 25, addi, 33, 50 )
# Could not parse: TEST_PASSFAIL
.data
# Could not parse: TEST_DATA
  li x11, 1
  sw x11, 0(x10)
  addi x10, x10, 4
  j next_addi
fail_addi:
  li x11, 15
  sw x11, 0(x10)
  addi x10, x10, 4
next_addi:

# === AND ===
#-------------------------------------------------------------
# Logical tests
#-------------------------------------------------------------
  li x1, 0xff00ff00
  li x2, 0x0f0f0f0f
  and x3, x1, x2
  li x4, 0x0f000f00
  bne x3, x4, fail_and_19

  li x1, 0x0ff00ff0
  li x2, 0xf0f0f0f0
  and x3, x1, x2
  li x4, 0x00f000f0
  bne x3, x4, fail_and_20

  li x1, 0x00ff00ff
  li x2, 0x0f0f0f0f
  and x3, x1, x2
  li x4, 0x000f000f
  bne x3, x4, fail_and_21

  li x1, 0xf00ff00f
  li x2, 0xf0f0f0f0
  and x3, x1, x2
  li x4, 0xf000f000
  bne x3, x4, fail_and_22

#-------------------------------------------------------------
# Source/Destination tests
#-------------------------------------------------------------
  li x1, 0xff00ff00
  li x2, 0x0f0f0f0f
  and x3, x1, x2
  li x4, 0x0f000f00
  bne x3, x4, fail_and_28

  li x1, 0x0ff00ff0
  li x2, 0xf0f0f0f0
  and x3, x1, x2
  li x4, 0x00f000f0
  bne x3, x4, fail_and_29

# Macro arg error in: TEST_RR_SRC12_EQ_DEST( 8, and, 0xff00ff00, 0xff00ff00 )
#-------------------------------------------------------------
# Bypassing tests
#-------------------------------------------------------------
  li x1, 0x0f000f00
  li x2, 0xff00ff00
  0 x3, x1, x2
  li x4, and
  bne x3, x4, fail_and_36

  li x1, 0x00f000f0
  li x2, 0x0ff00ff0
  1 x3, x1, x2
  li x4, and
  bne x3, x4, fail_and_37

  li x1, 0x000f000f
  li x2, 0x00ff00ff
  2 x3, x1, x2
  li x4, and
  bne x3, x4, fail_and_38

  li x1, and
  li x2, 0x0f000f00
  0 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_and_40

  li x1, and
  li x2, 0x00f000f0
  0 x3, x1, x2
  li x4, 1
  bne x3, x4, fail_and_41

  li x1, and
  li x2, 0x000f000f
  0 x3, x1, x2
  li x4, 2
  bne x3, x4, fail_and_42

  li x1, and
  li x2, 0x0f000f00
  1 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_and_43

  li x1, and
  li x2, 0x00f000f0
  1 x3, x1, x2
  li x4, 1
  bne x3, x4, fail_and_44

  li x1, and
  li x2, 0x000f000f
  2 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_and_45

  li x1, and
  li x2, 0x0f000f00
  0 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_and_47

  li x1, and
  li x2, 0x00f000f0
  0 x3, x1, x2
  li x4, 1
  bne x3, x4, fail_and_48

  li x1, and
  li x2, 0x000f000f
  0 x3, x1, x2
  li x4, 2
  bne x3, x4, fail_and_49

  li x1, and
  li x2, 0x0f000f00
  1 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_and_50

  li x1, and
  li x2, 0x00f000f0
  1 x3, x1, x2
  li x4, 1
  bne x3, x4, fail_and_51

  li x1, and
  li x2, 0x000f000f
  2 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_and_52

# Macro arg error in: TEST_RR_ZEROSRC1( 24, and, 0, 0xff00ff00 )
# Macro arg error in: TEST_RR_ZEROSRC2( 25, and, 0, 0x00ff00ff )
# Macro arg error in: TEST_RR_ZEROSRC12( 26, and, 0 )
# Macro arg error in: TEST_RR_ZERODEST( 27, and, 0x11111111, 0x22222222 )
# Could not parse: TEST_PASSFAIL
.data
# Could not parse: TEST_DATA
  li x11, 1
  sw x11, 0(x10)
  addi x10, x10, 4
  j next_and
fail_and:
  li x11, 15
  sw x11, 0(x10)
  addi x10, x10, 4
next_and:

# === ANDI ===
#-------------------------------------------------------------
# Logical tests
#-------------------------------------------------------------
  li x1, 0xff00ff00
  andi x3, x1, 0xf0f
  li x4, 0xff00ff00
  bne x3, x4, fail_andi_19

  li x1, 0x0ff00ff0
  andi x3, x1, 0x0f0
  li x4, 0x000000f0
  bne x3, x4, fail_andi_20

  li x1, 0x00ff00ff
  andi x3, x1, 0x70f
  li x4, 0x0000000f
  bne x3, x4, fail_andi_21

  li x1, 0xf00ff00f
  andi x3, x1, 0x0f0
  li x4, 0x00000000
  bne x3, x4, fail_andi_22

#-------------------------------------------------------------
# Source/Destination tests
#-------------------------------------------------------------
  li x1, 0xff00ff00
  andi x3, x1, 0x0f0
  li x4, 0x00000000
  bne x3, x4, fail_andi_28

#-------------------------------------------------------------
# Bypassing tests
#-------------------------------------------------------------
  li x1, 0x0ff00ff0
  andi x3, x1, 0x70f
  li x4, 0x00000700
  bne x3, x4, fail_andi_34

  li x1, 0x00ff00ff
  andi x3, x1, 0x0f0
  li x4, 0x000000f0
  bne x3, x4, fail_andi_35

  li x1, 0xf00ff00f
  andi x3, x1, 0xf0f
  li x4, 0xf00ff00f
  bne x3, x4, fail_andi_36

  li x1, 0x0ff00ff0
  andi x3, x1, 0x70f
  li x4, 0x00000700
  bne x3, x4, fail_andi_38

  li x1, 0x00ff00ff
  andi x3, x1, 0x0f0
  li x4, 0x000000f0
  bne x3, x4, fail_andi_39

  li x1, 0xf00ff00f
  andi x3, x1, 0x70f
  li x4, 0x0000000f
  bne x3, x4, fail_andi_40

# Macro arg error in: TEST_IMM_ZEROSRC1( 13, andi, 0, 0x0f0 )
# Macro arg error in: TEST_IMM_ZERODEST( 14, andi, 0x00ff00ff, 0x70f )
# Could not parse: TEST_PASSFAIL
.data
# Could not parse: TEST_DATA
  li x11, 1
  sw x11, 0(x10)
  addi x10, x10, 4
  j next_andi
fail_andi:
  li x11, 15
  sw x11, 0(x10)
  addi x10, x10, 4
next_andi:

# === AUIPC ===
# Could not parse: TEST_CASE(2, a0, 10000, \
.align 3; \
lla a0, 1f + 10000; \
jal a1, 1f; \
1: sub a0, a0, a1; \
)
# Could not parse: TEST_CASE(3, a0, -10000, \
.align 3; \
lla a0, 1f - 10000; \
jal a1, 1f; \
1: sub a0, a0, a1; \
)
# Could not parse: TEST_PASSFAIL
.data
# Could not parse: TEST_DATA
  li x11, 1
  sw x11, 0(x10)
  addi x10, x10, 4
  j next_auipc
fail_auipc:
  li x11, 15
  sw x11, 0(x10)
  addi x10, x10, 4
next_auipc:

# === BEQ ===
#-------------------------------------------------------------
# Branch tests
#-------------------------------------------------------------
# Each test checks both forward and backward branches
# Unsupported macro type: TEST_BR2_OP_TAKEN( 2, beq,  0,  0 )
# Unsupported macro type: TEST_BR2_OP_TAKEN( 3, beq,  1,  1 )
# Unsupported macro type: TEST_BR2_OP_TAKEN( 4, beq, -1, -1 )
# Unsupported macro type: TEST_BR2_OP_NOTTAKEN( 5, beq,  0,  1 )
# Unsupported macro type: TEST_BR2_OP_NOTTAKEN( 6, beq,  1,  0 )
# Unsupported macro type: TEST_BR2_OP_NOTTAKEN( 7, beq, -1,  1 )
# Unsupported macro type: TEST_BR2_OP_NOTTAKEN( 8, beq,  1, -1 )
#-------------------------------------------------------------
# Bypassing tests
#-------------------------------------------------------------
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 9,  0, 0, beq, 0, -1 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 10, 0, 1, beq, 0, -1 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 11, 0, 2, beq, 0, -1 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 12, 1, 0, beq, 0, -1 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 13, 1, 1, beq, 0, -1 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 14, 2, 0, beq, 0, -1 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 15, 0, 0, beq, 0, -1 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 16, 0, 1, beq, 0, -1 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 17, 0, 2, beq, 0, -1 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 18, 1, 0, beq, 0, -1 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 19, 1, 1, beq, 0, -1 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 20, 2, 0, beq, 0, -1 )
#-------------------------------------------------------------
# Test delay slot instructions not executed nor bypassed
#-------------------------------------------------------------
# Could not parse: TEST_CASE( 21, x1, 3, \
li  x1, 1; \
beq x0, x0, 1f; \
addi x1, x1, 1; \
addi x1, x1, 1; \
addi x1, x1, 1; \
addi x1, x1, 1; \
1:  addi x1, x1, 1; \
addi x1, x1, 1; \
)
# Could not parse: TEST_PASSFAIL
.data
# Could not parse: TEST_DATA
  li x11, 1
  sw x11, 0(x10)
  addi x10, x10, 4
  j next_beq
fail_beq:
  li x11, 15
  sw x11, 0(x10)
  addi x10, x10, 4
next_beq:

# === BGE ===
#-------------------------------------------------------------
# Branch tests
#-------------------------------------------------------------
# Each test checks both forward and backward branches
# Unsupported macro type: TEST_BR2_OP_TAKEN( 2, bge,  0,  0 )
# Unsupported macro type: TEST_BR2_OP_TAKEN( 3, bge,  1,  1 )
# Unsupported macro type: TEST_BR2_OP_TAKEN( 4, bge, -1, -1 )
# Unsupported macro type: TEST_BR2_OP_TAKEN( 5, bge,  1,  0 )
# Unsupported macro type: TEST_BR2_OP_TAKEN( 6, bge,  1, -1 )
# Unsupported macro type: TEST_BR2_OP_TAKEN( 7, bge, -1, -2 )
# Unsupported macro type: TEST_BR2_OP_NOTTAKEN(  8, bge,  0,  1 )
# Unsupported macro type: TEST_BR2_OP_NOTTAKEN(  9, bge, -1,  1 )
# Unsupported macro type: TEST_BR2_OP_NOTTAKEN( 10, bge, -2, -1 )
# Unsupported macro type: TEST_BR2_OP_NOTTAKEN( 11, bge, -2,  1 )
#-------------------------------------------------------------
# Bypassing tests
#-------------------------------------------------------------
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 12, 0, 0, bge, -1, 0 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 13, 0, 1, bge, -1, 0 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 14, 0, 2, bge, -1, 0 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 15, 1, 0, bge, -1, 0 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 16, 1, 1, bge, -1, 0 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 17, 2, 0, bge, -1, 0 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 18, 0, 0, bge, -1, 0 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 19, 0, 1, bge, -1, 0 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 20, 0, 2, bge, -1, 0 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 21, 1, 0, bge, -1, 0 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 22, 1, 1, bge, -1, 0 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 23, 2, 0, bge, -1, 0 )
#-------------------------------------------------------------
# Test delay slot instructions not executed nor bypassed
#-------------------------------------------------------------
# Could not parse: TEST_CASE( 24, x1, 3, \
li  x1, 1; \
bge x1, x0, 1f; \
addi x1, x1, 1; \
addi x1, x1, 1; \
addi x1, x1, 1; \
addi x1, x1, 1; \
1:  addi x1, x1, 1; \
addi x1, x1, 1; \
)
# Could not parse: TEST_PASSFAIL
.data
# Could not parse: TEST_DATA
  li x11, 1
  sw x11, 0(x10)
  addi x10, x10, 4
  j next_bge
fail_bge:
  li x11, 15
  sw x11, 0(x10)
  addi x10, x10, 4
next_bge:

# === BGEU ===
#-------------------------------------------------------------
# Branch tests
#-------------------------------------------------------------
# Each test checks both forward and backward branches
# Unsupported macro type: TEST_BR2_OP_TAKEN( 2, bgeu, 0x00000000, 0x00000000 )
# Unsupported macro type: TEST_BR2_OP_TAKEN( 3, bgeu, 0x00000001, 0x00000001 )
# Unsupported macro type: TEST_BR2_OP_TAKEN( 4, bgeu, 0xffffffff, 0xffffffff )
# Unsupported macro type: TEST_BR2_OP_TAKEN( 5, bgeu, 0x00000001, 0x00000000 )
# Unsupported macro type: TEST_BR2_OP_TAKEN( 6, bgeu, 0xffffffff, 0xfffffffe )
# Unsupported macro type: TEST_BR2_OP_TAKEN( 7, bgeu, 0xffffffff, 0x00000000 )
# Unsupported macro type: TEST_BR2_OP_NOTTAKEN(  8, bgeu, 0x00000000, 0x00000001 )
# Unsupported macro type: TEST_BR2_OP_NOTTAKEN(  9, bgeu, 0xfffffffe, 0xffffffff )
# Unsupported macro type: TEST_BR2_OP_NOTTAKEN( 10, bgeu, 0x00000000, 0xffffffff )
# Unsupported macro type: TEST_BR2_OP_NOTTAKEN( 11, bgeu, 0x7fffffff, 0x80000000 )
#-------------------------------------------------------------
# Bypassing tests
#-------------------------------------------------------------
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 12, 0, 0, bgeu, 0xefffffff, 0xf0000000 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 13, 0, 1, bgeu, 0xefffffff, 0xf0000000 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 14, 0, 2, bgeu, 0xefffffff, 0xf0000000 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 15, 1, 0, bgeu, 0xefffffff, 0xf0000000 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 16, 1, 1, bgeu, 0xefffffff, 0xf0000000 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 17, 2, 0, bgeu, 0xefffffff, 0xf0000000 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 18, 0, 0, bgeu, 0xefffffff, 0xf0000000 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 19, 0, 1, bgeu, 0xefffffff, 0xf0000000 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 20, 0, 2, bgeu, 0xefffffff, 0xf0000000 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 21, 1, 0, bgeu, 0xefffffff, 0xf0000000 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 22, 1, 1, bgeu, 0xefffffff, 0xf0000000 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 23, 2, 0, bgeu, 0xefffffff, 0xf0000000 )
#-------------------------------------------------------------
# Test delay slot instructions not executed nor bypassed
#-------------------------------------------------------------
# Could not parse: TEST_CASE( 24, x1, 3, \
li  x1, 1; \
bgeu x1, x0, 1f; \
addi x1, x1, 1; \
addi x1, x1, 1; \
addi x1, x1, 1; \
addi x1, x1, 1; \
1:  addi x1, x1, 1; \
addi x1, x1, 1; \
)
# Could not parse: TEST_PASSFAIL
.data
# Could not parse: TEST_DATA
  li x11, 1
  sw x11, 0(x10)
  addi x10, x10, 4
  j next_bgeu
fail_bgeu:
  li x11, 15
  sw x11, 0(x10)
  addi x10, x10, 4
next_bgeu:

# === BLT ===
#-------------------------------------------------------------
# Branch tests
#-------------------------------------------------------------
# Each test checks both forward and backward branches
# Unsupported macro type: TEST_BR2_OP_TAKEN( 2, blt,  0,  1 )
# Unsupported macro type: TEST_BR2_OP_TAKEN( 3, blt, -1,  1 )
# Unsupported macro type: TEST_BR2_OP_TAKEN( 4, blt, -2, -1 )
# Unsupported macro type: TEST_BR2_OP_NOTTAKEN( 5, blt,  1,  0 )
# Unsupported macro type: TEST_BR2_OP_NOTTAKEN( 6, blt,  1, -1 )
# Unsupported macro type: TEST_BR2_OP_NOTTAKEN( 7, blt, -1, -2 )
# Unsupported macro type: TEST_BR2_OP_NOTTAKEN( 8, blt,  1, -2 )
#-------------------------------------------------------------
# Bypassing tests
#-------------------------------------------------------------
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 9,  0, 0, blt, 0, -1 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 10, 0, 1, blt, 0, -1 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 11, 0, 2, blt, 0, -1 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 12, 1, 0, blt, 0, -1 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 13, 1, 1, blt, 0, -1 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 14, 2, 0, blt, 0, -1 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 15, 0, 0, blt, 0, -1 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 16, 0, 1, blt, 0, -1 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 17, 0, 2, blt, 0, -1 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 18, 1, 0, blt, 0, -1 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 19, 1, 1, blt, 0, -1 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 20, 2, 0, blt, 0, -1 )
#-------------------------------------------------------------
# Test delay slot instructions not executed nor bypassed
#-------------------------------------------------------------
# Could not parse: TEST_CASE( 21, x1, 3, \
li  x1, 1; \
blt x0, x1, 1f; \
addi x1, x1, 1; \
addi x1, x1, 1; \
addi x1, x1, 1; \
addi x1, x1, 1; \
1:  addi x1, x1, 1; \
addi x1, x1, 1; \
)
# Could not parse: TEST_PASSFAIL
.data
# Could not parse: TEST_DATA
  li x11, 1
  sw x11, 0(x10)
  addi x10, x10, 4
  j next_blt
fail_blt:
  li x11, 15
  sw x11, 0(x10)
  addi x10, x10, 4
next_blt:

# === BLTU ===
#-------------------------------------------------------------
# Branch tests
#-------------------------------------------------------------
# Each test checks both forward and backward branches
# Unsupported macro type: TEST_BR2_OP_TAKEN( 2, bltu, 0x00000000, 0x00000001 )
# Unsupported macro type: TEST_BR2_OP_TAKEN( 3, bltu, 0xfffffffe, 0xffffffff )
# Unsupported macro type: TEST_BR2_OP_TAKEN( 4, bltu, 0x00000000, 0xffffffff )
# Unsupported macro type: TEST_BR2_OP_NOTTAKEN( 5, bltu, 0x00000001, 0x00000000 )
# Unsupported macro type: TEST_BR2_OP_NOTTAKEN( 6, bltu, 0xffffffff, 0xfffffffe )
# Unsupported macro type: TEST_BR2_OP_NOTTAKEN( 7, bltu, 0xffffffff, 0x00000000 )
# Unsupported macro type: TEST_BR2_OP_NOTTAKEN( 8, bltu, 0x80000000, 0x7fffffff )
#-------------------------------------------------------------
# Bypassing tests
#-------------------------------------------------------------
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 9,  0, 0, bltu, 0xf0000000, 0xefffffff )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 10, 0, 1, bltu, 0xf0000000, 0xefffffff )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 11, 0, 2, bltu, 0xf0000000, 0xefffffff )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 12, 1, 0, bltu, 0xf0000000, 0xefffffff )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 13, 1, 1, bltu, 0xf0000000, 0xefffffff )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 14, 2, 0, bltu, 0xf0000000, 0xefffffff )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 15, 0, 0, bltu, 0xf0000000, 0xefffffff )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 16, 0, 1, bltu, 0xf0000000, 0xefffffff )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 17, 0, 2, bltu, 0xf0000000, 0xefffffff )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 18, 1, 0, bltu, 0xf0000000, 0xefffffff )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 19, 1, 1, bltu, 0xf0000000, 0xefffffff )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 20, 2, 0, bltu, 0xf0000000, 0xefffffff )
#-------------------------------------------------------------
# Test delay slot instructions not executed nor bypassed
#-------------------------------------------------------------
# Could not parse: TEST_CASE( 21, x1, 3, \
li  x1, 1; \
bltu x0, x1, 1f; \
addi x1, x1, 1; \
addi x1, x1, 1; \
addi x1, x1, 1; \
addi x1, x1, 1; \
1:  addi x1, x1, 1; \
addi x1, x1, 1; \
)
# Could not parse: TEST_PASSFAIL
.data
# Could not parse: TEST_DATA
  li x11, 1
  sw x11, 0(x10)
  addi x10, x10, 4
  j next_bltu
fail_bltu:
  li x11, 15
  sw x11, 0(x10)
  addi x10, x10, 4
next_bltu:

# === BNE ===
#-------------------------------------------------------------
# Branch tests
#-------------------------------------------------------------
# Each test checks both forward and backward branches
# Unsupported macro type: TEST_BR2_OP_TAKEN( 2, bne,  0,  1 )
# Unsupported macro type: TEST_BR2_OP_TAKEN( 3, bne,  1,  0 )
# Unsupported macro type: TEST_BR2_OP_TAKEN( 4, bne, -1,  1 )
# Unsupported macro type: TEST_BR2_OP_TAKEN( 5, bne,  1, -1 )
# Unsupported macro type: TEST_BR2_OP_NOTTAKEN( 6, bne,  0,  0 )
# Unsupported macro type: TEST_BR2_OP_NOTTAKEN( 7, bne,  1,  1 )
# Unsupported macro type: TEST_BR2_OP_NOTTAKEN( 8, bne, -1, -1 )
#-------------------------------------------------------------
# Bypassing tests
#-------------------------------------------------------------
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 9,  0, 0, bne, 0, 0 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 10, 0, 1, bne, 0, 0 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 11, 0, 2, bne, 0, 0 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 12, 1, 0, bne, 0, 0 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 13, 1, 1, bne, 0, 0 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 14, 2, 0, bne, 0, 0 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 15, 0, 0, bne, 0, 0 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 16, 0, 1, bne, 0, 0 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 17, 0, 2, bne, 0, 0 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 18, 1, 0, bne, 0, 0 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 19, 1, 1, bne, 0, 0 )
# Unsupported macro type: TEST_BR2_SRC12_BYPASS( 20, 2, 0, bne, 0, 0 )
#-------------------------------------------------------------
# Test delay slot instructions not executed nor bypassed
#-------------------------------------------------------------
# Could not parse: TEST_CASE( 21, x1, 3, \
li  x1, 1; \
bne x1, x0, 1f; \
addi x1, x1, 1; \
addi x1, x1, 1; \
addi x1, x1, 1; \
addi x1, x1, 1; \
1:  addi x1, x1, 1; \
addi x1, x1, 1; \
)
# Could not parse: TEST_PASSFAIL
.data
# Could not parse: TEST_DATA
  li x11, 1
  sw x11, 0(x10)
  addi x10, x10, 4
  j next_bne
fail_bne:
  li x11, 15
  sw x11, 0(x10)
  addi x10, x10, 4
next_bne:

# === FENCE_I ===
li a3, 111
lh a0, insn
lh a1, insn+2
.align 6
sh a0, 2f, t0
sh a1, 2f+2, t0
fence.i
la a5, 2f
jalr t1, a5, 0
# Unsupported macro type: TEST_CASE( 2, a3, 444, nop )
li a4, 100
1: addi a4, a4, -1
bnez a4, 1b
sh a0, 3f, t0
sh a1, 3f+2, t0
fence.i
.align 6
la a5, 3f
jalr t1, a5, 0
# Unsupported macro type: TEST_CASE( 3, a3, 777, nop )
# Could not parse: TEST_PASSFAIL
.data
# Could not parse: TEST_DATA
insn:
addi a3, a3, 333
2: addi a3, a3, 222
jalr a5, t1, 0
3: addi a3, a3, 555
jalr a5, t1, 0
  li x11, 1
  sw x11, 0(x10)
  addi x10, x10, 4
  j next_fence_i
fail_fence_i:
  li x11, 15
  sw x11, 0(x10)
  addi x10, x10, 4
next_fence_i:

# === JAL ===
#-------------------------------------------------------------
# Test 2: Basic test
#-------------------------------------------------------------
test_2:
li  TESTNUM, 2
li  ra, 0
jal x4, target_2
linkaddr_2:
nop
nop
j fail
target_2:
la  x2, linkaddr_2
bne x2, x4, fail
#-------------------------------------------------------------
# Test delay slot instructions not executed nor bypassed
#-------------------------------------------------------------
# Could not parse: TEST_CASE( 3, ra, 3, \
li  ra, 1; \
jal x0, 1f; \
addi ra, ra, 1; \
addi ra, ra, 1; \
addi ra, ra, 1; \
addi ra, ra, 1; \
1:  addi ra, ra, 1; \
addi ra, ra, 1; \
)
# Could not parse: TEST_PASSFAIL
.data
# Could not parse: TEST_DATA
  li x11, 1
  sw x11, 0(x10)
  addi x10, x10, 4
  j next_jal
fail_jal:
  li x11, 15
  sw x11, 0(x10)
  addi x10, x10, 4
next_jal:

# === JALR ===
#-------------------------------------------------------------
# Test 2: Basic test
#-------------------------------------------------------------
test_2:
li  TESTNUM, 2
li  t0, 0
la  t1, target_2
jalr t0, t1, 0
linkaddr_2:
j fail
target_2:
la  t1, linkaddr_2
bne t0, t1, fail
#-------------------------------------------------------------
# Test 3: Basic test2, rs = rd
#-------------------------------------------------------------
test_3:
li  TESTNUM, 3
la  t0, target_3
jalr t0, t0, 0
linkaddr_3:
j fail
target_3:
la  t1, linkaddr_3
bne t0, t1, fail
#-------------------------------------------------------------
# Bypassing tests
#-------------------------------------------------------------
# Unsupported macro type: TEST_JALR_SRC1_BYPASS( 4, 0, jalr )
# Unsupported macro type: TEST_JALR_SRC1_BYPASS( 5, 1, jalr )
# Unsupported macro type: TEST_JALR_SRC1_BYPASS( 6, 2, jalr )
#-------------------------------------------------------------
# Test delay slot instructions not executed nor bypassed
#-------------------------------------------------------------
.option push
.align 2
.option norvc
# Could not parse: TEST_CASE( 7, t0, 4, \
li  t0, 1; \
la  t1, 1f; \
jr  t1, -4; \
addi t0, t0, 1; \
addi t0, t0, 1; \
addi t0, t0, 1; \
addi t0, t0, 1; \
1:  addi t0, t0, 1; \
addi t0, t0, 1; \
)
.option pop
# Could not parse: TEST_PASSFAIL
.data
# Could not parse: TEST_DATA
  li x11, 1
  sw x11, 0(x10)
  addi x10, x10, 4
  j next_jalr
fail_jalr:
  li x11, 15
  sw x11, 0(x10)
  addi x10, x10, 4
next_jalr:

# === LB ===
#-------------------------------------------------------------
# Basic tests
#-------------------------------------------------------------
# Unsupported macro type: TEST_LD_OP( 2, lb, 0xffffffffffffffff, 0,  tdat )
# Unsupported macro type: TEST_LD_OP( 3, lb, 0x0000000000000000, 1,  tdat )
# Unsupported macro type: TEST_LD_OP( 4, lb, 0xfffffffffffffff0, 2,  tdat )
# Unsupported macro type: TEST_LD_OP( 5, lb, 0x000000000000000f, 3, tdat )
# Test with negative offset
# Unsupported macro type: TEST_LD_OP( 6, lb, 0xffffffffffffffff, -3, tdat4 )
# Unsupported macro type: TEST_LD_OP( 7, lb, 0x0000000000000000, -2,  tdat4 )
# Unsupported macro type: TEST_LD_OP( 8, lb, 0xfffffffffffffff0, -1,  tdat4 )
# Unsupported macro type: TEST_LD_OP( 9, lb, 0x000000000000000f, 0,   tdat4 )
# Test with a negative base
# Could not parse: TEST_CASE( 10, x5, 0xffffffffffffffff, \
la  x1, tdat; \
addi x1, x1, -32; \
lb x5, 32(x1); \
)
# Test with unaligned base
# Could not parse: TEST_CASE( 11, x5, 0x0000000000000000, \
la  x1, tdat; \
addi x1, x1, -6; \
lb x5, 7(x1); \
)
#-------------------------------------------------------------
# Bypassing tests
#-------------------------------------------------------------
# Unsupported macro type: TEST_LD_DEST_BYPASS( 12, 0, lb, 0xfffffffffffffff0, 1, tdat2 )
# Unsupported macro type: TEST_LD_DEST_BYPASS( 13, 1, lb, 0x000000000000000f, 1, tdat3 )
# Unsupported macro type: TEST_LD_DEST_BYPASS( 14, 2, lb, 0x0000000000000000, 1, tdat1 )
# Unsupported macro type: TEST_LD_SRC1_BYPASS( 15, 0, lb, 0xfffffffffffffff0, 1, tdat2 )
# Unsupported macro type: TEST_LD_SRC1_BYPASS( 16, 1, lb, 0x000000000000000f, 1, tdat3 )
# Unsupported macro type: TEST_LD_SRC1_BYPASS( 17, 2, lb, 0x0000000000000000, 1, tdat1 )
#-------------------------------------------------------------
# Test write-after-write hazard
#-------------------------------------------------------------
# Could not parse: TEST_CASE( 18, x2, 2, \
la  x5, tdat; \
lb  x2, 0(x5); \
li  x2, 2; \
)
# Could not parse: TEST_CASE( 19, x2, 2, \
la  x5, tdat; \
lb  x2, 0(x5); \
nop; \
li  x2, 2; \
)
# Could not parse: TEST_PASSFAIL
.data
# Could not parse: TEST_DATA
tdat:
tdat1:  .byte 0xff
tdat2:  .byte 0x00
tdat3:  .byte 0xf0
tdat4:  .byte 0x0f
  li x11, 1
  sw x11, 0(x10)
  addi x10, x10, 4
  j next_lb
fail_lb:
  li x11, 15
  sw x11, 0(x10)
  addi x10, x10, 4
next_lb:

# === LBU ===
#-------------------------------------------------------------
# Basic tests
#-------------------------------------------------------------
# Unsupported macro type: TEST_LD_OP( 2, lbu, 0x00000000000000ff, 0,  tdat )
# Unsupported macro type: TEST_LD_OP( 3, lbu, 0x0000000000000000, 1,  tdat )
# Unsupported macro type: TEST_LD_OP( 4, lbu, 0x00000000000000f0, 2,  tdat )
# Unsupported macro type: TEST_LD_OP( 5, lbu, 0x000000000000000f, 3, tdat )
# Test with negative offset
# Unsupported macro type: TEST_LD_OP( 6, lbu, 0x00000000000000ff, -3, tdat4 )
# Unsupported macro type: TEST_LD_OP( 7, lbu, 0x0000000000000000, -2,  tdat4 )
# Unsupported macro type: TEST_LD_OP( 8, lbu, 0x00000000000000f0, -1,  tdat4 )
# Unsupported macro type: TEST_LD_OP( 9, lbu, 0x000000000000000f, 0,   tdat4 )
# Test with a negative base
# Could not parse: TEST_CASE( 10, x5, 0x00000000000000ff, \
la  x1, tdat; \
addi x1, x1, -32; \
lbu x5, 32(x1); \
)
# Test with unaligned base
# Could not parse: TEST_CASE( 11, x5, 0x0000000000000000, \
la  x1, tdat; \
addi x1, x1, -6; \
lbu x5, 7(x1); \
)
#-------------------------------------------------------------
# Bypassing tests
#-------------------------------------------------------------
# Unsupported macro type: TEST_LD_DEST_BYPASS( 12, 0, lbu, 0x00000000000000f0, 1, tdat2 )
# Unsupported macro type: TEST_LD_DEST_BYPASS( 13, 1, lbu, 0x000000000000000f, 1, tdat3 )
# Unsupported macro type: TEST_LD_DEST_BYPASS( 14, 2, lbu, 0x0000000000000000, 1, tdat1 )
# Unsupported macro type: TEST_LD_SRC1_BYPASS( 15, 0, lbu, 0x00000000000000f0, 1, tdat2 )
# Unsupported macro type: TEST_LD_SRC1_BYPASS( 16, 1, lbu, 0x000000000000000f, 1, tdat3 )
# Unsupported macro type: TEST_LD_SRC1_BYPASS( 17, 2, lbu, 0x0000000000000000, 1, tdat1 )
#-------------------------------------------------------------
# Test write-after-write hazard
#-------------------------------------------------------------
# Could not parse: TEST_CASE( 18, x2, 2, \
la  x5, tdat; \
lbu  x2, 0(x5); \
li  x2, 2; \
)
# Could not parse: TEST_CASE( 19, x2, 2, \
la  x5, tdat; \
lbu  x2, 0(x5); \
nop; \
li  x2, 2; \
)
# Could not parse: TEST_PASSFAIL
.data
# Could not parse: TEST_DATA
tdat:
tdat1:  .byte 0xff
tdat2:  .byte 0x00
tdat3:  .byte 0xf0
tdat4:  .byte 0x0f
  li x11, 1
  sw x11, 0(x10)
  addi x10, x10, 4
  j next_lbu
fail_lbu:
  li x11, 15
  sw x11, 0(x10)
  addi x10, x10, 4
next_lbu:

# === LD_ST ===
#-------------------------------------------------------------
# Bypassing Tests
#-------------------------------------------------------------
# Test sb and lb (signed byte)
# Unsupported macro type: TEST_LD_ST_BYPASS(2,  lb,  sb, 0xffffffffffffffdd, 0, tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(3,  lb,  sb, 0xffffffffffffffcd, 1, tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(4,  lb,  sb, 0xffffffffffffffcc, 2, tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(5,  lb,  sb, 0xffffffffffffffbc, 3, tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(6,  lb,  sb, 0xffffffffffffffbb, 4, tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(7,  lb,  sb, 0xffffffffffffffab, 5, tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(8,  lb, sb, 0x33, 0, tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(9,  lb, sb, 0x23, 1, tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(10, lb, sb, 0x22, 2, tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(11, lb, sb, 0x12, 3, tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(12, lb, sb, 0x11, 4, tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(13, lb, sb, 0x01, 5, tdat )
# Test sb and lbu (unsigned byte)
# Unsupported macro type: TEST_LD_ST_BYPASS(14, lbu, sb, 0x33, 0, tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(15, lbu, sb, 0x23, 1, tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(16, lbu, sb, 0x22, 2, tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(17, lbu, sb, 0x12, 3, tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(18, lbu, sb, 0x11, 4, tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(19, lbu, sb, 0x01, 5, tdat )
# Test sw and lw (signed word)
# Unsupported macro type: TEST_LD_ST_BYPASS(20, lw, sw, 0xffffffffaabbccdd, 0,  tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(21, lw, sw, 0xffffffffdaabbccd, 4,  tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(22, lw, sw, 0xffffffffddaabbcc, 8,  tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(23, lw, sw, 0xffffffffcddaabbc, 12, tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(24, lw, sw, 0xffffffffccddaabb, 16, tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(25, lw, sw, 0xffffffffbccddaab, 20, tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(26, lw, sw, 0x00112233, 0,  tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(27, lw, sw, 0x30011223, 4,  tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(28, lw, sw, 0x33001122, 8,  tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(29, lw, sw, 0x23300112, 12, tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(30, lw, sw, 0x22330011, 16, tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(31, lw, sw, 0x12233001, 20, tdat )
# Test sh and lh (signed halfword)
# Unsupported macro type: TEST_LD_ST_BYPASS(32, lh, sh, 0xffffffffffffccdd, 0, tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(33, lh, sh, 0xffffffffffffbccd, 2, tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(34, lh, sh, 0xffffffffffffbbcc, 4, tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(35, lh, sh, 0xffffffffffffabbc, 6, tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(36, lh, sh, 0xffffffffffffaabb, 8, tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(37, lh, sh, 0xffffffffffffdaab, 10, tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(38, lh, sh, 0x2233, 0, tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(39, lh, sh, 0x1223, 2, tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(40, lh, sh, 0x1122, 4, tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(41, lh, sh, 0x0112, 6, tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(42, lh, sh, 0x0011, 8, tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(43, lh, sh, 0x3001, 10, tdat )
# Test sh and lhu (unsigned halfword)
# Unsupported macro type: TEST_LD_ST_BYPASS(44, lhu, sh, 0x2233, 0, tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(45, lhu, sh, 0x1223, 2, tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(46, lhu, sh, 0x1122, 4, tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(47, lhu, sh, 0x0112, 6, tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(48, lhu, sh, 0x0011, 8, tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(49, lhu, sh, 0x3001, 10, tdat )
# RV64-specific tests for ld, sd, and lwu
# Test sd and ld (doubleword)
# Unsupported macro type: TEST_LD_ST_BYPASS(50, ld, sd, 0x0011223344556677, 0,  tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(51, ld, sd, 0x1122334455667788, 8,  tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(52, ld, sd, 0x2233445566778899, 16, tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(53, ld, sd, 0xabbccdd, 0,  tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(54, ld, sd, 0xaabbccd, 8,  tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(55, ld, sd, 0xdaabbcc, 16, tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(56, ld, sd, 0xddaabbc, 24, tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(57, ld, sd, 0xcddaabb, 32, tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(58, ld, sd, 0xccddaab, 40, tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(59, ld, sd, 0x00112233, 0,  tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(60, ld, sd, 0x30011223, 8,  tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(61, ld, sd, 0x33001122, 16, tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(62, ld, sd, 0x23300112, 24, tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(63, ld, sd, 0x22330011, 32, tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(64, ld, sd, 0x12233001, 40, tdat )
# Test sw and lwu (unsigned word)
# Unsupported macro type: TEST_LD_ST_BYPASS(65, lwu, sw, 0x00112233, 0,  tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(66, lwu, sw, 0x33001122, 8,  tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(67, lwu, sw, 0x30011223, 4,  tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(68, lwu, sw, 0x23300112, 12, tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(69, lwu, sw, 0x22330011, 16, tdat )
# Unsupported macro type: TEST_LD_ST_BYPASS(70, lwu, sw, 0x12233001, 20, tdat )
li a0, 0xef         # Immediate load for manual store test
la a1, tdat         # Load address of tdat
sb a0, 3(a1)        # Store byte at offset 3 of tdat
lb a2, 3(a1)        # Load byte back for verification
# Could not parse: TEST_PASSFAIL
.data
# Could not parse: TEST_DATA
tdat:
.rept 20
.word 0xdeadbeef
.endr
  li x11, 1
  sw x11, 0(x10)
  addi x10, x10, 4
  j next_ld_st
fail_ld_st:
  li x11, 15
  sw x11, 0(x10)
  addi x10, x10, 4
next_ld_st:

# === LH ===
#-------------------------------------------------------------
# Basic tests
#-------------------------------------------------------------
# Unsupported macro type: TEST_LD_OP( 2, lh, 0x00000000000000ff, 0,  tdat )
# Unsupported macro type: TEST_LD_OP( 3, lh, 0xffffffffffffff00, 2,  tdat )
# Unsupported macro type: TEST_LD_OP( 4, lh, 0x0000000000000ff0, 4,  tdat )
# Unsupported macro type: TEST_LD_OP( 5, lh, 0xfffffffffffff00f, 6, tdat )
# Test with negative offset
# Unsupported macro type: TEST_LD_OP( 6, lh, 0x00000000000000ff, -6,  tdat4 )
# Unsupported macro type: TEST_LD_OP( 7, lh, 0xffffffffffffff00, -4,  tdat4 )
# Unsupported macro type: TEST_LD_OP( 8, lh, 0x0000000000000ff0, -2,  tdat4 )
# Unsupported macro type: TEST_LD_OP( 9, lh, 0xfffffffffffff00f,  0, tdat4 )
# Test with a negative base
# Could not parse: TEST_CASE( 10, x5, 0x00000000000000ff, \
la  x1, tdat; \
addi x1, x1, -32; \
lh x5, 32(x1); \
)
# Test with unaligned base
# Could not parse: TEST_CASE( 11, x5, 0xffffffffffffff00, \
la  x1, tdat; \
addi x1, x1, -5; \
lh x5, 7(x1); \
)
#-------------------------------------------------------------
# Bypassing tests
#-------------------------------------------------------------
# Unsupported macro type: TEST_LD_DEST_BYPASS( 12, 0, lh, 0x0000000000000ff0, 2, tdat2 )
# Unsupported macro type: TEST_LD_DEST_BYPASS( 13, 1, lh, 0xfffffffffffff00f, 2, tdat3 )
# Unsupported macro type: TEST_LD_DEST_BYPASS( 14, 2, lh, 0xffffffffffffff00, 2, tdat1 )
# Unsupported macro type: TEST_LD_SRC1_BYPASS( 15, 0, lh, 0x0000000000000ff0, 2, tdat2 )
# Unsupported macro type: TEST_LD_SRC1_BYPASS( 16, 1, lh, 0xfffffffffffff00f, 2, tdat3 )
# Unsupported macro type: TEST_LD_SRC1_BYPASS( 17, 2, lh, 0xffffffffffffff00, 2, tdat1 )
#-------------------------------------------------------------
# Test write-after-write hazard
#-------------------------------------------------------------
# Could not parse: TEST_CASE( 18, x2, 2, \
la  x5, tdat; \
lh  x2, 0(x5); \
li  x2, 2; \
)
# Could not parse: TEST_CASE( 19, x2, 2, \
la  x5, tdat; \
lh  x2, 0(x5); \
nop; \
li  x2, 2; \
)
# Could not parse: TEST_PASSFAIL
.data
# Could not parse: TEST_DATA
tdat:
tdat1:  .half 0x00ff
tdat2:  .half 0xff00
tdat3:  .half 0x0ff0
tdat4:  .half 0xf00f
  li x11, 1
  sw x11, 0(x10)
  addi x10, x10, 4
  j next_lh
fail_lh:
  li x11, 15
  sw x11, 0(x10)
  addi x10, x10, 4
next_lh:

# === LHU ===
#-------------------------------------------------------------
# Basic tests
#-------------------------------------------------------------
# Unsupported macro type: TEST_LD_OP( 2, lhu, 0x00000000000000ff, 0,  tdat )
# Unsupported macro type: TEST_LD_OP( 3, lhu, 0x000000000000ff00, 2,  tdat )
# Unsupported macro type: TEST_LD_OP( 4, lhu, 0x0000000000000ff0, 4,  tdat )
# Unsupported macro type: TEST_LD_OP( 5, lhu, 0x000000000000f00f, 6, tdat )
# Test with negative offset
# Unsupported macro type: TEST_LD_OP( 6, lhu, 0x00000000000000ff, -6,  tdat4 )
# Unsupported macro type: TEST_LD_OP( 7, lhu, 0x000000000000ff00, -4,  tdat4 )
# Unsupported macro type: TEST_LD_OP( 8, lhu, 0x0000000000000ff0, -2,  tdat4 )
# Unsupported macro type: TEST_LD_OP( 9, lhu, 0x000000000000f00f,  0, tdat4 )
# Test with a negative base
# Could not parse: TEST_CASE( 10, x5, 0x00000000000000ff, \
la  x1, tdat; \
addi x1, x1, -32; \
lhu x5, 32(x1); \
)
# Test with unaligned base
# Could not parse: TEST_CASE( 11, x5, 0x000000000000ff00, \
la  x1, tdat; \
addi x1, x1, -5; \
lhu x5, 7(x1); \
)
#-------------------------------------------------------------
# Bypassing tests
#-------------------------------------------------------------
# Unsupported macro type: TEST_LD_DEST_BYPASS( 12, 0, lhu, 0x0000000000000ff0, 2, tdat2 )
# Unsupported macro type: TEST_LD_DEST_BYPASS( 13, 1, lhu, 0x000000000000f00f, 2, tdat3 )
# Unsupported macro type: TEST_LD_DEST_BYPASS( 14, 2, lhu, 0x000000000000ff00, 2, tdat1 )
# Unsupported macro type: TEST_LD_SRC1_BYPASS( 15, 0, lhu, 0x0000000000000ff0, 2, tdat2 )
# Unsupported macro type: TEST_LD_SRC1_BYPASS( 16, 1, lhu, 0x000000000000f00f, 2, tdat3 )
# Unsupported macro type: TEST_LD_SRC1_BYPASS( 17, 2, lhu, 0x000000000000ff00, 2, tdat1 )
#-------------------------------------------------------------
# Test write-after-write hazard
#-------------------------------------------------------------
# Could not parse: TEST_CASE( 18, x2, 2, \
la  x5, tdat; \
lhu  x2, 0(x5); \
li  x2, 2; \
)
# Could not parse: TEST_CASE( 19, x2, 2, \
la  x5, tdat; \
lhu  x2, 0(x5); \
nop; \
li  x2, 2; \
)
# Could not parse: TEST_PASSFAIL
.data
# Could not parse: TEST_DATA
tdat:
tdat1:  .half 0x00ff
tdat2:  .half 0xff00
tdat3:  .half 0x0ff0
tdat4:  .half 0xf00f
  li x11, 1
  sw x11, 0(x10)
  addi x10, x10, 4
  j next_lhu
fail_lhu:
  li x11, 15
  sw x11, 0(x10)
  addi x10, x10, 4
next_lhu:

# === LUI ===
#-------------------------------------------------------------
# Basic tests
#-------------------------------------------------------------
# Unsupported macro type: TEST_CASE( 2, x1, 0x0000000000000000, lui x1, 0x00000 )
# Unsupported macro type: TEST_CASE( 3, x1, 0xfffffffffffff800, lui x1, 0xfffff;sra x1,x1,1)
# Unsupported macro type: TEST_CASE( 4, x1, 0x00000000000007ff, lui x1, 0x7ffff;sra x1,x1,20)
# Unsupported macro type: TEST_CASE( 5, x1, 0xfffffffffffff800, lui x1, 0x80000;sra x1,x1,20)
# Unsupported macro type: TEST_CASE( 6, x0, 0, lui x0, 0x80000 )
# Could not parse: TEST_PASSFAIL
.data
# Could not parse: TEST_DATA
  li x11, 1
  sw x11, 0(x10)
  addi x10, x10, 4
  j next_lui
fail_lui:
  li x11, 15
  sw x11, 0(x10)
  addi x10, x10, 4
next_lui:

# === LW ===
#-------------------------------------------------------------
# Basic tests
#-------------------------------------------------------------
# Unsupported macro type: TEST_LD_OP( 2, lw, 0x0000000000ff00ff, 0,  tdat )
# Unsupported macro type: TEST_LD_OP( 3, lw, 0xffffffffff00ff00, 4,  tdat )
# Unsupported macro type: TEST_LD_OP( 4, lw, 0x000000000ff00ff0, 8,  tdat )
# Unsupported macro type: TEST_LD_OP( 5, lw, 0xfffffffff00ff00f, 12, tdat )
# Test with negative offset
# Unsupported macro type: TEST_LD_OP( 6, lw, 0x0000000000ff00ff, -12, tdat4 )
# Unsupported macro type: TEST_LD_OP( 7, lw, 0xffffffffff00ff00, -8,  tdat4 )
# Unsupported macro type: TEST_LD_OP( 8, lw, 0x000000000ff00ff0, -4,  tdat4 )
# Unsupported macro type: TEST_LD_OP( 9, lw, 0xfffffffff00ff00f, 0,   tdat4 )
# Test with a negative base
# Could not parse: TEST_CASE( 10, x5, 0x0000000000ff00ff, \
la  x1, tdat; \
addi x1, x1, -32; \
lw x5, 32(x1); \
)
# Test with unaligned base
# Could not parse: TEST_CASE( 11, x5, 0xffffffffff00ff00, \
la  x1, tdat; \
addi x1, x1, -3; \
lw x5, 7(x1); \
)
#-------------------------------------------------------------
# Bypassing tests
#-------------------------------------------------------------
# Unsupported macro type: TEST_LD_DEST_BYPASS( 12, 0, lw, 0x000000000ff00ff0, 4, tdat2 )
# Unsupported macro type: TEST_LD_DEST_BYPASS( 13, 1, lw, 0xfffffffff00ff00f, 4, tdat3 )
# Unsupported macro type: TEST_LD_DEST_BYPASS( 14, 2, lw, 0xffffffffff00ff00, 4, tdat1 )
# Unsupported macro type: TEST_LD_SRC1_BYPASS( 15, 0, lw, 0x000000000ff00ff0, 4, tdat2 )
# Unsupported macro type: TEST_LD_SRC1_BYPASS( 16, 1, lw, 0xfffffffff00ff00f, 4, tdat3 )
# Unsupported macro type: TEST_LD_SRC1_BYPASS( 17, 2, lw, 0xffffffffff00ff00, 4, tdat1 )
#-------------------------------------------------------------
# Test write-after-write hazard
#-------------------------------------------------------------
# Could not parse: TEST_CASE( 18, x2, 2, \
la  x5, tdat; \
lw  x2, 0(x5); \
li  x2, 2; \
)
# Could not parse: TEST_CASE( 19, x2, 2, \
la  x5, tdat; \
lw  x2, 0(x5); \
nop; \
li  x2, 2; \
)
# Could not parse: TEST_PASSFAIL
.data
# Could not parse: TEST_DATA
tdat:
tdat1:  .word 0x00ff00ff
tdat2:  .word 0xff00ff00
tdat3:  .word 0x0ff00ff0
tdat4:  .word 0xf00ff00f
  li x11, 1
  sw x11, 0(x10)
  addi x10, x10, 4
  j next_lw
fail_lw:
  li x11, 15
  sw x11, 0(x10)
  addi x10, x10, 4
next_lw:

# === MA_DATA ===
la s0, data
/* Check that a misaligned load reads the correct value. */
li TESTNUM, testnum; \
li t1, res; \
insn t2, offset(base); \
bne t1, t2, fail; \
1:
MISALIGNED_LOAD_TEST(1,  lh,  s0, 1, SEXT(0x0201, 16))
MISALIGNED_LOAD_TEST(2,  lhu, s0, 1, 0x0201)
MISALIGNED_LOAD_TEST(3,  lw,  s0, 1, SEXT(0x04030201, 32))
MISALIGNED_LOAD_TEST(4,  lw,  s0, 2, SEXT(0x05040302, 32))
MISALIGNED_LOAD_TEST(5,  lw,  s0, 3, SEXT(0x06050403, 32))
MISALIGNED_LOAD_TEST(6,  lwu, s0, 1, 0x04030201)
MISALIGNED_LOAD_TEST(7,  lwu, s0, 2, 0x05040302)
MISALIGNED_LOAD_TEST(8,  lwu, s0, 3, 0x06050403)
MISALIGNED_LOAD_TEST(9,  ld, s0, 1, 0x0807060504030201)
MISALIGNED_LOAD_TEST(10, ld, s0, 2, 0x0908070605040302)
MISALIGNED_LOAD_TEST(11, ld, s0, 3, 0x0a09080706050403)
MISALIGNED_LOAD_TEST(12, ld, s0, 4, 0x0b0a090807060504)
MISALIGNED_LOAD_TEST(13, ld, s0, 5, 0x0c0b0a0908070605)
MISALIGNED_LOAD_TEST(14, ld, s0, 6, 0x0d0c0b0a09080706)
MISALIGNED_LOAD_TEST(15, ld, s0, 7, 0x0e0d0c0b0a090807)
MISALIGNED_LOAD_TEST(16, lh,  s0, 31, SEXT(0x201f, 16))
MISALIGNED_LOAD_TEST(17, lhu, s0, 31, 0x201f)
MISALIGNED_LOAD_TEST(18, lw,  s0, 29, SEXT(0x201f1e1d, 32))
MISALIGNED_LOAD_TEST(19, lw,  s0, 30, SEXT(0x21201f1e, 32))
MISALIGNED_LOAD_TEST(20, lw,  s0, 31, SEXT(0x2221201f, 32))
MISALIGNED_LOAD_TEST(21, lwu, s0, 29, 0x201f1e1d)
MISALIGNED_LOAD_TEST(22, lwu, s0, 30, 0x21201f1e)
MISALIGNED_LOAD_TEST(23, lwu, s0, 31, 0x2221201f)
MISALIGNED_LOAD_TEST(24, ld, s0, 25, 0x201f1e1d1c1b1a19)
MISALIGNED_LOAD_TEST(25, ld, s0, 26, 0x21201f1e1d1c1b1a)
MISALIGNED_LOAD_TEST(26, ld, s0, 27, 0x2221201f1e1d1c1b)
MISALIGNED_LOAD_TEST(27, ld, s0, 28, 0x232221201f1e1d1c)
MISALIGNED_LOAD_TEST(28, ld, s0, 29, 0x24232221201f1e1d)
MISALIGNED_LOAD_TEST(29, ld, s0, 30, 0x2524232221201f1e)
MISALIGNED_LOAD_TEST(30, ld, s0, 31, 0x262524232221201f)
MISALIGNED_LOAD_TEST(31, lh,  s0, 63, SEXT(0x403f, 16))
MISALIGNED_LOAD_TEST(32, lhu, s0, 63, 0x403f)
MISALIGNED_LOAD_TEST(33, lw,  s0, 61, SEXT(0x403f3e3d, 32))
MISALIGNED_LOAD_TEST(34, lw,  s0, 62, SEXT(0x41403f3e, 32))
MISALIGNED_LOAD_TEST(35, lw,  s0, 63, SEXT(0x4241403f, 32))
MISALIGNED_LOAD_TEST(36, lwu, s0, 61, 0x403f3e3d)
MISALIGNED_LOAD_TEST(37, lwu, s0, 62, 0x41403f3e)
MISALIGNED_LOAD_TEST(38, lwu, s0, 63, 0x4241403f)
MISALIGNED_LOAD_TEST(39, ld, s0, 57, 0x403f3e3d3c3b3a39)
MISALIGNED_LOAD_TEST(40, ld, s0, 58, 0x41403f3e3d3c3b3a)
MISALIGNED_LOAD_TEST(41, ld, s0, 59, 0x4241403f3e3d3c3b)
MISALIGNED_LOAD_TEST(42, ld, s0, 60, 0x434241403f3e3d3c)
MISALIGNED_LOAD_TEST(43, ld, s0, 61, 0x44434241403f3e3d)
MISALIGNED_LOAD_TEST(44, ld, s0, 62, 0x4544434241403f3e)
MISALIGNED_LOAD_TEST(45, ld, s0, 63, 0x464544434241403f)
/* Check that a misaligned store writes the correct value. */
li TESTNUM, testnum; \
li t1, st_data; \
st_insn t1, offset(base); \
ld_insn t2, offset(base); \
bne t1, t2, fail; \
1:
MISALIGNED_STORE_TEST(46, sh, lh,  s0, 1, SEXT(0x8180, 16))
MISALIGNED_STORE_TEST(47, sh, lhu, s0, 1, 0x8382)
MISALIGNED_STORE_TEST(48, sw, lw,  s0, 1, SEXT(0x87868584, 32))
MISALIGNED_STORE_TEST(49, sw, lw,  s0, 2, SEXT(0x8b8a8988, 32))
MISALIGNED_STORE_TEST(50, sw, lw,  s0, 3, SEXT(0x8f8e8d8c, 32))
MISALIGNED_STORE_TEST(51, sw, lwu, s0, 1, 0x93929190)
MISALIGNED_STORE_TEST(52, sw, lwu, s0, 2, 0x97969594)
MISALIGNED_STORE_TEST(53, sw, lwu, s0, 3, 0x9b9a9998)
MISALIGNED_STORE_TEST(54, sd, ld, s0, 1, 0xa3a2a1a09f9e9d9c)
MISALIGNED_STORE_TEST(55, sd, ld, s0, 2, 0xabaaa9a8a7a6a5a4)
MISALIGNED_STORE_TEST(56, sd, ld, s0, 3, 0xb3b2b1b0afaeadac)
MISALIGNED_STORE_TEST(57, sd, ld, s0, 4, 0xbbbab9b8b7b6b5b4)
MISALIGNED_STORE_TEST(58, sd, ld, s0, 5, 0xc3c2c1c0bfbebdbc)
MISALIGNED_STORE_TEST(59, sd, ld, s0, 6, 0xcbcac9c8c7c6c5c4)
MISALIGNED_STORE_TEST(60, sd, ld, s0, 7, 0xd3d2d1d0cfcecdcc)
MISALIGNED_STORE_TEST(61, sh, lh,  s0, 31, SEXT(0xd5d4, 16))
MISALIGNED_STORE_TEST(62, sh, lhu, s0, 31, 0xd7d6)
MISALIGNED_STORE_TEST(63, sw, lw,  s0, 29, SEXT(0xdbdad9d8, 32))
MISALIGNED_STORE_TEST(64, sw, lw,  s0, 30, SEXT(0xdfdedddc, 32))
MISALIGNED_STORE_TEST(65, sw, lw,  s0, 31, SEXT(0xe3e2e1e0, 32))
MISALIGNED_STORE_TEST(66, sw, lwu, s0, 29, 0xe7e6e5e4)
MISALIGNED_STORE_TEST(67, sw, lwu, s0, 30, 0xebeae9e8)
MISALIGNED_STORE_TEST(68, sw, lwu, s0, 31, 0xefeeedec)
MISALIGNED_STORE_TEST(69, sd, ld, s0, 25, 0xf7f6f5f4f3f2f1f0)
MISALIGNED_STORE_TEST(70, sd, ld, s0, 26, 0xfffefdfcfbfaf9f8)
MISALIGNED_STORE_TEST(71, sd, ld, s0, 27, 0x0706050403020100)
MISALIGNED_STORE_TEST(72, sd, ld, s0, 28, 0x0f0e0d0c0b0a0908)
MISALIGNED_STORE_TEST(73, sd, ld, s0, 29, 0x1716151413121110)
MISALIGNED_STORE_TEST(74, sd, ld, s0, 30, 0x1f1e1d1c1b1a1918)
MISALIGNED_STORE_TEST(75, sd, ld, s0, 31, 0x2726252423222120)
MISALIGNED_STORE_TEST(76, sh, lh,  s0, 63, SEXT(0x3534, 16))
MISALIGNED_STORE_TEST(77, sh, lhu, s0, 63, 0x3736)
MISALIGNED_STORE_TEST(78, sw, lw,  s0, 61, SEXT(0x3b3a3938, 32))
MISALIGNED_STORE_TEST(79, sw, lw,  s0, 62, SEXT(0x3f3e3d3c, 32))
MISALIGNED_STORE_TEST(80, sw, lw,  s0, 63, SEXT(0x43424140, 32))
MISALIGNED_STORE_TEST(81, sw, lwu, s0, 61, 0x47464544)
MISALIGNED_STORE_TEST(82, sw, lwu, s0, 62, 0x4b4a4948)
MISALIGNED_STORE_TEST(83, sw, lwu, s0, 63, 0x4f4e4d4c)
MISALIGNED_STORE_TEST(84, sd, ld, s0, 57, 0x5756555453525150)
MISALIGNED_STORE_TEST(85, sd, ld, s0, 58, 0x5f5e5d5c5b5a5958)
MISALIGNED_STORE_TEST(86, sd, ld, s0, 59, 0x6766656463626160)
MISALIGNED_STORE_TEST(87, sd, ld, s0, 60, 0x6f6e6d6c6b6a6968)
MISALIGNED_STORE_TEST(88, sd, ld, s0, 61, 0x7776757473727170)
MISALIGNED_STORE_TEST(89, sd, ld, s0, 62, 0x7f7e7d7c7b7a7978)
MISALIGNED_STORE_TEST(90, sd, ld, s0, 63, 0x8786858483828180)
/* Check that a misaligned store writes the correct value, checked by a narrower load. */
li TESTNUM, testnum; \
li t1, st_data; \
li t2, ld_data; \
st_insn t1, st_offset(base); \
ld_insn t3, ld_offset(base); \
bne t2, t3, fail; \
1:
MISMATCHED_STORE_TEST(91,  sh, lb,  s0, 1, 1, 0x9998, SEXT(0x98, 8))
MISMATCHED_STORE_TEST(92,  sh, lb,  s0, 1, 2, 0x9b9a, SEXT(0x9b, 8))
MISMATCHED_STORE_TEST(93,  sh, lbu, s0, 1, 1, 0x9d9c, 0x9c)
MISMATCHED_STORE_TEST(94,  sh, lbu, s0, 1, 2, 0x9f9e, 0x9f)
MISMATCHED_STORE_TEST(95,  sw, lb,  s0, 1, 1, 0xa3a2a1a0, SEXT(0xa0, 8))
MISMATCHED_STORE_TEST(96,  sw, lbu, s0, 2, 3, 0xa7a6a5a4, 0xa5)
MISMATCHED_STORE_TEST(97,  sw, lh,  s0, 3, 4, 0xabaaa9a8, SEXT(0xaaa9, 16))
MISMATCHED_STORE_TEST(98,  sw, lhu, s0, 3, 5, 0xafaeadac, 0xafae)
MISMATCHED_STORE_TEST(99,  sd, lb,  s0, 1, 7, 0xb7b6b5b4b3b2b1b0, SEXT(0xb6, 8))
MISMATCHED_STORE_TEST(100, sd, lbu, s0, 2, 3, 0xbfbebdbcbbbab9b8, 0xb9)
MISMATCHED_STORE_TEST(101, sd, lh,  s0, 3, 9, 0xc7c6c5c4c3c2c1c0, SEXT(0xc7c6, 16))
MISMATCHED_STORE_TEST(102, sd, lhu, s0, 4, 5, 0xcfcecdcccbcac9c8, 0xcac9)
MISMATCHED_STORE_TEST(103, sd, lw,  s0, 5, 9, 0xd7d6d5d4d3d2d1d0, SEXT(0xd7d6d5d4, 32))
MISMATCHED_STORE_TEST(104, sd, lw,  s0, 6, 8, 0xdfdedddcdbdad9d8, SEXT(0xdddcdbda, 32))
MISMATCHED_STORE_TEST(105, sd, lwu, s0, 7, 8, 0xe7e6e5e4e3e2e1e0, 0xe4e3e2e1)
MISMATCHED_STORE_TEST(106, sh, lb,  s0, 31, 31, 0xe9e8, SEXT(0xe8, 8))
MISMATCHED_STORE_TEST(107, sh, lb,  s0, 31, 32, 0xebea, SEXT(0xeb, 8))
MISMATCHED_STORE_TEST(108, sh, lbu, s0, 31, 31, 0xedec, 0xec)
MISMATCHED_STORE_TEST(109, sh, lbu, s0, 31, 32, 0xefee, 0xef)
MISMATCHED_STORE_TEST(110, sw, lb,  s0, 29, 29, 0xf3f2f1f0, SEXT(0xf0, 8))
MISMATCHED_STORE_TEST(111, sw, lbu, s0, 30, 32, 0xf7f6f5f4, 0xf6)
MISMATCHED_STORE_TEST(112, sw, lh,  s0, 29, 31, 0xfbfaf9f8, SEXT(0xfbfa, 16))
MISMATCHED_STORE_TEST(113, sw, lhu, s0, 31, 31, 0xfffefdfc, 0xfdfc)
MISMATCHED_STORE_TEST(114, sd, lb,  s0, 25, 32, 0x0706050403020100, SEXT(0x07, 8))
MISMATCHED_STORE_TEST(115, sd, lbu, s0, 26, 33, 0x0f0e0d0c0b0a0908, 0x0f)
MISMATCHED_STORE_TEST(116, sd, lh,  s0, 27, 31, 0x1716151413121110, SEXT(0x1514, 16))
MISMATCHED_STORE_TEST(117, sd, lhu, s0, 28, 31, 0x1f1e1d1c1b1a1918, 0x1c1b)
MISMATCHED_STORE_TEST(118, sd, lw,  s0, 29, 29, 0x2726252423222120, SEXT(0x23222120, 32))
MISMATCHED_STORE_TEST(119, sd, lw,  s0, 30, 30, 0x2f2e2d2c2b2a2928, SEXT(0x2b2a2928, 32))
MISMATCHED_STORE_TEST(120, sd, lwu, s0, 31, 31, 0x3736353433323130, 0x33323130)
MISMATCHED_STORE_TEST(121, sh, lb,  s0, 63, 63, 0x4948, SEXT(0x48, 8))
MISMATCHED_STORE_TEST(122, sh, lb,  s0, 63, 64, 0x4b4a, SEXT(0x4b, 8))
MISMATCHED_STORE_TEST(123, sh, lbu, s0, 63, 63, 0x4d4c, 0x4c)
MISMATCHED_STORE_TEST(124, sh, lbu, s0, 63, 64, 0x4f4e, 0x4f)
MISMATCHED_STORE_TEST(125, sw, lb,  s0, 61, 61, 0x53525150, SEXT(0x50, 8))
MISMATCHED_STORE_TEST(126, sw, lbu, s0, 62, 64, 0x57565554, 0x56)
MISMATCHED_STORE_TEST(127, sw, lh,  s0, 61, 63, 0x5b5a5958, SEXT(0x5b5a, 16))
MISMATCHED_STORE_TEST(128, sw, lhu, s0, 63, 63, 0x5f5e5d5c, 0x5d5c)
MISMATCHED_STORE_TEST(129, sd, lb,  s0, 57, 64, 0x6766656463626160, SEXT(0x67, 8))
MISMATCHED_STORE_TEST(130, sd, lbu, s0, 58, 65, 0x6f6e6d6c6b6a6968, 0x6f)
MISMATCHED_STORE_TEST(131, sd, lh,  s0, 59, 63, 0x7776757473727170, SEXT(0x7574, 16))
MISMATCHED_STORE_TEST(132, sd, lhu, s0, 60, 63, 0x7f7e7d7c7b7a7978, 0x7c7b)
MISMATCHED_STORE_TEST(133, sd, lw,  s0, 61, 61, 0x8786858483828180, SEXT(0x83828180, 32))
MISMATCHED_STORE_TEST(134, sd, lw,  s0, 62, 62, 0x8f8e8d8c8b8a8988, SEXT(0x8b8a8988, 32))
MISMATCHED_STORE_TEST(135, sd, lwu, s0, 63, 63, 0x9796959493929190, 0x93929190)
/* Memory contents at this point should be:
.word 0x10080000
.word 0x30282018
.word 0x34333231
.word 0x0f373635
.word 0x13121110
.word 0x17161514
.word 0x10080018
.word 0x30282018
.word 0x34333231
.word 0x27373635
.word 0x2b2a2928
.word 0x2f2e2d2c
.word 0x33323130
.word 0x37363534
.word 0x70686038
.word 0x90888078
.word 0x94939291
.word 0x47979695
.word 0x4b4a4948
.word 0x4f4e4d4c
.word 0x53525150
.word 0x57565554
.word 0x5b5a5958
.word 0x5f5e5d5c
.word 0x63626160
.word 0x67666564
.word 0x6b6a6968
.word 0x6f6e6d6c
.word 0x73727170
.word 0x77767574
.word 0x7b7a7978
.word 0x7f7e7d7c
*/
/* Check that a misaligned store writes the correct value, checked by a wider load. */
MISMATCHED_STORE_TEST(136, sb, lh,  s0, 1, 1, 0x98, SEXT(0xb898, 16))
MISMATCHED_STORE_TEST(137, sb, lhu, s0, 2, 1, 0x99, 0x9998)
MISMATCHED_STORE_TEST(138, sh, lw,  s0, 1, 1, 0x9b9a, SEXT(0xc8c09b9a, 32))
MISMATCHED_STORE_TEST(139, sh, lw,  s0, 3, 2, 0x9d9c, SEXT(0xd09d9c9b, 32))
MISMATCHED_STORE_TEST(140, sh, lw,  s0, 5, 3, 0x9f9e, SEXT(0x9f9e9d9c, 32))
MISMATCHED_STORE_TEST(141, sb, lwu, s0, 2, 1, 0xa0, 0x9d9ca09a)
MISMATCHED_STORE_TEST(142, sh, lwu, s0, 3, 2, 0xa2a1, 0x9ea2a1a0)
MISMATCHED_STORE_TEST(143, sh, lwu, s0, 5, 3, 0xa4a3, 0xa4a3a2a1)
MISMATCHED_STORE_TEST(144, sb, ld, s0, 2,  1, 0xa5, 0xe1e0a4a3a2a1a59a)
MISMATCHED_STORE_TEST(145, sh, ld, s0, 7,  2, 0xa7a6, 0xe2a7a6a4a3a2a1a5)
MISMATCHED_STORE_TEST(146, sh, ld, s0, 9,  3, 0xa9a8, 0xa9a8a7a6a4a3a2a1)
MISMATCHED_STORE_TEST(147, sw, ld, s0, 5,  4, 0xadacabaa, 0xe4a9a8adacabaaa2)
MISMATCHED_STORE_TEST(148, sw, ld, s0, 7,  5, 0xb1b0afae, 0xe5e4b1b0afaeabaa)
MISMATCHED_STORE_TEST(149, sw, ld, s0, 9,  6, 0xb5b4b3b2, 0xe6b5b4b3b2afaeab)
MISMATCHED_STORE_TEST(150, sw, ld, s0, 11, 7, 0xb9b8b7b6, 0xb9b8b7b6b3b2afae)
MISMATCHED_STORE_TEST(151, sb, lh,  s0, 31, 31, 0xba, SEXT(0x31ba, 16))
MISMATCHED_STORE_TEST(152, sb, lhu, s0, 32, 31, 0xbb, 0xbbba)
MISMATCHED_STORE_TEST(153, sh, lw,  s0, 30, 30, 0xbdbc, SEXT(0x32bbbdbc, 32))
MISMATCHED_STORE_TEST(154, sh, lw,  s0, 31, 30, 0xbfbe, SEXT(0x32bfbebc, 32))
MISMATCHED_STORE_TEST(155, sh, lw,  s0, 32, 30, 0xc1c0, SEXT(0xc1c0bebc, 32))
MISMATCHED_STORE_TEST(156, sb, lwu, s0, 32, 31, 0xc2, 0x33c1c2be)
MISMATCHED_STORE_TEST(157, sh, lwu, s0, 31, 29, 0xc4c3, 0xc4c3bc20)
MISMATCHED_STORE_TEST(158, sh, lwu, s0, 32, 30, 0xc6c5, 0xc6c5c3bc)
MISMATCHED_STORE_TEST(159, sb, ld, s0, 32, 25, 0xc7, 0xc7c3bc2018100800)
MISMATCHED_STORE_TEST(160, sh, ld, s0, 31, 26, 0xc9c8, 0xc6c9c8bc20181008)
MISMATCHED_STORE_TEST(161, sh, ld, s0, 31, 27, 0xcbca, 0x33c6cbcabc201810)
MISMATCHED_STORE_TEST(162, sw, ld, s0, 32, 28, 0xcfcecdcc, 0xcfcecdcccabc2018)
MISMATCHED_STORE_TEST(163, sw, ld, s0, 31, 29, 0xd3d2d1d0, 0x35cfd3d2d1d0bc20)
MISMATCHED_STORE_TEST(164, sw, ld, s0, 30, 30, 0xd7d6d5d4, 0x3635cfd3d7d6d5d4)
MISMATCHED_STORE_TEST(165, sw, ld, s0, 29, 31, 0xdbdad9d8, 0x373635cfd3d7dbda)
MISMATCHED_STORE_TEST(166, sb, lh,  s0, 63, 63, 0xdc, SEXT(0x91dc, 16))
MISMATCHED_STORE_TEST(167, sb, lhu, s0, 64, 63, 0xdd, 0xdddc)
MISMATCHED_STORE_TEST(168, sh, lw,  s0, 62, 62, 0xdfde, SEXT(0x92dddfde, 32))
MISMATCHED_STORE_TEST(169, sh, lw,  s0, 63, 62, 0xe1e0, SEXT(0x92e1e0de, 32))
MISMATCHED_STORE_TEST(170, sh, lw,  s0, 64, 62, 0xe3e2, SEXT(0xe3e2e0de, 32))
MISMATCHED_STORE_TEST(171, sb, lwu, s0, 64, 63, 0xe4, 0x93e3e4e0)
MISMATCHED_STORE_TEST(172, sh, lwu, s0, 63, 61, 0xe6e5, 0xe6e5de80)
MISMATCHED_STORE_TEST(173, sh, lwu, s0, 64, 62, 0xe8e7, 0xe8e7e5de)
MISMATCHED_STORE_TEST(174, sb, ld, s0, 64, 57, 0xe9, 0xe9e5de8078706860)
MISMATCHED_STORE_TEST(175, sh, ld, s0, 63, 58, 0xebea, 0xe8ebeade80787068)
MISMATCHED_STORE_TEST(176, sh, ld, s0, 63, 59, 0xedec, 0x93e8edecde807870)
MISMATCHED_STORE_TEST(177, sw, ld, s0, 64, 60, 0xf1f0efee, 0xf1f0efeeecde8078)
MISMATCHED_STORE_TEST(178, sw, ld, s0, 63, 61, 0xf5f4f3f2, 0x95f1f5f4f3f2de80)
MISMATCHED_STORE_TEST(179, sw, ld, s0, 62, 62, 0xf9f8f7f6, 0x9695f1f5f9f8f7f6)
MISMATCHED_STORE_TEST(180, sw, ld, s0, 61, 63, 0xfdfcfbfa, 0x979695f1f5f9fdfc)
# Could not parse: TEST_PASSFAIL
.data
data:
.align 3
.word 0x03020100
.word 0x07060504
.word 0x0b0a0908
.word 0x0f0e0d0c
.word 0x13121110
.word 0x17161514
.word 0x1b1a1918
.word 0x1f1e1d1c
.word 0x23222120
.word 0x27262524
.word 0x2b2a2928
.word 0x2f2e2d2c
.word 0x33323130
.word 0x37363534
.word 0x3b3a3938
.word 0x3f3e3d3c
.word 0x43424140
.word 0x47464544
.word 0x4b4a4948
.word 0x4f4e4d4c
.word 0x53525150
.word 0x57565554
.word 0x5b5a5958
.word 0x5f5e5d5c
.word 0x63626160
.word 0x67666564
.word 0x6b6a6968
.word 0x6f6e6d6c
.word 0x73727170
.word 0x77767574
.word 0x7b7a7978
.word 0x7f7e7d7c
.fill 0xff, 1, 80
# Could not parse: TEST_DATA
  li x11, 1
  sw x11, 0(x10)
  addi x10, x10, 4
  j next_ma_data
fail_ma_data:
  li x11, 15
  sw x11, 0(x10)
  addi x10, x10, 4
next_ma_data:

# === OR ===
#-------------------------------------------------------------
# Logical tests
#-------------------------------------------------------------
  li x1, 0xff00ff00
  li x2, 0x0f0f0f0f
  or x3, x1, x2
  li x4, 0xff0fff0f
  bne x3, x4, fail_or_19

  li x1, 0x0ff00ff0
  li x2, 0xf0f0f0f0
  or x3, x1, x2
  li x4, 0xfff0fff0
  bne x3, x4, fail_or_20

  li x1, 0x00ff00ff
  li x2, 0x0f0f0f0f
  or x3, x1, x2
  li x4, 0x0fff0fff
  bne x3, x4, fail_or_21

  li x1, 0xf00ff00f
  li x2, 0xf0f0f0f0
  or x3, x1, x2
  li x4, 0xf0fff0ff
  bne x3, x4, fail_or_22

#-------------------------------------------------------------
# Source/Destination tests
#-------------------------------------------------------------
  li x1, 0xff00ff00
  li x2, 0x0f0f0f0f
  or x3, x1, x2
  li x4, 0xff0fff0f
  bne x3, x4, fail_or_28

  li x1, 0xff00ff00
  li x2, 0x0f0f0f0f
  or x3, x1, x2
  li x4, 0xff0fff0f
  bne x3, x4, fail_or_29

# Macro arg error in: TEST_RR_SRC12_EQ_DEST( 8, or, 0xff00ff00, 0xff00ff00 )
#-------------------------------------------------------------
# Bypassing tests
#-------------------------------------------------------------
  li x1, 0xff0fff0f
  li x2, 0xff00ff00
  0 x3, x1, x2
  li x4, or
  bne x3, x4, fail_or_36

  li x1, 0xfff0fff0
  li x2, 0x0ff00ff0
  1 x3, x1, x2
  li x4, or
  bne x3, x4, fail_or_37

  li x1, 0x0fff0fff
  li x2, 0x00ff00ff
  2 x3, x1, x2
  li x4, or
  bne x3, x4, fail_or_38

  li x1, or
  li x2, 0xff0fff0f
  0 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_or_40

  li x1, or
  li x2, 0xfff0fff0
  0 x3, x1, x2
  li x4, 1
  bne x3, x4, fail_or_41

  li x1, or
  li x2, 0x0fff0fff
  0 x3, x1, x2
  li x4, 2
  bne x3, x4, fail_or_42

  li x1, or
  li x2, 0xff0fff0f
  1 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_or_43

  li x1, or
  li x2, 0xfff0fff0
  1 x3, x1, x2
  li x4, 1
  bne x3, x4, fail_or_44

  li x1, or
  li x2, 0x0fff0fff
  2 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_or_45

  li x1, or
  li x2, 0xff0fff0f
  0 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_or_47

  li x1, or
  li x2, 0xfff0fff0
  0 x3, x1, x2
  li x4, 1
  bne x3, x4, fail_or_48

  li x1, or
  li x2, 0x0fff0fff
  0 x3, x1, x2
  li x4, 2
  bne x3, x4, fail_or_49

  li x1, or
  li x2, 0xff0fff0f
  1 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_or_50

  li x1, or
  li x2, 0xfff0fff0
  1 x3, x1, x2
  li x4, 1
  bne x3, x4, fail_or_51

  li x1, or
  li x2, 0x0fff0fff
  2 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_or_52

# Macro arg error in: TEST_RR_ZEROSRC1( 24, or, 0xff00ff00, 0xff00ff00 )
# Macro arg error in: TEST_RR_ZEROSRC2( 25, or, 0x00ff00ff, 0x00ff00ff )
# Macro arg error in: TEST_RR_ZEROSRC12( 26, or, 0 )
# Macro arg error in: TEST_RR_ZERODEST( 27, or, 0x11111111, 0x22222222 )
# Could not parse: TEST_PASSFAIL
.data
# Could not parse: TEST_DATA
  li x11, 1
  sw x11, 0(x10)
  addi x10, x10, 4
  j next_or
fail_or:
  li x11, 15
  sw x11, 0(x10)
  addi x10, x10, 4
next_or:

# === ORI ===
#-------------------------------------------------------------
# Logical tests
#-------------------------------------------------------------
  li x1, 0xffffffffff00ff00
  ori x3, x1, 0xf0f
  li x4, 0xffffffffffffff0f
  bne x3, x4, fail_ori_19

  li x1, 0x000000000ff00ff0
  ori x3, x1, 0x0f0
  li x4, 0x000000000ff00ff0
  bne x3, x4, fail_ori_20

  li x1, 0x0000000000ff00ff
  ori x3, x1, 0x70f
  li x4, 0x0000000000ff07ff
  bne x3, x4, fail_ori_21

  li x1, 0xfffffffff00ff00f
  ori x3, x1, 0x0f0
  li x4, 0xfffffffff00ff0ff
  bne x3, x4, fail_ori_22

#-------------------------------------------------------------
# Source/Destination tests
#-------------------------------------------------------------
  li x1, 0xff00ff00
  ori x3, x1, 0x0f0
  li x4, 0xff00fff0
  bne x3, x4, fail_ori_28

#-------------------------------------------------------------
# Bypassing tests
#-------------------------------------------------------------
  li x1, 0x000000000ff00ff0
  ori x3, x1, 0x0f0
  li x4, 0x000000000ff00ff0
  bne x3, x4, fail_ori_34

  li x1, 0x0000000000ff00ff
  ori x3, x1, 0x70f
  li x4, 0x0000000000ff07ff
  bne x3, x4, fail_ori_35

  li x1, 0xfffffffff00ff00f
  ori x3, x1, 0x0f0
  li x4, 0xfffffffff00ff0ff
  bne x3, x4, fail_ori_36

  li x1, 0x000000000ff00ff0
  ori x3, x1, 0x0f0
  li x4, 0x000000000ff00ff0
  bne x3, x4, fail_ori_38

  li x1, 0x0000000000ff00ff
  ori x3, x1, 0xf0f
  li x4, 0xffffffffffffffff
  bne x3, x4, fail_ori_39

  li x1, 0xfffffffff00ff00f
  ori x3, x1, 0x0f0
  li x4, 0xfffffffff00ff0ff
  bne x3, x4, fail_ori_40

# Macro arg error in: TEST_IMM_ZEROSRC1( 13, ori, 0x0f0, 0x0f0 )
# Macro arg error in: TEST_IMM_ZERODEST( 14, ori, 0x00ff00ff, 0x70f )
# Could not parse: TEST_PASSFAIL
.data
# Could not parse: TEST_DATA
  li x11, 1
  sw x11, 0(x10)
  addi x10, x10, 4
  j next_ori
fail_ori:
  li x11, 15
  sw x11, 0(x10)
  addi x10, x10, 4
next_ori:

# === SB ===
#-------------------------------------------------------------
# Basic tests
#-------------------------------------------------------------
# Unsupported macro type: TEST_ST_OP( 2, lb, sb, 0xffffffffffffffaa, 0, tdat )
# Unsupported macro type: TEST_ST_OP( 3, lb, sb, 0x0000000000000000, 1, tdat )
# Unsupported macro type: TEST_ST_OP( 4, lh, sb, 0xffffffffffffefa0, 2, tdat )
# Unsupported macro type: TEST_ST_OP( 5, lb, sb, 0x000000000000000a, 3, tdat )
# Test with negative offset
# Unsupported macro type: TEST_ST_OP( 6, lb, sb, 0xffffffffffffffaa, -3, tdat8 )
# Unsupported macro type: TEST_ST_OP( 7, lb, sb, 0x0000000000000000, -2, tdat8 )
# Unsupported macro type: TEST_ST_OP( 8, lb, sb, 0xffffffffffffffa0, -1, tdat8 )
# Unsupported macro type: TEST_ST_OP( 9, lb, sb, 0x000000000000000a, 0,  tdat8 )
# Test with a negative base
# Could not parse: TEST_CASE( 10, x5, 0x78, \
la  x1, tdat9; \
li  x2, 0x12345678; \
addi x4, x1, -32; \
sb x2, 32(x4); \
lb x5, 0(x1); \
)
# Test with unaligned base
# Could not parse: TEST_CASE( 11, x5, 0xffffffffffffff98, \
la  x1, tdat9; \
li  x2, 0x00003098; \
addi x1, x1, -6; \
sb x2, 7(x1); \
la  x4, tdat10; \
lb x5, 0(x4); \
)
#-------------------------------------------------------------
# Bypassing tests
#-------------------------------------------------------------
# Unsupported macro type: TEST_ST_SRC12_BYPASS( 12, 0, 0, lb, sb, 0xffffffffffffffdd, 0, tdat )
# Unsupported macro type: TEST_ST_SRC12_BYPASS( 13, 0, 1, lb, sb, 0xffffffffffffffcd, 1, tdat )
# Unsupported macro type: TEST_ST_SRC12_BYPASS( 14, 0, 2, lb, sb, 0xffffffffffffffcc, 2, tdat )
# Unsupported macro type: TEST_ST_SRC12_BYPASS( 15, 1, 0, lb, sb, 0xffffffffffffffbc, 3, tdat )
# Unsupported macro type: TEST_ST_SRC12_BYPASS( 16, 1, 1, lb, sb, 0xffffffffffffffbb, 4, tdat )
# Unsupported macro type: TEST_ST_SRC12_BYPASS( 17, 2, 0, lb, sb, 0xffffffffffffffab, 5, tdat )
# Unsupported macro type: TEST_ST_SRC21_BYPASS( 18, 0, 0, lb, sb, 0x33, 0, tdat )
# Unsupported macro type: TEST_ST_SRC21_BYPASS( 19, 0, 1, lb, sb, 0x23, 1, tdat )
# Unsupported macro type: TEST_ST_SRC21_BYPASS( 20, 0, 2, lb, sb, 0x22, 2, tdat )
# Unsupported macro type: TEST_ST_SRC21_BYPASS( 21, 1, 0, lb, sb, 0x12, 3, tdat )
# Unsupported macro type: TEST_ST_SRC21_BYPASS( 22, 1, 1, lb, sb, 0x11, 4, tdat )
# Unsupported macro type: TEST_ST_SRC21_BYPASS( 23, 2, 0, lb, sb, 0x01, 5, tdat )
li a0, 0xef
la a1, tdat
sb a0, 3(a1)
# Could not parse: TEST_PASSFAIL
.data
# Could not parse: TEST_DATA
tdat:
tdat1:  .byte 0xef
tdat2:  .byte 0xef
tdat3:  .byte 0xef
tdat4:  .byte 0xef
tdat5:  .byte 0xef
tdat6:  .byte 0xef
tdat7:  .byte 0xef
tdat8:  .byte 0xef
tdat9:  .byte 0xef
tdat10: .byte 0xef
  li x11, 1
  sw x11, 0(x10)
  addi x10, x10, 4
  j next_sb
fail_sb:
  li x11, 15
  sw x11, 0(x10)
  addi x10, x10, 4
next_sb:

# === SH ===
#-------------------------------------------------------------
# Basic tests
#-------------------------------------------------------------
# Unsupported macro type: TEST_ST_OP( 2, lh, sh, 0x00000000000000aa, 0, tdat )
# Unsupported macro type: TEST_ST_OP( 3, lh, sh, 0xffffffffffffaa00, 2, tdat )
# Unsupported macro type: TEST_ST_OP( 4, lw, sh, 0xffffffffbeef0aa0, 4, tdat )
# Unsupported macro type: TEST_ST_OP( 5, lh, sh, 0xffffffffffffa00a, 6, tdat )
# Test with negative offset
# Unsupported macro type: TEST_ST_OP( 6, lh, sh, 0x00000000000000aa, -6, tdat8 )
# Unsupported macro type: TEST_ST_OP( 7, lh, sh, 0xffffffffffffaa00, -4, tdat8 )
# Unsupported macro type: TEST_ST_OP( 8, lh, sh, 0x0000000000000aa0, -2, tdat8 )
# Unsupported macro type: TEST_ST_OP( 9, lh, sh, 0xffffffffffffa00a, 0,  tdat8 )
# Test with a negative base
# Could not parse: TEST_CASE( 10, x5, 0x5678, \
la  x1, tdat9; \
li  x2, 0x12345678; \
addi x4, x1, -32; \
sh x2, 32(x4); \
lh x5, 0(x1); \
)
# Test with unaligned base
# Could not parse: TEST_CASE( 11, x5, 0x3098, \
la  x1, tdat9; \
li  x2, 0x00003098; \
addi x1, x1, -5; \
sh x2, 7(x1); \
la  x4, tdat10; \
lh x5, 0(x4); \
)
#-------------------------------------------------------------
# Bypassing tests
#-------------------------------------------------------------
# Unsupported macro type: TEST_ST_SRC12_BYPASS( 12, 0, 0, lh, sh, 0xffffffffffffccdd, 0,  tdat )
# Unsupported macro type: TEST_ST_SRC12_BYPASS( 13, 0, 1, lh, sh, 0xffffffffffffbccd, 2,  tdat )
# Unsupported macro type: TEST_ST_SRC12_BYPASS( 14, 0, 2, lh, sh, 0xffffffffffffbbcc, 4,  tdat )
# Unsupported macro type: TEST_ST_SRC12_BYPASS( 15, 1, 0, lh, sh, 0xffffffffffffabbc, 6, tdat )
# Unsupported macro type: TEST_ST_SRC12_BYPASS( 16, 1, 1, lh, sh, 0xffffffffffffaabb, 8, tdat )
# Unsupported macro type: TEST_ST_SRC12_BYPASS( 17, 2, 0, lh, sh, 0xffffffffffffdaab, 10, tdat )
# Unsupported macro type: TEST_ST_SRC21_BYPASS( 18, 0, 0, lh, sh, 0x2233, 0,  tdat )
# Unsupported macro type: TEST_ST_SRC21_BYPASS( 19, 0, 1, lh, sh, 0x1223, 2,  tdat )
# Unsupported macro type: TEST_ST_SRC21_BYPASS( 20, 0, 2, lh, sh, 0x1122, 4,  tdat )
# Unsupported macro type: TEST_ST_SRC21_BYPASS( 21, 1, 0, lh, sh, 0x0112, 6, tdat )
# Unsupported macro type: TEST_ST_SRC21_BYPASS( 22, 1, 1, lh, sh, 0x0011, 8, tdat )
# Unsupported macro type: TEST_ST_SRC21_BYPASS( 23, 2, 0, lh, sh, 0x3001, 10, tdat )
li a0, 0xbeef
la a1, tdat
sh a0, 6(a1)
# Could not parse: TEST_PASSFAIL
.data
# Could not parse: TEST_DATA
tdat:
tdat1:  .half 0xbeef
tdat2:  .half 0xbeef
tdat3:  .half 0xbeef
tdat4:  .half 0xbeef
tdat5:  .half 0xbeef
tdat6:  .half 0xbeef
tdat7:  .half 0xbeef
tdat8:  .half 0xbeef
tdat9:  .half 0xbeef
tdat10: .half 0xbeef
  li x11, 1
  sw x11, 0(x10)
  addi x10, x10, 4
  j next_sh
fail_sh:
  li x11, 15
  sw x11, 0(x10)
  addi x10, x10, 4
next_sh:

# === SIMPLE ===
.data
# Could not parse: TEST_DATA
  li x11, 1
  sw x11, 0(x10)
  addi x10, x10, 4
  j next_simple
fail_simple:
  li x11, 15
  sw x11, 0(x10)
  addi x10, x10, 4
next_simple:

# === SLL ===
#-------------------------------------------------------------
# Arithmetic tests
#-------------------------------------------------------------
  li x1, 0x0000000000000001
  li x2, 0
  sll x3, x1, x2
  li x4, 0x0000000000000001
  bne x3, x4, fail_sll_19

  li x1, 0x0000000000000001
  li x2, 1
  sll x3, x1, x2
  li x4, 0x0000000000000002
  bne x3, x4, fail_sll_20

  li x1, 0x0000000000000001
  li x2, 7
  sll x3, x1, x2
  li x4, 0x0000000000000080
  bne x3, x4, fail_sll_21

  li x1, 0x0000000000000001
  li x2, 14
  sll x3, x1, x2
  li x4, 0x0000000000004000
  bne x3, x4, fail_sll_22

  li x1, 0x0000000000000001
  li x2, 31
  sll x3, x1, x2
  li x4, 0x0000000080000000
  bne x3, x4, fail_sll_23

  li x1, 0xffffffffffffffff
  li x2, 0
  sll x3, x1, x2
  li x4, 0xffffffffffffffff
  bne x3, x4, fail_sll_25

  li x1, 0xffffffffffffffff
  li x2, 1
  sll x3, x1, x2
  li x4, 0xfffffffffffffffe
  bne x3, x4, fail_sll_26

  li x1, 0xffffffffffffffff
  li x2, 7
  sll x3, x1, x2
  li x4, 0xffffffffffffff80
  bne x3, x4, fail_sll_27

  li x1, 0xffffffffffffffff
  li x2, 14
  sll x3, x1, x2
  li x4, 0xffffffffffffc000
  bne x3, x4, fail_sll_28

  li x1, 0xffffffffffffffff
  li x2, 31
  sll x3, x1, x2
  li x4, 0xffffffff80000000
  bne x3, x4, fail_sll_29

  li x1, 0x0000000021212121
  li x2, 0
  sll x3, x1, x2
  li x4, 0x0000000021212121
  bne x3, x4, fail_sll_31

  li x1, 0x0000000021212121
  li x2, 1
  sll x3, x1, x2
  li x4, 0x0000000042424242
  bne x3, x4, fail_sll_32

  li x1, 0x0000000021212121
  li x2, 7
  sll x3, x1, x2
  li x4, 0x0000001090909080
  bne x3, x4, fail_sll_33

  li x1, 0x0000000021212121
  li x2, 14
  sll x3, x1, x2
  li x4, 0x0000084848484000
  bne x3, x4, fail_sll_34

  li x1, 0x0000000021212121
  li x2, 31
  sll x3, x1, x2
  li x4, 0x1090909080000000
  bne x3, x4, fail_sll_35

# Verify that shifts only use bottom six(rv64) or five(rv32) bits
  li x1, 0x0000000021212121
  li x2, 0xffffffffffffffc0
  sll x3, x1, x2
  li x4, 0x0000000021212121
  bne x3, x4, fail_sll_39

  li x1, 0x0000000021212121
  li x2, 0xffffffffffffffc1
  sll x3, x1, x2
  li x4, 0x0000000042424242
  bne x3, x4, fail_sll_40

  li x1, 0x0000000021212121
  li x2, 0xffffffffffffffc7
  sll x3, x1, x2
  li x4, 0x0000001090909080
  bne x3, x4, fail_sll_41

  li x1, 0x0000000021212121
  li x2, 0xffffffffffffffce
  sll x3, x1, x2
  li x4, 0x0000084848484000
  bne x3, x4, fail_sll_42

  li x1, 0x0000000021212121
  li x2, 0xffffffffffffffff
  sll x3, x1, x2
  li x4, 0x8000000000000000
  bne x3, x4, fail_sll_45

  li x1, 0x0000000000000001
  li x2, 63
  sll x3, x1, x2
  li x4, 0x8000000000000000
  bne x3, x4, fail_sll_46

  li x1, 0xffffffffffffffff
  li x2, 39
  sll x3, x1, x2
  li x4, 0xffffff8000000000
  bne x3, x4, fail_sll_47

  li x1, 0x0000000021212121
  li x2, 43
  sll x3, x1, x2
  li x4, 0x0909080000000000
  bne x3, x4, fail_sll_48

#-------------------------------------------------------------
# Source/Destination tests
#-------------------------------------------------------------
  li x1, 0x00000001
  li x2, 7
  sll x3, x1, x2
  li x4, 0x00000080
  bne x3, x4, fail_sll_55

  li x1, 0x00000001
  li x2, 14
  sll x3, x1, x2
  li x4, 0x00004000
  bne x3, x4, fail_sll_56

# Macro arg error in: TEST_RR_SRC12_EQ_DEST( 24, sll, 24, 3 )
#-------------------------------------------------------------
# Bypassing tests
#-------------------------------------------------------------
  li x1, 0x0000000000000080
  li x2, 0x0000000000000001
  0 x3, x1, x2
  li x4, sll
  bne x3, x4, fail_sll_63

  li x1, 0x0000000000004000
  li x2, 0x0000000000000001
  1 x3, x1, x2
  li x4, sll
  bne x3, x4, fail_sll_64

  li x1, 0x0000000080000000
  li x2, 0x0000000000000001
  2 x3, x1, x2
  li x4, sll
  bne x3, x4, fail_sll_65

  li x1, sll
  li x2, 0x0000000000000080
  0 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_sll_67

  li x1, sll
  li x2, 0x0000000000004000
  0 x3, x1, x2
  li x4, 1
  bne x3, x4, fail_sll_68

  li x1, sll
  li x2, 0x0000000080000000
  0 x3, x1, x2
  li x4, 2
  bne x3, x4, fail_sll_69

  li x1, sll
  li x2, 0x0000000000000080
  1 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_sll_70

  li x1, sll
  li x2, 0x0000000000004000
  1 x3, x1, x2
  li x4, 1
  bne x3, x4, fail_sll_71

  li x1, sll
  li x2, 0x0000000080000000
  2 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_sll_72

  li x1, sll
  li x2, 0x0000000000000080
  0 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_sll_74

  li x1, sll
  li x2, 0x0000000000004000
  0 x3, x1, x2
  li x4, 1
  bne x3, x4, fail_sll_75

  li x1, sll
  li x2, 0x0000000080000000
  0 x3, x1, x2
  li x4, 2
  bne x3, x4, fail_sll_76

  li x1, sll
  li x2, 0x0000000000000080
  1 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_sll_77

  li x1, sll
  li x2, 0x0000000000004000
  1 x3, x1, x2
  li x4, 1
  bne x3, x4, fail_sll_78

  li x1, sll
  li x2, 0x0000000080000000
  2 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_sll_79

# Macro arg error in: TEST_RR_ZEROSRC1( 40, sll, 0, 15 )
# Macro arg error in: TEST_RR_ZEROSRC2( 41, sll, 32, 32 )
# Macro arg error in: TEST_RR_ZEROSRC12( 42, sll, 0 )
# Macro arg error in: TEST_RR_ZERODEST( 43, sll, 1024, 2048 )
# Could not parse: TEST_PASSFAIL
.data
# Could not parse: TEST_DATA
  li x11, 1
  sw x11, 0(x10)
  addi x10, x10, 4
  j next_sll
fail_sll:
  li x11, 15
  sw x11, 0(x10)
  addi x10, x10, 4
next_sll:

# === SLLI ===
#-------------------------------------------------------------
# Arithmetic tests
#-------------------------------------------------------------
  li x1, 0x0000000000000001
  slli x3, x1, 0
  li x4, 0x0000000000000001
  bne x3, x4, fail_slli_19

  li x1, 0x0000000000000001
  slli x3, x1, 1
  li x4, 0x0000000000000002
  bne x3, x4, fail_slli_20

  li x1, 0x0000000000000001
  slli x3, x1, 7
  li x4, 0x0000000000000080
  bne x3, x4, fail_slli_21

  li x1, 0x0000000000000001
  slli x3, x1, 14
  li x4, 0x0000000000004000
  bne x3, x4, fail_slli_22

  li x1, 0x0000000000000001
  slli x3, x1, 31
  li x4, 0x0000000080000000
  bne x3, x4, fail_slli_23

  li x1, 0xffffffffffffffff
  slli x3, x1, 0
  li x4, 0xffffffffffffffff
  bne x3, x4, fail_slli_25

  li x1, 0xffffffffffffffff
  slli x3, x1, 1
  li x4, 0xfffffffffffffffe
  bne x3, x4, fail_slli_26

  li x1, 0xffffffffffffffff
  slli x3, x1, 7
  li x4, 0xffffffffffffff80
  bne x3, x4, fail_slli_27

  li x1, 0xffffffffffffffff
  slli x3, x1, 14
  li x4, 0xffffffffffffc000
  bne x3, x4, fail_slli_28

  li x1, 0xffffffffffffffff
  slli x3, x1, 31
  li x4, 0xffffffff80000000
  bne x3, x4, fail_slli_29

  li x1, 0x0000000021212121
  slli x3, x1, 0
  li x4, 0x0000000021212121
  bne x3, x4, fail_slli_31

  li x1, 0x0000000021212121
  slli x3, x1, 1
  li x4, 0x0000000042424242
  bne x3, x4, fail_slli_32

  li x1, 0x0000000021212121
  slli x3, x1, 7
  li x4, 0x0000001090909080
  bne x3, x4, fail_slli_33

  li x1, 0x0000000021212121
  slli x3, x1, 14
  li x4, 0x0000084848484000
  bne x3, x4, fail_slli_34

  li x1, 0x0000000021212121
  slli x3, x1, 31
  li x4, 0x1090909080000000
  bne x3, x4, fail_slli_35

  li x1, 0x0000000000000001
  slli x3, x1, 63
  li x4, 0x8000000000000000
  bne x3, x4, fail_slli_38

  li x1, 0xffffffffffffffff
  slli x3, x1, 39
  li x4, 0xffffff8000000000
  bne x3, x4, fail_slli_39

  li x1, 0x0000000021212121
  slli x3, x1, 43
  li x4, 0x0909080000000000
  bne x3, x4, fail_slli_40

#-------------------------------------------------------------
# Source/Destination tests
#-------------------------------------------------------------
  li x1, 0x00000001
  slli x3, x1, 7
  li x4, 0x00000080
  bne x3, x4, fail_slli_47

#-------------------------------------------------------------
# Bypassing tests
#-------------------------------------------------------------
  li x1, 0x0000000000000001
  slli x3, x1, 7
  li x4, 0x0000000000000080
  bne x3, x4, fail_slli_53

  li x1, 0x0000000000000001
  slli x3, x1, 14
  li x4, 0x0000000000004000
  bne x3, x4, fail_slli_54

  li x1, 0x0000000000000001
  slli x3, x1, 31
  li x4, 0x0000000080000000
  bne x3, x4, fail_slli_55

  li x1, 0x0000000000000001
  slli x3, x1, 7
  li x4, 0x0000000000000080
  bne x3, x4, fail_slli_57

  li x1, 0x0000000000000001
  slli x3, x1, 14
  li x4, 0x0000000000004000
  bne x3, x4, fail_slli_58

  li x1, 0x0000000000000001
  slli x3, x1, 31
  li x4, 0x0000000080000000
  bne x3, x4, fail_slli_59

# Macro arg error in: TEST_IMM_ZEROSRC1( 24, slli, 0, 31 )
# Macro arg error in: TEST_IMM_ZERODEST( 25, slli, 33, 20 )
# Could not parse: TEST_PASSFAIL
.data
# Could not parse: TEST_DATA
  li x11, 1
  sw x11, 0(x10)
  addi x10, x10, 4
  j next_slli
fail_slli:
  li x11, 15
  sw x11, 0(x10)
  addi x10, x10, 4
next_slli:

# === SLT ===
#-------------------------------------------------------------
# Arithmetic tests
#-------------------------------------------------------------
  li x1, 0x0000000000000000
  li x2, 0x0000000000000000
  slt x3, x1, x2
  li x4, 0
  bne x3, x4, fail_slt_19

  li x1, 0x0000000000000001
  li x2, 0x0000000000000001
  slt x3, x1, x2
  li x4, 0
  bne x3, x4, fail_slt_20

  li x1, 0x0000000000000003
  li x2, 0x0000000000000007
  slt x3, x1, x2
  li x4, 1
  bne x3, x4, fail_slt_21

  li x1, 0x0000000000000007
  li x2, 0x0000000000000003
  slt x3, x1, x2
  li x4, 0
  bne x3, x4, fail_slt_22

  li x1, 0x0000000000000000
  li x2, 0xffffffffffff8000
  slt x3, x1, x2
  li x4, 0
  bne x3, x4, fail_slt_24

  li x1, 0xffffffff80000000
  li x2, 0x0000000000000000
  slt x3, x1, x2
  li x4, 1
  bne x3, x4, fail_slt_25

  li x1, 0xffffffff80000000
  li x2, 0xffffffffffff8000
  slt x3, x1, x2
  li x4, 1
  bne x3, x4, fail_slt_26

  li x1, 0x0000000000000000
  li x2, 0x0000000000007fff
  slt x3, x1, x2
  li x4, 1
  bne x3, x4, fail_slt_28

  li x1, 0x000000007fffffff
  li x2, 0x0000000000000000
  slt x3, x1, x2
  li x4, 0
  bne x3, x4, fail_slt_29

  li x1, 0x000000007fffffff
  li x2, 0x0000000000007fff
  slt x3, x1, x2
  li x4, 0
  bne x3, x4, fail_slt_30

  li x1, 0xffffffff80000000
  li x2, 0x0000000000007fff
  slt x3, x1, x2
  li x4, 1
  bne x3, x4, fail_slt_32

  li x1, 0x000000007fffffff
  li x2, 0xffffffffffff8000
  slt x3, x1, x2
  li x4, 0
  bne x3, x4, fail_slt_33

  li x1, 0x0000000000000000
  li x2, 0xffffffffffffffff
  slt x3, x1, x2
  li x4, 0
  bne x3, x4, fail_slt_35

  li x1, 0xffffffffffffffff
  li x2, 0x0000000000000001
  slt x3, x1, x2
  li x4, 1
  bne x3, x4, fail_slt_36

  li x1, 0xffffffffffffffff
  li x2, 0xffffffffffffffff
  slt x3, x1, x2
  li x4, 0
  bne x3, x4, fail_slt_37

#-------------------------------------------------------------
# Source/Destination tests
#-------------------------------------------------------------
  li x1, 14
  li x2, 13
  slt x3, x1, x2
  li x4, 0
  bne x3, x4, fail_slt_43

  li x1, 11
  li x2, 13
  slt x3, x1, x2
  li x4, 1
  bne x3, x4, fail_slt_44

# Macro arg error in: TEST_RR_SRC12_EQ_DEST( 19, slt, 0, 13 )
#-------------------------------------------------------------
# Bypassing tests
#-------------------------------------------------------------
  li x1, 1
  li x2, 11
  0 x3, x1, x2
  li x4, slt
  bne x3, x4, fail_slt_51

  li x1, 0
  li x2, 14
  1 x3, x1, x2
  li x4, slt
  bne x3, x4, fail_slt_52

  li x1, 1
  li x2, 12
  2 x3, x1, x2
  li x4, slt
  bne x3, x4, fail_slt_53

  li x1, slt
  li x2, 0
  0 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_slt_55

  li x1, slt
  li x2, 1
  0 x3, x1, x2
  li x4, 1
  bne x3, x4, fail_slt_56

  li x1, slt
  li x2, 0
  0 x3, x1, x2
  li x4, 2
  bne x3, x4, fail_slt_57

  li x1, slt
  li x2, 1
  1 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_slt_58

  li x1, slt
  li x2, 0
  1 x3, x1, x2
  li x4, 1
  bne x3, x4, fail_slt_59

  li x1, slt
  li x2, 1
  2 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_slt_60

  li x1, slt
  li x2, 0
  0 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_slt_62

  li x1, slt
  li x2, 1
  0 x3, x1, x2
  li x4, 1
  bne x3, x4, fail_slt_63

  li x1, slt
  li x2, 0
  0 x3, x1, x2
  li x4, 2
  bne x3, x4, fail_slt_64

  li x1, slt
  li x2, 1
  1 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_slt_65

  li x1, slt
  li x2, 0
  1 x3, x1, x2
  li x4, 1
  bne x3, x4, fail_slt_66

  li x1, slt
  li x2, 1
  2 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_slt_67

# Macro arg error in: TEST_RR_ZEROSRC1( 35, slt, 0, -1 )
# Macro arg error in: TEST_RR_ZEROSRC2( 36, slt, 1, -1 )
# Macro arg error in: TEST_RR_ZEROSRC12( 37, slt, 0 )
# Macro arg error in: TEST_RR_ZERODEST( 38, slt, 16, 30 )
# Could not parse: TEST_PASSFAIL
.data
# Could not parse: TEST_DATA
  li x11, 1
  sw x11, 0(x10)
  addi x10, x10, 4
  j next_slt
fail_slt:
  li x11, 15
  sw x11, 0(x10)
  addi x10, x10, 4
next_slt:

# === SLTI ===
#-------------------------------------------------------------
# Arithmetic tests
#-------------------------------------------------------------
  li x1, 0x0000000000000000
  slti x3, x1, 0x000
  li x4, 0
  bne x3, x4, fail_slti_19

  li x1, 0x0000000000000001
  slti x3, x1, 0x001
  li x4, 0
  bne x3, x4, fail_slti_20

  li x1, 0x0000000000000003
  slti x3, x1, 0x007
  li x4, 1
  bne x3, x4, fail_slti_21

  li x1, 0x0000000000000007
  slti x3, x1, 0x003
  li x4, 0
  bne x3, x4, fail_slti_22

  li x1, 0x0000000000000000
  slti x3, x1, 0x800
  li x4, 0
  bne x3, x4, fail_slti_24

  li x1, 0xffffffff80000000
  slti x3, x1, 0x000
  li x4, 1
  bne x3, x4, fail_slti_25

  li x1, 0xffffffff80000000
  slti x3, x1, 0x800
  li x4, 1
  bne x3, x4, fail_slti_26

  li x1, 0x0000000000000000
  slti x3, x1, 0x7ff
  li x4, 1
  bne x3, x4, fail_slti_28

  li x1, 0x000000007fffffff
  slti x3, x1, 0x000
  li x4, 0
  bne x3, x4, fail_slti_29

  li x1, 0x000000007fffffff
  slti x3, x1, 0x7ff
  li x4, 0
  bne x3, x4, fail_slti_30

  li x1, 0xffffffff80000000
  slti x3, x1, 0x7ff
  li x4, 1
  bne x3, x4, fail_slti_32

  li x1, 0x000000007fffffff
  slti x3, x1, 0x800
  li x4, 0
  bne x3, x4, fail_slti_33

  li x1, 0x0000000000000000
  slti x3, x1, 0xfff
  li x4, 0
  bne x3, x4, fail_slti_35

  li x1, 0xffffffffffffffff
  slti x3, x1, 0x001
  li x4, 1
  bne x3, x4, fail_slti_36

  li x1, 0xffffffffffffffff
  slti x3, x1, 0xfff
  li x4, 0
  bne x3, x4, fail_slti_37

#-------------------------------------------------------------
# Source/Destination tests
#-------------------------------------------------------------
  li x1, 11
  slti x3, x1, 13
  li x4, 1
  bne x3, x4, fail_slti_43

#-------------------------------------------------------------
# Bypassing tests
#-------------------------------------------------------------
  li x1, 15
  slti x3, x1, 10
  li x4, 0
  bne x3, x4, fail_slti_49

  li x1, 10
  slti x3, x1, 16
  li x4, 1
  bne x3, x4, fail_slti_50

  li x1, 16
  slti x3, x1, 9
  li x4, 0
  bne x3, x4, fail_slti_51

  li x1, 11
  slti x3, x1, 15
  li x4, 1
  bne x3, x4, fail_slti_53

  li x1, 17
  slti x3, x1, 8
  li x4, 0
  bne x3, x4, fail_slti_54

  li x1, 12
  slti x3, x1, 14
  li x4, 1
  bne x3, x4, fail_slti_55

# Macro arg error in: TEST_IMM_ZEROSRC1( 24, slti, 0, 0xfff )
# Macro arg error in: TEST_IMM_ZERODEST( 25, slti, 0x00ff00ff, 0xfff )
# Could not parse: TEST_PASSFAIL
.data
# Could not parse: TEST_DATA
  li x11, 1
  sw x11, 0(x10)
  addi x10, x10, 4
  j next_slti
fail_slti:
  li x11, 15
  sw x11, 0(x10)
  addi x10, x10, 4
next_slti:

# === SLTIU ===
#-------------------------------------------------------------
# Arithmetic tests
#-------------------------------------------------------------
  li x1, 0x0000000000000000
  sltiu x3, x1, 0x000
  li x4, 0
  bne x3, x4, fail_sltiu_19

  li x1, 0x0000000000000001
  sltiu x3, x1, 0x001
  li x4, 0
  bne x3, x4, fail_sltiu_20

  li x1, 0x0000000000000003
  sltiu x3, x1, 0x007
  li x4, 1
  bne x3, x4, fail_sltiu_21

  li x1, 0x0000000000000007
  sltiu x3, x1, 0x003
  li x4, 0
  bne x3, x4, fail_sltiu_22

  li x1, 0x0000000000000000
  sltiu x3, x1, 0x800
  li x4, 1
  bne x3, x4, fail_sltiu_24

  li x1, 0xffffffff80000000
  sltiu x3, x1, 0x000
  li x4, 0
  bne x3, x4, fail_sltiu_25

  li x1, 0xffffffff80000000
  sltiu x3, x1, 0x800
  li x4, 1
  bne x3, x4, fail_sltiu_26

  li x1, 0x0000000000000000
  sltiu x3, x1, 0x7ff
  li x4, 1
  bne x3, x4, fail_sltiu_28

  li x1, 0x000000007fffffff
  sltiu x3, x1, 0x000
  li x4, 0
  bne x3, x4, fail_sltiu_29

  li x1, 0x000000007fffffff
  sltiu x3, x1, 0x7ff
  li x4, 0
  bne x3, x4, fail_sltiu_30

  li x1, 0xffffffff80000000
  sltiu x3, x1, 0x7ff
  li x4, 0
  bne x3, x4, fail_sltiu_32

  li x1, 0x000000007fffffff
  sltiu x3, x1, 0x800
  li x4, 1
  bne x3, x4, fail_sltiu_33

  li x1, 0x0000000000000000
  sltiu x3, x1, 0xfff
  li x4, 1
  bne x3, x4, fail_sltiu_35

  li x1, 0xffffffffffffffff
  sltiu x3, x1, 0x001
  li x4, 0
  bne x3, x4, fail_sltiu_36

  li x1, 0xffffffffffffffff
  sltiu x3, x1, 0xfff
  li x4, 0
  bne x3, x4, fail_sltiu_37

#-------------------------------------------------------------
# Source/Destination tests
#-------------------------------------------------------------
  li x1, 11
  sltiu x3, x1, 13
  li x4, 1
  bne x3, x4, fail_sltiu_43

#-------------------------------------------------------------
# Bypassing tests
#-------------------------------------------------------------
  li x1, 15
  sltiu x3, x1, 10
  li x4, 0
  bne x3, x4, fail_sltiu_49

  li x1, 10
  sltiu x3, x1, 16
  li x4, 1
  bne x3, x4, fail_sltiu_50

  li x1, 16
  sltiu x3, x1, 9
  li x4, 0
  bne x3, x4, fail_sltiu_51

  li x1, 11
  sltiu x3, x1, 15
  li x4, 1
  bne x3, x4, fail_sltiu_53

  li x1, 17
  sltiu x3, x1, 8
  li x4, 0
  bne x3, x4, fail_sltiu_54

  li x1, 12
  sltiu x3, x1, 14
  li x4, 1
  bne x3, x4, fail_sltiu_55

# Macro arg error in: TEST_IMM_ZEROSRC1( 24, sltiu, 1, 0xfff )
# Macro arg error in: TEST_IMM_ZERODEST( 25, sltiu, 0x00ff00ff, 0xfff )
# Could not parse: TEST_PASSFAIL
.data
# Could not parse: TEST_DATA
  li x11, 1
  sw x11, 0(x10)
  addi x10, x10, 4
  j next_sltiu
fail_sltiu:
  li x11, 15
  sw x11, 0(x10)
  addi x10, x10, 4
next_sltiu:

# === SLTU ===
#-------------------------------------------------------------
# Arithmetic tests
#-------------------------------------------------------------
  li x1, 0x00000000
  li x2, 0x00000000
  sltu x3, x1, x2
  li x4, 0
  bne x3, x4, fail_sltu_19

  li x1, 0x00000001
  li x2, 0x00000001
  sltu x3, x1, x2
  li x4, 0
  bne x3, x4, fail_sltu_20

  li x1, 0x00000003
  li x2, 0x00000007
  sltu x3, x1, x2
  li x4, 1
  bne x3, x4, fail_sltu_21

  li x1, 0x00000007
  li x2, 0x00000003
  sltu x3, x1, x2
  li x4, 0
  bne x3, x4, fail_sltu_22

  li x1, 0x00000000
  li x2, 0xffff8000
  sltu x3, x1, x2
  li x4, 1
  bne x3, x4, fail_sltu_24

  li x1, 0x80000000
  li x2, 0x00000000
  sltu x3, x1, x2
  li x4, 0
  bne x3, x4, fail_sltu_25

  li x1, 0x80000000
  li x2, 0xffff8000
  sltu x3, x1, x2
  li x4, 1
  bne x3, x4, fail_sltu_26

  li x1, 0x00000000
  li x2, 0x00007fff
  sltu x3, x1, x2
  li x4, 1
  bne x3, x4, fail_sltu_28

  li x1, 0x7fffffff
  li x2, 0x00000000
  sltu x3, x1, x2
  li x4, 0
  bne x3, x4, fail_sltu_29

  li x1, 0x7fffffff
  li x2, 0x00007fff
  sltu x3, x1, x2
  li x4, 0
  bne x3, x4, fail_sltu_30

  li x1, 0x80000000
  li x2, 0x00007fff
  sltu x3, x1, x2
  li x4, 0
  bne x3, x4, fail_sltu_32

  li x1, 0x7fffffff
  li x2, 0xffff8000
  sltu x3, x1, x2
  li x4, 1
  bne x3, x4, fail_sltu_33

  li x1, 0x00000000
  li x2, 0xffffffff
  sltu x3, x1, x2
  li x4, 1
  bne x3, x4, fail_sltu_35

  li x1, 0xffffffff
  li x2, 0x00000001
  sltu x3, x1, x2
  li x4, 0
  bne x3, x4, fail_sltu_36

  li x1, 0xffffffff
  li x2, 0xffffffff
  sltu x3, x1, x2
  li x4, 0
  bne x3, x4, fail_sltu_37

#-------------------------------------------------------------
# Source/Destination tests
#-------------------------------------------------------------
  li x1, 14
  li x2, 13
  sltu x3, x1, x2
  li x4, 0
  bne x3, x4, fail_sltu_43

  li x1, 11
  li x2, 13
  sltu x3, x1, x2
  li x4, 1
  bne x3, x4, fail_sltu_44

# Macro arg error in: TEST_RR_SRC12_EQ_DEST( 19, sltu, 0, 13 )
#-------------------------------------------------------------
# Bypassing tests
#-------------------------------------------------------------
  li x1, 1
  li x2, 11
  0 x3, x1, x2
  li x4, sltu
  bne x3, x4, fail_sltu_51

  li x1, 0
  li x2, 14
  1 x3, x1, x2
  li x4, sltu
  bne x3, x4, fail_sltu_52

  li x1, 1
  li x2, 12
  2 x3, x1, x2
  li x4, sltu
  bne x3, x4, fail_sltu_53

  li x1, sltu
  li x2, 0
  0 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_sltu_55

  li x1, sltu
  li x2, 1
  0 x3, x1, x2
  li x4, 1
  bne x3, x4, fail_sltu_56

  li x1, sltu
  li x2, 0
  0 x3, x1, x2
  li x4, 2
  bne x3, x4, fail_sltu_57

  li x1, sltu
  li x2, 1
  1 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_sltu_58

  li x1, sltu
  li x2, 0
  1 x3, x1, x2
  li x4, 1
  bne x3, x4, fail_sltu_59

  li x1, sltu
  li x2, 1
  2 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_sltu_60

  li x1, sltu
  li x2, 0
  0 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_sltu_62

  li x1, sltu
  li x2, 1
  0 x3, x1, x2
  li x4, 1
  bne x3, x4, fail_sltu_63

  li x1, sltu
  li x2, 0
  0 x3, x1, x2
  li x4, 2
  bne x3, x4, fail_sltu_64

  li x1, sltu
  li x2, 1
  1 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_sltu_65

  li x1, sltu
  li x2, 0
  1 x3, x1, x2
  li x4, 1
  bne x3, x4, fail_sltu_66

  li x1, sltu
  li x2, 1
  2 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_sltu_67

# Macro arg error in: TEST_RR_ZEROSRC1( 35, sltu, 1, -1 )
# Macro arg error in: TEST_RR_ZEROSRC2( 36, sltu, 0, -1 )
# Macro arg error in: TEST_RR_ZEROSRC12( 37, sltu, 0 )
# Macro arg error in: TEST_RR_ZERODEST( 38, sltu, 16, 30 )
# Could not parse: TEST_PASSFAIL
.data
# Could not parse: TEST_DATA
  li x11, 1
  sw x11, 0(x10)
  addi x10, x10, 4
  j next_sltu
fail_sltu:
  li x11, 15
  sw x11, 0(x10)
  addi x10, x10, 4
next_sltu:

# === SRA ===
#-------------------------------------------------------------
# Arithmetic tests
#-------------------------------------------------------------
  li x1, 0xffffffff80000000
  li x2, 0
  sra x3, x1, x2
  li x4, 0xffffffff80000000
  bne x3, x4, fail_sra_19

  li x1, 0xffffffff80000000
  li x2, 1
  sra x3, x1, x2
  li x4, 0xffffffffc0000000
  bne x3, x4, fail_sra_20

  li x1, 0xffffffff80000000
  li x2, 7
  sra x3, x1, x2
  li x4, 0xffffffffff000000
  bne x3, x4, fail_sra_21

  li x1, 0xffffffff80000000
  li x2, 14
  sra x3, x1, x2
  li x4, 0xfffffffffffe0000
  bne x3, x4, fail_sra_22

  li x1, 0xffffffff80000001
  li x2, 31
  sra x3, x1, x2
  li x4, 0xffffffffffffffff
  bne x3, x4, fail_sra_23

  li x1, 0x000000007fffffff
  li x2, 0
  sra x3, x1, x2
  li x4, 0x000000007fffffff
  bne x3, x4, fail_sra_25

  li x1, 0x000000007fffffff
  li x2, 1
  sra x3, x1, x2
  li x4, 0x000000003fffffff
  bne x3, x4, fail_sra_26

  li x1, 0x000000007fffffff
  li x2, 7
  sra x3, x1, x2
  li x4, 0x0000000000ffffff
  bne x3, x4, fail_sra_27

  li x1, 0x000000007fffffff
  li x2, 14
  sra x3, x1, x2
  li x4, 0x000000000001ffff
  bne x3, x4, fail_sra_28

  li x1, 0x000000007fffffff
  li x2, 31
  sra x3, x1, x2
  li x4, 0x0000000000000000
  bne x3, x4, fail_sra_29

  li x1, 0xffffffff81818181
  li x2, 0
  sra x3, x1, x2
  li x4, 0xffffffff81818181
  bne x3, x4, fail_sra_31

  li x1, 0xffffffff81818181
  li x2, 1
  sra x3, x1, x2
  li x4, 0xffffffffc0c0c0c0
  bne x3, x4, fail_sra_32

  li x1, 0xffffffff81818181
  li x2, 7
  sra x3, x1, x2
  li x4, 0xffffffffff030303
  bne x3, x4, fail_sra_33

  li x1, 0xffffffff81818181
  li x2, 14
  sra x3, x1, x2
  li x4, 0xfffffffffffe0606
  bne x3, x4, fail_sra_34

  li x1, 0xffffffff81818181
  li x2, 31
  sra x3, x1, x2
  li x4, 0xffffffffffffffff
  bne x3, x4, fail_sra_35

# Verify that shifts only use bottom six(rv64) or five(rv32) bits
  li x1, 0xffffffff81818181
  li x2, 0xffffffffffffffc0
  sra x3, x1, x2
  li x4, 0xffffffff81818181
  bne x3, x4, fail_sra_39

  li x1, 0xffffffff81818181
  li x2, 0xffffffffffffffc1
  sra x3, x1, x2
  li x4, 0xffffffffc0c0c0c0
  bne x3, x4, fail_sra_40

  li x1, 0xffffffff81818181
  li x2, 0xffffffffffffffc7
  sra x3, x1, x2
  li x4, 0xffffffffff030303
  bne x3, x4, fail_sra_41

  li x1, 0xffffffff81818181
  li x2, 0xffffffffffffffce
  sra x3, x1, x2
  li x4, 0xfffffffffffe0606
  bne x3, x4, fail_sra_42

  li x1, 0xffffffff81818181
  li x2, 0xffffffffffffffff
  sra x3, x1, x2
  li x4, 0xffffffffffffffff
  bne x3, x4, fail_sra_43

#-------------------------------------------------------------
# Source/Destination tests
#-------------------------------------------------------------
  li x1, 0xffffffff80000000
  li x2, 7
  sra x3, x1, x2
  li x4, 0xffffffffff000000
  bne x3, x4, fail_sra_49

  li x1, 0xffffffff80000000
  li x2, 14
  sra x3, x1, x2
  li x4, 0xfffffffffffe0000
  bne x3, x4, fail_sra_50

# Macro arg error in: TEST_RR_SRC12_EQ_DEST( 24, sra, 0, 7 )
#-------------------------------------------------------------
# Bypassing tests
#-------------------------------------------------------------
  li x1, 0xffffffffff000000
  li x2, 0xffffffff80000000
  0 x3, x1, x2
  li x4, sra
  bne x3, x4, fail_sra_57

  li x1, 0xfffffffffffe0000
  li x2, 0xffffffff80000000
  1 x3, x1, x2
  li x4, sra
  bne x3, x4, fail_sra_58

  li x1, 0xffffffffffffffff
  li x2, 0xffffffff80000000
  2 x3, x1, x2
  li x4, sra
  bne x3, x4, fail_sra_59

  li x1, sra
  li x2, 0xffffffffff000000
  0 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_sra_61

  li x1, sra
  li x2, 0xfffffffffffe0000
  0 x3, x1, x2
  li x4, 1
  bne x3, x4, fail_sra_62

  li x1, sra
  li x2, 0xffffffffffffffff
  0 x3, x1, x2
  li x4, 2
  bne x3, x4, fail_sra_63

  li x1, sra
  li x2, 0xffffffffff000000
  1 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_sra_64

  li x1, sra
  li x2, 0xfffffffffffe0000
  1 x3, x1, x2
  li x4, 1
  bne x3, x4, fail_sra_65

  li x1, sra
  li x2, 0xffffffffffffffff
  2 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_sra_66

  li x1, sra
  li x2, 0xffffffffff000000
  0 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_sra_68

  li x1, sra
  li x2, 0xfffffffffffe0000
  0 x3, x1, x2
  li x4, 1
  bne x3, x4, fail_sra_69

  li x1, sra
  li x2, 0xffffffffffffffff
  0 x3, x1, x2
  li x4, 2
  bne x3, x4, fail_sra_70

  li x1, sra
  li x2, 0xffffffffff000000
  1 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_sra_71

  li x1, sra
  li x2, 0xfffffffffffe0000
  1 x3, x1, x2
  li x4, 1
  bne x3, x4, fail_sra_72

  li x1, sra
  li x2, 0xffffffffffffffff
  2 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_sra_73

# Macro arg error in: TEST_RR_ZEROSRC1( 40, sra, 0, 15 )
# Macro arg error in: TEST_RR_ZEROSRC2( 41, sra, 32, 32 )
# Macro arg error in: TEST_RR_ZEROSRC12( 42, sra, 0 )
# Macro arg error in: TEST_RR_ZERODEST( 43, sra, 1024, 2048 )
# Could not parse: TEST_PASSFAIL
.data
# Could not parse: TEST_DATA
  li x11, 1
  sw x11, 0(x10)
  addi x10, x10, 4
  j next_sra
fail_sra:
  li x11, 15
  sw x11, 0(x10)
  addi x10, x10, 4
next_sra:

# === SRAI ===
#-------------------------------------------------------------
# Arithmetic tests
#-------------------------------------------------------------
  li x1, 0xffffff8000000000
  srai x3, x1, 0
  li x4, 0xffffff8000000000
  bne x3, x4, fail_srai_19

  li x1, 0xffffffff80000000
  srai x3, x1, 1
  li x4, 0xffffffffc0000000
  bne x3, x4, fail_srai_20

  li x1, 0xffffffff80000000
  srai x3, x1, 7
  li x4, 0xffffffffff000000
  bne x3, x4, fail_srai_21

  li x1, 0xffffffff80000000
  srai x3, x1, 14
  li x4, 0xfffffffffffe0000
  bne x3, x4, fail_srai_22

  li x1, 0xffffffff80000001
  srai x3, x1, 31
  li x4, 0xffffffffffffffff
  bne x3, x4, fail_srai_23

  li x1, 0x000000007fffffff
  srai x3, x1, 0
  li x4, 0x000000007fffffff
  bne x3, x4, fail_srai_25

  li x1, 0x000000007fffffff
  srai x3, x1, 1
  li x4, 0x000000003fffffff
  bne x3, x4, fail_srai_26

  li x1, 0x000000007fffffff
  srai x3, x1, 7
  li x4, 0x0000000000ffffff
  bne x3, x4, fail_srai_27

  li x1, 0x000000007fffffff
  srai x3, x1, 14
  li x4, 0x000000000001ffff
  bne x3, x4, fail_srai_28

  li x1, 0x000000007fffffff
  srai x3, x1, 31
  li x4, 0x0000000000000000
  bne x3, x4, fail_srai_29

  li x1, 0xffffffff81818181
  srai x3, x1, 0
  li x4, 0xffffffff81818181
  bne x3, x4, fail_srai_31

  li x1, 0xffffffff81818181
  srai x3, x1, 1
  li x4, 0xffffffffc0c0c0c0
  bne x3, x4, fail_srai_32

  li x1, 0xffffffff81818181
  srai x3, x1, 7
  li x4, 0xffffffffff030303
  bne x3, x4, fail_srai_33

  li x1, 0xffffffff81818181
  srai x3, x1, 14
  li x4, 0xfffffffffffe0606
  bne x3, x4, fail_srai_34

  li x1, 0xffffffff81818181
  srai x3, x1, 31
  li x4, 0xffffffffffffffff
  bne x3, x4, fail_srai_35

#-------------------------------------------------------------
# Source/Destination tests
#-------------------------------------------------------------
  li x1, 0xffffffff80000000
  srai x3, x1, 7
  li x4, 0xffffffffff000000
  bne x3, x4, fail_srai_41

#-------------------------------------------------------------
# Bypassing tests
#-------------------------------------------------------------
  li x1, 0xffffffff80000000
  srai x3, x1, 7
  li x4, 0xffffffffff000000
  bne x3, x4, fail_srai_47

  li x1, 0xffffffff80000000
  srai x3, x1, 14
  li x4, 0xfffffffffffe0000
  bne x3, x4, fail_srai_48

  li x1, 0xffffffff80000001
  srai x3, x1, 31
  li x4, 0xffffffffffffffff
  bne x3, x4, fail_srai_49

  li x1, 0xffffffff80000000
  srai x3, x1, 7
  li x4, 0xffffffffff000000
  bne x3, x4, fail_srai_51

  li x1, 0xffffffff80000000
  srai x3, x1, 14
  li x4, 0xfffffffffffe0000
  bne x3, x4, fail_srai_52

  li x1, 0xffffffff80000001
  srai x3, x1, 31
  li x4, 0xffffffffffffffff
  bne x3, x4, fail_srai_53

# Macro arg error in: TEST_IMM_ZEROSRC1( 24, srai, 0, 4 )
# Macro arg error in: TEST_IMM_ZERODEST( 25, srai, 33, 10 )
# Could not parse: TEST_PASSFAIL
.data
# Could not parse: TEST_DATA
  li x11, 1
  sw x11, 0(x10)
  addi x10, x10, 4
  j next_srai
fail_srai:
  li x11, 15
  sw x11, 0(x10)
  addi x10, x10, 4
next_srai:

# === SRL ===
#-------------------------------------------------------------
# Arithmetic tests
#-------------------------------------------------------------
  li x1, v
  li x2, a
  srl x3, x1, x2
  li x4, ((v) & ((1 << (__riscv_xlen-1) << 1) - 1)) >> (a)
  bne x3, x4, fail_srl_20

# Unsupported macro type: TEST_SRL( 2,  0xffffffff80000000, 0  )
# Unsupported macro type: TEST_SRL( 3,  0xffffffff80000000, 1  )
# Unsupported macro type: TEST_SRL( 4,  0xffffffff80000000, 7  )
# Unsupported macro type: TEST_SRL( 5,  0xffffffff80000000, 14 )
# Unsupported macro type: TEST_SRL( 6,  0xffffffff80000001, 31 )
# Unsupported macro type: TEST_SRL( 7,  0xffffffffffffffff, 0  )
# Unsupported macro type: TEST_SRL( 8,  0xffffffffffffffff, 1  )
# Unsupported macro type: TEST_SRL( 9,  0xffffffffffffffff, 7  )
# Unsupported macro type: TEST_SRL( 10, 0xffffffffffffffff, 14 )
# Unsupported macro type: TEST_SRL( 11, 0xffffffffffffffff, 31 )
# Unsupported macro type: TEST_SRL( 12, 0x0000000021212121, 0  )
# Unsupported macro type: TEST_SRL( 13, 0x0000000021212121, 1  )
# Unsupported macro type: TEST_SRL( 14, 0x0000000021212121, 7  )
# Unsupported macro type: TEST_SRL( 15, 0x0000000021212121, 14 )
# Unsupported macro type: TEST_SRL( 16, 0x0000000021212121, 31 )
# Verify that shifts only use bottom six(rv64) or five(rv32) bits
  li x1, 0x0000000021212121
  li x2, 0xffffffffffffffc0
  srl x3, x1, x2
  li x4, 0x0000000021212121
  bne x3, x4, fail_srl_42

  li x1, 0x0000000021212121
  li x2, 0xffffffffffffffc1
  srl x3, x1, x2
  li x4, 0x0000000010909090
  bne x3, x4, fail_srl_43

  li x1, 0x0000000021212121
  li x2, 0xffffffffffffffc7
  srl x3, x1, x2
  li x4, 0x0000000000424242
  bne x3, x4, fail_srl_44

  li x1, 0x0000000021212121
  li x2, 0xffffffffffffffce
  srl x3, x1, x2
  li x4, 0x0000000000008484
  bne x3, x4, fail_srl_45

  li x1, 0x0000000021212121
  li x2, 0xffffffffffffffff
  srl x3, x1, x2
  li x4, 0x0000000000000000
  bne x3, x4, fail_srl_46

#-------------------------------------------------------------
# Source/Destination tests
#-------------------------------------------------------------
  li x1, 0x80000000
  li x2, 7
  srl x3, x1, x2
  li x4, 0x01000000
  bne x3, x4, fail_srl_52

  li x1, 0x80000000
  li x2, 14
  srl x3, x1, x2
  li x4, 0x00020000
  bne x3, x4, fail_srl_53

# Macro arg error in: TEST_RR_SRC12_EQ_DEST( 24, srl, 0, 7 )
#-------------------------------------------------------------
# Bypassing tests
#-------------------------------------------------------------
  li x1, 0x01000000
  li x2, 0x80000000
  0 x3, x1, x2
  li x4, srl
  bne x3, x4, fail_srl_60

  li x1, 0x00020000
  li x2, 0x80000000
  1 x3, x1, x2
  li x4, srl
  bne x3, x4, fail_srl_61

  li x1, 0x00000001
  li x2, 0x80000000
  2 x3, x1, x2
  li x4, srl
  bne x3, x4, fail_srl_62

  li x1, srl
  li x2, 0x01000000
  0 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_srl_64

  li x1, srl
  li x2, 0x00020000
  0 x3, x1, x2
  li x4, 1
  bne x3, x4, fail_srl_65

  li x1, srl
  li x2, 0x00000001
  0 x3, x1, x2
  li x4, 2
  bne x3, x4, fail_srl_66

  li x1, srl
  li x2, 0x01000000
  1 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_srl_67

  li x1, srl
  li x2, 0x00020000
  1 x3, x1, x2
  li x4, 1
  bne x3, x4, fail_srl_68

  li x1, srl
  li x2, 0x00000001
  2 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_srl_69

  li x1, srl
  li x2, 0x01000000
  0 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_srl_71

  li x1, srl
  li x2, 0x00020000
  0 x3, x1, x2
  li x4, 1
  bne x3, x4, fail_srl_72

  li x1, srl
  li x2, 0x00000001
  0 x3, x1, x2
  li x4, 2
  bne x3, x4, fail_srl_73

  li x1, srl
  li x2, 0x01000000
  1 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_srl_74

  li x1, srl
  li x2, 0x00020000
  1 x3, x1, x2
  li x4, 1
  bne x3, x4, fail_srl_75

  li x1, srl
  li x2, 0x00000001
  2 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_srl_76

# Macro arg error in: TEST_RR_ZEROSRC1( 40, srl, 0, 15 )
# Macro arg error in: TEST_RR_ZEROSRC2( 41, srl, 32, 32 )
# Macro arg error in: TEST_RR_ZEROSRC12( 42, srl, 0 )
# Macro arg error in: TEST_RR_ZERODEST( 43, srl, 1024, 2048 )
# Could not parse: TEST_PASSFAIL
.data
# Could not parse: TEST_DATA
  li x11, 1
  sw x11, 0(x10)
  addi x10, x10, 4
  j next_srl
fail_srl:
  li x11, 15
  sw x11, 0(x10)
  addi x10, x10, 4
next_srl:

# === SRLI ===
#-------------------------------------------------------------
# Arithmetic tests
#-------------------------------------------------------------
  li x1, v
  srli x3, x1, a
  li x4, ((v) & ((1 << (__riscv_xlen-1) << 1) - 1)) >> (a)
  bne x3, x4, fail_srli_20

# Unsupported macro type: TEST_SRLI( 2,  0xffffffff80000000, 0  )
# Unsupported macro type: TEST_SRLI( 3,  0xffffffff80000000, 1  )
# Unsupported macro type: TEST_SRLI( 4,  0xffffffff80000000, 7  )
# Unsupported macro type: TEST_SRLI( 5,  0xffffffff80000000, 14 )
# Unsupported macro type: TEST_SRLI( 6,  0xffffffff80000001, 31 )
# Unsupported macro type: TEST_SRLI( 7,  0xffffffffffffffff, 0  )
# Unsupported macro type: TEST_SRLI( 8,  0xffffffffffffffff, 1  )
# Unsupported macro type: TEST_SRLI( 9,  0xffffffffffffffff, 7  )
# Unsupported macro type: TEST_SRLI( 10, 0xffffffffffffffff, 14 )
# Unsupported macro type: TEST_SRLI( 11, 0xffffffffffffffff, 31 )
# Unsupported macro type: TEST_SRLI( 12, 0x0000000021212121, 0  )
# Unsupported macro type: TEST_SRLI( 13, 0x0000000021212121, 1  )
# Unsupported macro type: TEST_SRLI( 14, 0x0000000021212121, 7  )
# Unsupported macro type: TEST_SRLI( 15, 0x0000000021212121, 14 )
# Unsupported macro type: TEST_SRLI( 16, 0x0000000021212121, 31 )
#-------------------------------------------------------------
# Source/Destination tests
#-------------------------------------------------------------
  li x1, 0x80000000
  srli x3, x1, 7
  li x4, 0x01000000
  bne x3, x4, fail_srli_44

#-------------------------------------------------------------
# Bypassing tests
#-------------------------------------------------------------
  li x1, 0x80000000
  srli x3, x1, 7
  li x4, 0x01000000
  bne x3, x4, fail_srli_50

  li x1, 0x80000000
  srli x3, x1, 14
  li x4, 0x00020000
  bne x3, x4, fail_srli_51

  li x1, 0x80000001
  srli x3, x1, 31
  li x4, 0x00000001
  bne x3, x4, fail_srli_52

  li x1, 0x80000000
  srli x3, x1, 7
  li x4, 0x01000000
  bne x3, x4, fail_srli_54

  li x1, 0x80000000
  srli x3, x1, 14
  li x4, 0x00020000
  bne x3, x4, fail_srli_55

  li x1, 0x80000001
  srli x3, x1, 31
  li x4, 0x00000001
  bne x3, x4, fail_srli_56

# Macro arg error in: TEST_IMM_ZEROSRC1( 24, srli, 0, 4 )
# Macro arg error in: TEST_IMM_ZERODEST( 25, srli, 33, 10 )
# Could not parse: TEST_PASSFAIL
.data
# Could not parse: TEST_DATA
  li x11, 1
  sw x11, 0(x10)
  addi x10, x10, 4
  j next_srli
fail_srli:
  li x11, 15
  sw x11, 0(x10)
  addi x10, x10, 4
next_srli:

# === ST_LD ===
#-------------------------------------------------------------
# Bypassing Tests
#-------------------------------------------------------------
# Test sb and lb (signed byte)
# Unsupported macro type: TEST_ST_LD_BYPASS(2,  lb,  sb, 0xffffffffffffffdd, 0, tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(3,  lb,  sb, 0xffffffffffffffcd, 1, tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(4,  lb,  sb, 0xffffffffffffffcc, 2, tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(5,  lb,  sb, 0xffffffffffffffbc, 3, tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(6,  lb,  sb, 0xffffffffffffffbb, 4, tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(7,  lb,  sb, 0xffffffffffffffab, 5, tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(8,  lb, sb, 0x33, 0, tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(9,  lb, sb, 0x23, 1, tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(10, lb, sb, 0x22, 2, tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(11, lb, sb, 0x12, 3, tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(12, lb, sb, 0x11, 4, tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(13, lb, sb, 0x01, 5, tdat )
# Test sb and lbu (unsigned byte)
# Unsupported macro type: TEST_ST_LD_BYPASS(14, lbu, sb, 0x33, 0, tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(15, lbu, sb, 0x23, 1, tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(16, lbu, sb, 0x22, 2, tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(17, lbu, sb, 0x12, 3, tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(18, lbu, sb, 0x11, 4, tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(19, lbu, sb, 0x01, 5, tdat )
# Test sw and lw (signed word)
# Unsupported macro type: TEST_ST_LD_BYPASS(20, lw, sw, 0xffffffffaabbccdd, 0,  tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(21, lw, sw, 0xffffffffdaabbccd, 4,  tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(22, lw, sw, 0xffffffffddaabbcc, 8,  tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(23, lw, sw, 0xffffffffcddaabbc, 12, tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(24, lw, sw, 0xffffffffccddaabb, 16, tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(25, lw, sw, 0xffffffffbccddaab, 20, tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(26, lw, sw, 0x00112233, 0,  tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(27, lw, sw, 0x30011223, 4,  tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(28, lw, sw, 0x33001122, 8,  tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(29, lw, sw, 0x23300112, 12, tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(30, lw, sw, 0x22330011, 16, tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(31, lw, sw, 0x12233001, 20, tdat )
# Test sh and lh (signed halfword)
# Unsupported macro type: TEST_ST_LD_BYPASS(32, lh, sh, 0xffffffffffffccdd, 0, tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(33, lh, sh, 0xffffffffffffbccd, 2, tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(34, lh, sh, 0xffffffffffffbbcc, 4, tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(35, lh, sh, 0xffffffffffffabbc, 6, tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(36, lh, sh, 0xffffffffffffaabb, 8, tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(37, lh, sh, 0xffffffffffffdaab, 10, tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(38, lh, sh, 0x2233, 0, tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(39, lh, sh, 0x1223, 2, tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(40, lh, sh, 0x1122, 4, tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(41, lh, sh, 0x0112, 6, tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(42, lh, sh, 0x0011, 8, tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(43, lh, sh, 0x3001, 10, tdat )
# Test sh and lhu (unsigned halfword)
# Unsupported macro type: TEST_ST_LD_BYPASS(44, lhu, sh, 0x2233, 0, tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(45, lhu, sh, 0x1223, 2, tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(46, lhu, sh, 0x1122, 4, tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(47, lhu, sh, 0x0112, 6, tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(48, lhu, sh, 0x0011, 8, tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(49, lhu, sh, 0x3001, 10, tdat )
# RV64-specific tests for ld, sd, and lwu
# Test sd and ld (doubleword)
# Unsupported macro type: TEST_ST_LD_BYPASS(50, ld, sd, 0x0011223344556677, 0,  tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(51, ld, sd, 0x1122334455667788, 8,  tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(52, ld, sd, 0x2233445566778899, 16, tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(53, ld, sd, 0xabbccdd, 0,  tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(54, ld, sd, 0xaabbccd, 8,  tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(55, ld, sd, 0xdaabbcc, 16, tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(56, ld, sd, 0xddaabbc, 24, tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(57, ld, sd, 0xcddaabb, 32, tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(58, ld, sd, 0xccddaab, 40, tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(59, ld, sd, 0x00112233, 0,  tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(60, ld, sd, 0x30011223, 8,  tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(61, ld, sd, 0x33001122, 16, tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(62, ld, sd, 0x23300112, 24, tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(63, ld, sd, 0x22330011, 32, tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(64, ld, sd, 0x12233001, 40, tdat )
# Test sw and lwu (unsigned word)
# Unsupported macro type: TEST_ST_LD_BYPASS(65, lwu, sw, 0x00112233, 0,  tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(66, lwu, sw, 0x33001122, 8,  tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(67, lwu, sw, 0x30011223, 4,  tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(68, lwu, sw, 0x23300112, 12, tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(69, lwu, sw, 0x22330011, 16, tdat )
# Unsupported macro type: TEST_ST_LD_BYPASS(70, lwu, sw, 0x12233001, 20, tdat )
li a0, 0xef         # Immediate load for manual store test
la a1, tdat         # Load address of tdat
sb a0, 3(a1)        # Store byte at offset 3 of tdat
lb a2, 3(a1)        # Load byte back for verification
# Could not parse: TEST_PASSFAIL
.data
# Could not parse: TEST_DATA
tdat:
.rept 20
.word 0xdeadbeef
.endr
  li x11, 1
  sw x11, 0(x10)
  addi x10, x10, 4
  j next_st_ld
fail_st_ld:
  li x11, 15
  sw x11, 0(x10)
  addi x10, x10, 4
next_st_ld:

# === SUB ===
#-------------------------------------------------------------
# Arithmetic tests
#-------------------------------------------------------------
  li x1, 0x0000000000000000
  li x2, 0x0000000000000000
  sub x3, x1, x2
  li x4, 0x0000000000000000
  bne x3, x4, fail_sub_19

  li x1, 0x0000000000000001
  li x2, 0x0000000000000001
  sub x3, x1, x2
  li x4, 0x0000000000000000
  bne x3, x4, fail_sub_20

  li x1, 0x0000000000000003
  li x2, 0x0000000000000007
  sub x3, x1, x2
  li x4, 0xfffffffffffffffc
  bne x3, x4, fail_sub_21

  li x1, 0x0000000000000000
  li x2, 0xffffffffffff8000
  sub x3, x1, x2
  li x4, 0x0000000000008000
  bne x3, x4, fail_sub_23

  li x1, 0xffffffff80000000
  li x2, 0x0000000000000000
  sub x3, x1, x2
  li x4, 0xffffffff80000000
  bne x3, x4, fail_sub_24

  li x1, 0xffffffff80000000
  li x2, 0xffffffffffff8000
  sub x3, x1, x2
  li x4, 0xffffffff80008000
  bne x3, x4, fail_sub_25

  li x1, 0x0000000000000000
  li x2, 0x0000000000007fff
  sub x3, x1, x2
  li x4, 0xffffffffffff8001
  bne x3, x4, fail_sub_27

  li x1, 0x000000007fffffff
  li x2, 0x0000000000000000
  sub x3, x1, x2
  li x4, 0x000000007fffffff
  bne x3, x4, fail_sub_28

  li x1, 0x000000007fffffff
  li x2, 0x0000000000007fff
  sub x3, x1, x2
  li x4, 0x000000007fff8000
  bne x3, x4, fail_sub_29

  li x1, 0xffffffff80000000
  li x2, 0x0000000000007fff
  sub x3, x1, x2
  li x4, 0xffffffff7fff8001
  bne x3, x4, fail_sub_31

  li x1, 0x000000007fffffff
  li x2, 0xffffffffffff8000
  sub x3, x1, x2
  li x4, 0x0000000080007fff
  bne x3, x4, fail_sub_32

  li x1, 0x0000000000000000
  li x2, 0xffffffffffffffff
  sub x3, x1, x2
  li x4, 0x0000000000000001
  bne x3, x4, fail_sub_34

  li x1, 0xffffffffffffffff
  li x2, 0x0000000000000001
  sub x3, x1, x2
  li x4, 0xfffffffffffffffe
  bne x3, x4, fail_sub_35

  li x1, 0xffffffffffffffff
  li x2, 0xffffffffffffffff
  sub x3, x1, x2
  li x4, 0x0000000000000000
  bne x3, x4, fail_sub_36

#-------------------------------------------------------------
# Source/Destination tests
#-------------------------------------------------------------
  li x1, 13
  li x2, 11
  sub x3, x1, x2
  li x4, 2
  bne x3, x4, fail_sub_42

  li x1, 14
  li x2, 11
  sub x3, x1, x2
  li x4, 3
  bne x3, x4, fail_sub_43

# Macro arg error in: TEST_RR_SRC12_EQ_DEST( 18, sub, 0, 13 )
#-------------------------------------------------------------
# Bypassing tests
#-------------------------------------------------------------
  li x1, 2
  li x2, 13
  0 x3, x1, x2
  li x4, sub
  bne x3, x4, fail_sub_50

  li x1, 3
  li x2, 14
  1 x3, x1, x2
  li x4, sub
  bne x3, x4, fail_sub_51

  li x1, 4
  li x2, 15
  2 x3, x1, x2
  li x4, sub
  bne x3, x4, fail_sub_52

  li x1, sub
  li x2, 2
  0 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_sub_54

  li x1, sub
  li x2, 3
  0 x3, x1, x2
  li x4, 1
  bne x3, x4, fail_sub_55

  li x1, sub
  li x2, 4
  0 x3, x1, x2
  li x4, 2
  bne x3, x4, fail_sub_56

  li x1, sub
  li x2, 2
  1 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_sub_57

  li x1, sub
  li x2, 3
  1 x3, x1, x2
  li x4, 1
  bne x3, x4, fail_sub_58

  li x1, sub
  li x2, 4
  2 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_sub_59

  li x1, sub
  li x2, 2
  0 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_sub_61

  li x1, sub
  li x2, 3
  0 x3, x1, x2
  li x4, 1
  bne x3, x4, fail_sub_62

  li x1, sub
  li x2, 4
  0 x3, x1, x2
  li x4, 2
  bne x3, x4, fail_sub_63

  li x1, sub
  li x2, 2
  1 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_sub_64

  li x1, sub
  li x2, 3
  1 x3, x1, x2
  li x4, 1
  bne x3, x4, fail_sub_65

  li x1, sub
  li x2, 4
  2 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_sub_66

# Macro arg error in: TEST_RR_ZEROSRC1( 34, sub, 15, -15 )
# Macro arg error in: TEST_RR_ZEROSRC2( 35, sub, 32, 32 )
# Macro arg error in: TEST_RR_ZEROSRC12( 36, sub, 0 )
# Macro arg error in: TEST_RR_ZERODEST( 37, sub, 16, 30 )
# Could not parse: TEST_PASSFAIL
.data
# Could not parse: TEST_DATA
  li x11, 1
  sw x11, 0(x10)
  addi x10, x10, 4
  j next_sub
fail_sub:
  li x11, 15
  sw x11, 0(x10)
  addi x10, x10, 4
next_sub:

# === SW ===
#-------------------------------------------------------------
# Basic tests
#-------------------------------------------------------------
# Unsupported macro type: TEST_ST_OP( 2, lw, sw, 0x0000000000aa00aa, 0,  tdat )
# Unsupported macro type: TEST_ST_OP( 3, lw, sw, 0xffffffffaa00aa00, 4,  tdat )
# Unsupported macro type: TEST_ST_OP( 4, lw, sw, 0x000000000aa00aa0, 8,  tdat )
# Unsupported macro type: TEST_ST_OP( 5, lw, sw, 0xffffffffa00aa00a, 12, tdat )
# Test with negative offset
# Unsupported macro type: TEST_ST_OP( 6, lw, sw, 0x0000000000aa00aa, -12, tdat8 )
# Unsupported macro type: TEST_ST_OP( 7, lw, sw, 0xffffffffaa00aa00, -8,  tdat8 )
# Unsupported macro type: TEST_ST_OP( 8, lw, sw, 0x000000000aa00aa0, -4,  tdat8 )
# Unsupported macro type: TEST_ST_OP( 9, lw, sw, 0xffffffffa00aa00a, 0,   tdat8 )
# Test with a negative base
# Could not parse: TEST_CASE( 10, x5, 0x12345678, \
la  x1, tdat9; \
li  x2, 0x12345678; \
addi x4, x1, -32; \
sw x2, 32(x4); \
lw x5, 0(x1); \
)
# Test with unaligned base
# Could not parse: TEST_CASE( 11, x5, 0x58213098, \
la  x1, tdat9; \
li  x2, 0x58213098; \
addi x1, x1, -3; \
sw x2, 7(x1); \
la  x4, tdat10; \
lw x5, 0(x4); \
)
#-------------------------------------------------------------
# Bypassing tests
#-------------------------------------------------------------
# Unsupported macro type: TEST_ST_SRC12_BYPASS( 12, 0, 0, lw, sw, 0xffffffffaabbccdd, 0,  tdat )
# Unsupported macro type: TEST_ST_SRC12_BYPASS( 13, 0, 1, lw, sw, 0xffffffffdaabbccd, 4,  tdat )
# Unsupported macro type: TEST_ST_SRC12_BYPASS( 14, 0, 2, lw, sw, 0xffffffffddaabbcc, 8,  tdat )
# Unsupported macro type: TEST_ST_SRC12_BYPASS( 15, 1, 0, lw, sw, 0xffffffffcddaabbc, 12, tdat )
# Unsupported macro type: TEST_ST_SRC12_BYPASS( 16, 1, 1, lw, sw, 0xffffffffccddaabb, 16, tdat )
# Unsupported macro type: TEST_ST_SRC12_BYPASS( 17, 2, 0, lw, sw, 0xffffffffbccddaab, 20, tdat )
# Unsupported macro type: TEST_ST_SRC21_BYPASS( 18, 0, 0, lw, sw, 0x00112233, 0,  tdat )
# Unsupported macro type: TEST_ST_SRC21_BYPASS( 19, 0, 1, lw, sw, 0x30011223, 4,  tdat )
# Unsupported macro type: TEST_ST_SRC21_BYPASS( 20, 0, 2, lw, sw, 0x33001122, 8,  tdat )
# Unsupported macro type: TEST_ST_SRC21_BYPASS( 21, 1, 0, lw, sw, 0x23300112, 12, tdat )
# Unsupported macro type: TEST_ST_SRC21_BYPASS( 22, 1, 1, lw, sw, 0x22330011, 16, tdat )
# Unsupported macro type: TEST_ST_SRC21_BYPASS( 23, 2, 0, lw, sw, 0x12233001, 20, tdat )
# Could not parse: TEST_PASSFAIL
.data
# Could not parse: TEST_DATA
tdat:
tdat1:  .word 0xdeadbeef
tdat2:  .word 0xdeadbeef
tdat3:  .word 0xdeadbeef
tdat4:  .word 0xdeadbeef
tdat5:  .word 0xdeadbeef
tdat6:  .word 0xdeadbeef
tdat7:  .word 0xdeadbeef
tdat8:  .word 0xdeadbeef
tdat9:  .word 0xdeadbeef
tdat10: .word 0xdeadbeef
  li x11, 1
  sw x11, 0(x10)
  addi x10, x10, 4
  j next_sw
fail_sw:
  li x11, 15
  sw x11, 0(x10)
  addi x10, x10, 4
next_sw:

# === XOR ===
#-------------------------------------------------------------
# Logical tests
#-------------------------------------------------------------
  li x1, 0xff00ff00
  li x2, 0x0f0f0f0f
  xor x3, x1, x2
  li x4, 0xf00ff00f
  bne x3, x4, fail_xor_19

  li x1, 0x0ff00ff0
  li x2, 0xf0f0f0f0
  xor x3, x1, x2
  li x4, 0xff00ff00
  bne x3, x4, fail_xor_20

  li x1, 0x00ff00ff
  li x2, 0x0f0f0f0f
  xor x3, x1, x2
  li x4, 0x0ff00ff0
  bne x3, x4, fail_xor_21

  li x1, 0xf00ff00f
  li x2, 0xf0f0f0f0
  xor x3, x1, x2
  li x4, 0x00ff00ff
  bne x3, x4, fail_xor_22

#-------------------------------------------------------------
# Source/Destination tests
#-------------------------------------------------------------
  li x1, 0xff00ff00
  li x2, 0x0f0f0f0f
  xor x3, x1, x2
  li x4, 0xf00ff00f
  bne x3, x4, fail_xor_28

  li x1, 0xff00ff00
  li x2, 0x0f0f0f0f
  xor x3, x1, x2
  li x4, 0xf00ff00f
  bne x3, x4, fail_xor_29

# Macro arg error in: TEST_RR_SRC12_EQ_DEST( 8, xor, 0x00000000, 0xff00ff00 )
#-------------------------------------------------------------
# Bypassing tests
#-------------------------------------------------------------
  li x1, 0xf00ff00f
  li x2, 0xff00ff00
  0 x3, x1, x2
  li x4, xor
  bne x3, x4, fail_xor_36

  li x1, 0xff00ff00
  li x2, 0x0ff00ff0
  1 x3, x1, x2
  li x4, xor
  bne x3, x4, fail_xor_37

  li x1, 0x0ff00ff0
  li x2, 0x00ff00ff
  2 x3, x1, x2
  li x4, xor
  bne x3, x4, fail_xor_38

  li x1, xor
  li x2, 0xf00ff00f
  0 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_xor_40

  li x1, xor
  li x2, 0xff00ff00
  0 x3, x1, x2
  li x4, 1
  bne x3, x4, fail_xor_41

  li x1, xor
  li x2, 0x0ff00ff0
  0 x3, x1, x2
  li x4, 2
  bne x3, x4, fail_xor_42

  li x1, xor
  li x2, 0xf00ff00f
  1 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_xor_43

  li x1, xor
  li x2, 0xff00ff00
  1 x3, x1, x2
  li x4, 1
  bne x3, x4, fail_xor_44

  li x1, xor
  li x2, 0x0ff00ff0
  2 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_xor_45

  li x1, xor
  li x2, 0xf00ff00f
  0 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_xor_47

  li x1, xor
  li x2, 0xff00ff00
  0 x3, x1, x2
  li x4, 1
  bne x3, x4, fail_xor_48

  li x1, xor
  li x2, 0x0ff00ff0
  0 x3, x1, x2
  li x4, 2
  bne x3, x4, fail_xor_49

  li x1, xor
  li x2, 0xf00ff00f
  1 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_xor_50

  li x1, xor
  li x2, 0xff00ff00
  1 x3, x1, x2
  li x4, 1
  bne x3, x4, fail_xor_51

  li x1, xor
  li x2, 0x0ff00ff0
  2 x3, x1, x2
  li x4, 0
  bne x3, x4, fail_xor_52

# Macro arg error in: TEST_RR_ZEROSRC1( 24, xor, 0xff00ff00, 0xff00ff00 )
# Macro arg error in: TEST_RR_ZEROSRC2( 25, xor, 0x00ff00ff, 0x00ff00ff )
# Macro arg error in: TEST_RR_ZEROSRC12( 26, xor, 0 )
# Macro arg error in: TEST_RR_ZERODEST( 27, xor, 0x11111111, 0x22222222 )
# Could not parse: TEST_PASSFAIL
.data
# Could not parse: TEST_DATA
  li x11, 1
  sw x11, 0(x10)
  addi x10, x10, 4
  j next_xor
fail_xor:
  li x11, 15
  sw x11, 0(x10)
  addi x10, x10, 4
next_xor:

# === XORI ===
#-------------------------------------------------------------
# Logical tests
#-------------------------------------------------------------
  li x1, 0x0000000000ff0f00
  xori x3, x1, 0xf0f
  li x4, 0xffffffffff00f00f
  bne x3, x4, fail_xori_19

  li x1, 0x000000000ff00ff0
  xori x3, x1, 0x0f0
  li x4, 0x000000000ff00f00
  bne x3, x4, fail_xori_20

  li x1, 0x0000000000ff08ff
  xori x3, x1, 0x70f
  li x4, 0x0000000000ff0ff0
  bne x3, x4, fail_xori_21

  li x1, 0xfffffffff00ff00f
  xori x3, x1, 0x0f0
  li x4, 0xfffffffff00ff0ff
  bne x3, x4, fail_xori_22

#-------------------------------------------------------------
# Source/Destination tests
#-------------------------------------------------------------
  li x1, 0xffffffffff00f700
  xori x3, x1, 0x70f
  li x4, 0xffffffffff00f00f
  bne x3, x4, fail_xori_28

#-------------------------------------------------------------
# Bypassing tests
#-------------------------------------------------------------
  li x1, 0x000000000ff00ff0
  xori x3, x1, 0x0f0
  li x4, 0x000000000ff00f00
  bne x3, x4, fail_xori_34

  li x1, 0x0000000000ff08ff
  xori x3, x1, 0x70f
  li x4, 0x0000000000ff0ff0
  bne x3, x4, fail_xori_35

  li x1, 0xfffffffff00ff00f
  xori x3, x1, 0x0f0
  li x4, 0xfffffffff00ff0ff
  bne x3, x4, fail_xori_36

  li x1, 0x000000000ff00ff0
  xori x3, x1, 0x0f0
  li x4, 0x000000000ff00f00
  bne x3, x4, fail_xori_38

  li x1, 0x0000000000ff0fff
  xori x3, x1, 0x00f
  li x4, 0x0000000000ff0ff0
  bne x3, x4, fail_xori_39

  li x1, 0xfffffffff00ff00f
  xori x3, x1, 0x0f0
  li x4, 0xfffffffff00ff0ff
  bne x3, x4, fail_xori_40

# Macro arg error in: TEST_IMM_ZEROSRC1( 13, xori, 0x0f0, 0x0f0 )
# Macro arg error in: TEST_IMM_ZERODEST( 14, xori, 0x00ff00ff, 0x70f )
# Could not parse: TEST_PASSFAIL
.data
# Could not parse: TEST_DATA
  li x11, 1
  sw x11, 0(x10)
  addi x10, x10, 4
  j next_xori
fail_xori:
  li x11, 15
  sw x11, 0(x10)
  addi x10, x10, 4
next_xori:

  li a7, 10
  ecall
