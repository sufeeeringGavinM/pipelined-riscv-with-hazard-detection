
    li x10, 0  # Base pointer for memory writes

    # 1. ADD: 100 + (-50) = 50 (0x32)
    li x1, 100
    li x2, -50
    add x3, x1, x2
    sw x3, 0(x10)

    # 2. SUB: 50 - 100 = -50 (0xFFFFFFCE)
    li x1, 50
    li x2, 100
    sub x3, x1, x2
    sw x3, 4(x10)

    # 3. AND
    li x1, 0xAAAA5555
    li x2, 0x5555AAAA
    and x3, x1, x2
    sw x3, 8(x10)

    # 4. OR
    or x3, x1, x2
    sw x3, 12(x10)

    # 5. XOR
    xor x3, x1, x2
    sw x3, 16(x10)

    # 6. SLL
    li x1, 1
    li x2, 31
    sll x3, x1, x2
    sw x3, 20(x10)

    # 7. SRL
    li x1, 0x80000000
    srl x3, x1, x2
    sw x3, 24(x10)

    # 8. SRA
    sra x3, x1, x2
    sw x3, 28(x10)

    # 9. SLT
    li x1, -1
    li x2, 1
    slt x3, x1, x2
    sw x3, 32(x10)

    # 10. SLTU
    sltu x3, x1, x2
    sw x3, 36(x10)

    # 11. ADDI
    addi x3, x0, -2048
    sw x3, 40(x10)

    # 12. LUI
    lui x3, 0xABCDE
    sw x3, 44(x10)

    # 13. BEQ
    li x1, 5
    li x2, 5
    beq x1, x2, beq_pass
    li x3, 0xBAD
    j beq_done
beq_pass:
    li x3, 0x600D
beq_done:
    sw x3, 48(x10)

    # 14. BNE
    bne x1, x2, bne_fail
    li x3, 0x600D
    j bne_done
bne_fail:
    li x3, 0xBAD
bne_done:
    sw x3, 52(x10)

    # 15. JAL Forward Jump
    jal x0, jal_pass
    li x3, 0xBAD
    j jal_done
jal_pass:
    li x3, 0x600D
jal_done:
    sw x3, 56(x10)

    # 16. DATA HAZARD 1 (EXE->EXE)
    li x1, 10
    add x1, x1, x1  
    add x3, x1, x1  # x3 = 40 (0x28)
    sw x3, 60(x10)

    # 17. DATA HAZARD 2 (MEM->EXE)
    li x1, 10
    add x1, x1, x0  
    nop             
    add x3, x1, x1  # x3 = 20 (0x14)
    sw x3, 64(x10)

    # --- MEMORY ALIGNMENT TESTS (Using Scratchpad at offset 400) ---
    li x1, 0x89ABCDEF
    sw x1, 400(x10)

    # 18. LB 
    lb x3, 400(x10)
    sw x3, 68(x10)

    # 19. LBU 
    lbu x3, 400(x10)
    sw x3, 72(x10)

    # 20. LH 
    lh x3, 400(x10)
    sw x3, 76(x10)

    # 21. LHU 
    lhu x3, 400(x10)
    sw x3, 80(x10)

    # 22. LW
    lw x3, 400(x10)
    sw x3, 84(x10)

    # 23. LOAD-STORE HAZARD
    lw x1, 400(x10)
    sw x1, 88(x10) 

    # 24. ANDI
    li x1, 0xFFFF0000
    andi x3, x1, 0x0F0
    sw x3, 92(x10)

    # 25. ORI
    ori x3, x0, 0xBC
    sw x3, 96(x10)

    # 26. XORI
    xori x3, x0, 0xFF
    sw x3, 100(x10)

    # 27. SLLI
    li x1, 1
    slli x3, x1, 31
    sw x3, 104(x10)

    # 28. SRLI
    li x1, 0x80000000
    srli x3, x1, 16
    sw x3, 108(x10)

    # 29. SRAI
    srai x3, x1, 16
    sw x3, 112(x10)

    # 30. SLTI
    li x1, -50
    slti x3, x1, -40
    sw x3, 116(x10)

    # 31. SLTIU
    sltiu x3, x1, 10
    sw x3, 120(x10)

    # 32. BLT (Signed)
    li x1, -10
    li x2, 5
    blt x1, x2, blt_pass
    li x3, 0xBAD
    j blt_done
blt_pass:
    li x3, 0x600D
blt_done:
    sw x3, 124(x10)

    # 33. BLTU (Unsigned)
    bltu x1, x2, bltu_fail 
    li x3, 0x600D
    j bltu_done
bltu_fail:
    li x3, 0xBAD
bltu_done:
    sw x3, 128(x10)

    # 34. BGE (Signed)
    bge x2, x1, bge_pass 
    li x3, 0xBAD
    j bge_done
bge_pass:
    li x3, 0x600D
bge_done:
    sw x3, 132(x10)

    # 35. BGEU (Unsigned)
    bgeu x1, x2, bgeu_pass 
    li x3, 0xBAD
    j bgeu_done
bgeu_pass:
    li x3, 0x600D
bgeu_done:
    sw x3, 136(x10)

    # 36. JALR Routine
    jal x1, jalr_func
    li x3, 0x600D        
    j jalr_done_test
jalr_func:
    jalr x0, x1, 0       
    li x3, 0xBAD         
jalr_done_test:
    sw x3, 140(x10)

    # 37. SB (Store Byte)
    sw x0, 404(x10)      
    li x1, 0xAA
    sb x1, 405(x10)      
    lw x3, 404(x10)
    sw x3, 144(x10)      

    # 38. SH (Store Half)
    sw x0, 408(x10)      
    li x1, 0xBBCC
    sh x1, 410(x10)      
    lw x3, 408(x10)
    sw x3, 148(x10)      

    # 39. Branch Flush Safety 
    beq x0, x0, flush_safe
    li x3, 0xBAD         
    sw x3, 152(x10)      
flush_safe:
    li x3, 0x600D
    sw x3, 152(x10)      

    # 40. Extreme Cascade
    addi x1, x0, 1
    add x1, x1, x1       
    add x1, x1, x1       
    add x3, x1, x1       
    sw x3, 156(x10)      

    # 41. JALR dynamic math
    jal x1, get_pc
get_pc:
    addi x1, x1, 16      
    jalr x0, x1, 0       
    addi x3, x0, 0       
    addi x3, x0, 0       
    addi x3, x0, 1       
    sw x3, 160(x10)      
    
    # --- DEEP ARCHITECTURAL TESTS ---

    # 42. x0 Hardwire Test (Must remain 0)
    addi x0, x0, 5
    sw x0, 164(x10)

    # 43. AUIPC Delta 
    auipc x1, 0
    addi x2, x2 0
    sub x3, x2, x1
    sw x3, 168(x10)  # Expect: 4

    # 44. Load-Use ALU Hazard
    lw x1, 400(x10)  # Loads 0x89ABCDEF
    addi x3, x1, 1   # Stalls pipeline, then adds 1
    sw x3, 172(x10)  # Expect: 0x89ABCDF0

    # 45. BGE: Negative vs Zero
    li x1, -1
    bge x1, x0, bge_fail2
    li x3, 0x600D
    j bge_done2
bge_fail2:
    li x3, 0xBAD
bge_done2:
    sw x3, 176(x10)

    # 46. BGEU: Negative (Max Unsigned) vs Zero
    li x1, -1
    bgeu x1, x0, bgeu_pass2
    li x3, 0xBAD
    j bgeu_done2
bgeu_pass2:
    li x3, 0x600D
bgeu_done2:
    sw x3, 180(x10)

    # 47. Backwards Loop Test
    li x1, 3
    li x3, 0
loop_start:
    addi x3, x3, 5
    addi x1, x1, -1
    bne x1, x0, loop_start
    sw x3, 184(x10)  # Expect: 15 (0x0000000F)

    # 48. Shift by 0
    li x1, 0xFFFFFFFF
    li x2, 0
    sll x3, x1, x2
    sw x3, 188(x10)  # Expect: 0xFFFFFFFF

    # 49. Shift by 32 (Modulo 32 should treat as 0)
    li x1, 0x12345678
    li x2, 32
    sll x3, x1, x2
    sw x3, 192(x10)  # Expect: 0x12345678

    # 50. Wrap-around ADD
    li x1, 0xFFFFFFFF
    addi x3, x1, 1
    sw x3, 196(x10)  # Expect: 0x00000000

    # 51. LB Sign-Extend high bit
    li x1, 0x80000000
    sw x1, 412(x10)
    lb x3, 415(x10)  # Load byte 0x80
    sw x3, 200(x10)  # Expect: 0xFFFFFF80

    # 52. LBU Zero-Extend high bit
    lbu x3, 415(x10)
    sw x3, 204(x10)  # Expect: 0x00000080

    # 53. MEM->MEM Hazard (Load directly into Store data)
    lw x1, 400(x10)
    sw x1, 208(x10)  # Expect: 0x89ABCDEF

    # 54. Backwards JAL
    j fwd_jump
bwd_jump:
    li x3, 0x600D
    j end_bwd_jump
fwd_jump:
    jal x0, bwd_jump
    li x3, 0xBAD
end_bwd_jump:
    sw x3, 212(x10)

    # 55. COMPLETION FLAG
    li x3, 0xFFFFFFFF
    sw x3, 216(x10)
	
	# --- REGISTER FILE ISOLATION & SUMMATION ---
    # Tests 201 to 210: Load distinct values into scattered registers
    # to ensure no adjacent register cross-talk or decoder bleed.
    li x1, 1
    sw x1, 800(x10)

    li x2, 2
    sw x2, 804(x10)

    li x4, 4
    sw x4, 808(x10)

    li x5, 5
    sw x5, 812(x10)

    li x6, 6
    sw x6, 816(x10)

    li x7, 7
    sw x7, 820(x10)

    li x8, 8
    sw x8, 824(x10)

    li x9, 9
    sw x9, 828(x10)

    li x11, 11
    sw x11, 832(x10)

    li x12, 12
    sw x12, 836(x10)

    # 211. Massive cascade sum of the scattered registers
    add x3, x1, x2
    add x3, x3, x4
    add x3, x3, x5
    add x3, x3, x6
    add x3, x3, x7
    add x3, x3, x8
    add x3, x3, x9
    add x3, x3, x11
    add x3, x3, x12
    sw x3, 840(x10)

    # --- MEMORY TO BRANCH HAZARDS ---
    # 212. Load-to-BEQ hazard
    li x1, 0xFACE
    sw x1, 1000(x10)
    lw x2, 1000(x10)
    beq x2, x1, pass_212
    li x3, 0xBAD
    j done_212
pass_212:
    li x3, 0x600D
done_212:
    sw x3, 844(x10)

    # 213. Load-to-BNE hazard
    lw x2, 1000(x10)
    bne x2, x0, pass_213
    li x3, 0xBAD
    j done_213
pass_213:
    li x3, 0x600D
done_213:
    sw x3, 848(x10)

    # 214. Load-to-BLT hazard
    li x1, 0x7FFFFFFF
    sw x1, 1004(x10)
    lw x2, 1004(x10)
    blt x0, x2, pass_214
    li x3, 0xBAD
    j done_214
pass_214:
    li x3, 0x600D
done_214:
    sw x3, 852(x10)

    # 215. Load-to-BGE hazard
    lw x2, 1004(x10)
    bge x2, x1, pass_215
    li x3, 0xBAD
    j done_215
pass_215:
    li x3, 0x600D
done_215:
    sw x3, 856(x10)

    # --- BYPASS CANCELLATION (The X0 Trap) ---
    # 216. Forwarding bypass cancellation test 1 (ADD)
    li x1, 0x11111111
    add x0, x1, x1
    add x3, x0, x1
    sw x3, 860(x10)

    # 217. Forwarding bypass cancellation test 2 (SUB)
    li x2, 0x22222222
    sub x0, x2, x1
    add x3, x0, x2
    sw x3, 864(x10)

    # 218. Forwarding bypass cancellation test 3 (LW)
    lw x0, 1000(x10)
    add x3, x0, x0
    sw x3, 868(x10)

    # 219. Forwarding bypass cancellation test 4 (LUI)
    lui x0, 0xFFFFF
    add x3, x0, x0
    sw x3, 872(x10)

    # --- JUMP AND LINK ROLLERCOASTER ---
    # 220. JAL to JALR back-to-back
    jal x1, jump_target_1
    li x3, 0xBAD
    j done_jump_chain
jump_target_1:
    auipc x2, 0
    addi x2, x2, 12
    jalr x1, x2, 0
    li x3, 0xBAD
    j done_jump_chain
    li x3, 0x600D
done_jump_chain:
    sw x3, 876(x10)

    # --- IMMEDIATE EDGE CASES ---
    # 221. ADDI with max positive 12-bit immediate
    addi x3, x0, 2047
    sw x3, 880(x10)

    # 222. ADDI with min negative 12-bit immediate
    addi x3, x0, -2048
    sw x3, 884(x10)

    # 223. SLTI with max positive
    li x1, 2046
    slti x3, x1, 2047
    sw x3, 888(x10)

    # 224. SLTI with min negative
    li x1, -2047
    slti x3, x1, -2048
    sw x3, 892(x10)

    # 225. SLTIU with -1 (0xFFF)
    li x1, 0xFFFFFFFE
    sltiu x3, x1, -1
    sw x3, 896(x10)

    # 226. ANDI with max negative
    li x1, 0x12345678
    andi x3, x1, -1
    sw x3, 900(x10)

    # 227. ORI with min negative
    ori x3, x0, -2048
    sw x3, 904(x10)

    # 228. XORI alternating bits
    li x1, 0xAAAAAAAA
    xori x3, x1, 1365
    sw x3, 908(x10)

    # --- HIGH BIT ARITHMETIC SHIFTS ---
    # 229. SRAI shift 31 negative
    li x1, 0x80000000
    srai x3, x1, 31
    sw x3, 912(x10)

    # 230. SRAI shift 31 positive
    li x1, 0x7FFFFFFF
    srai x3, x1, 31
    sw x3, 916(x10)

    # 231. SLLI overflow check
    li x1, 0x40000000
    slli x3, x1, 1
    sw x3, 920(x10)

    # 232. SLLI shift 2
    slli x3, x1, 2
    sw x3, 924(x10)

    # 233. The NOP Slide
    li x3, 0x600D
    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0
    sw x3, 928(x10)

    # --- MEMORY ALIGNMENT BYTE STRESS ---
    li x1, 0x1A2B3C4D
    sw x1, 1008(x10)

    # 234. LB offset 0
    lb x3, 1008(x10)
    sw x3, 932(x10)

    # 235. LB offset 1
    lb x3, 1009(x10)
    sw x3, 936(x10)

    # 236. LB offset 2
    lb x3, 1010(x10)
    sw x3, 940(x10)

    # 237. LB offset 3
    lb x3, 1011(x10)
    sw x3, 944(x10)

    # 238. LBU offset 0
    lbu x3, 1008(x10)
    sw x3, 948(x10)

    # 239. LBU offset 3
    lbu x3, 1011(x10)
    sw x3, 952(x10)

    # 240. LH offset 0
    lh x3, 1008(x10)
    sw x3, 956(x10)

    # 241. LH offset 2
    lh x3, 1010(x10)
    sw x3, 960(x10)

    # 242. LHU offset 0
    lhu x3, 1008(x10)
    sw x3, 964(x10)

    # 243. LHU offset 2
    lhu x3, 1010(x10)
    sw x3, 968(x10)

    # --- FINAL EXTENSIONS (244 - 250) ---

    # 244. Multi-path hazard stress
    li x1, 50
    li x2, 50
    add x3, x1, x2
    sub x4, x3, x1
    add x5, x4, x2
    sw x5, 972(x10)

    # 245. Branch hazard with inter-dependency
    li x1, 1
    li x2, 1
    add x1, x1, x2
    beq x1, x2, fail_245
    li x3, 0x600D
    j pass_245
fail_245:
    li x3, 0xBAD
pass_245:
    sw x3, 976(x10)

    # 246. SLTU boundary test
    li x1, 0xFFFFFFFF
    li x2, 0x00000001
    sltu x3, x1, x2
    sw x3, 980(x10)

    # 247. SLT boundary test
    slt x3, x1, x2
    sw x3, 984(x10)

    # 248. Immediate shift 31
    li x1, 1
    slli x3, x1, 31
    sw x3, 988(x10)

    # 249. Memory-based stall check
    li x1, 0xBBBB
    sw x1, 1012(x10)
    lw x2, 1012(x10)
    addi x3, x2, 1
    sw x3, 992(x10)

    # 250. THE ABSOLUTE FINAL ENDPOINT
    li x3, 0xDEAD250
    sw x3, 996(x10)