`timescale 1ns/1ps

module pipelined_riscv_hazard (
    input             clk      ,
    output reg        data_wr  ,
    input             nrst     ,
    output reg [31:0] data_addr,
    input      [31:0] data_in  ,
    output reg  [3:0] data_mask,
    output reg [31:0] data_out ,
    input      [31:0] inst     ,
    output     [31:0] inst_addr,
    output     [31:0] pc_IF    ,
    output     [31:0] pc_ID    ,
    output     [31:0] pc_EXE   ,
    output     [31:0] pc_MEM   ,
    output     [31:0] pc_WB
    );

    // --- Hazard Control Wires ---
    wire stall;
    reg  flush; // wire, reg, life doesnt matter anyway
 
    /*
    //
    IF
    //
    */

    reg [31:0] pc     ;
    reg [31:0] next_pc;
    assign inst_addr = pc;
    assign pc_IF     = pc;
    always @(posedge clk or negedge nrst) begin
        if(!nrst)
            pc <= 0;
        else if (!stall) // Stall: Freeze the PC
            pc <= next_pc;
    end

    /*
    //
    ID
    //
    */

    reg [31:0] IMEM_RF;

    wire [6:0] opcode_IF = inst[6:0]    ;
    wire [6:0] opcode    = IMEM_RF[6:0] ;
    wire [4:0] rd        = IMEM_RF[11:7];
    wire [2:0] funct3    = IMEM_RF[14:12];
    wire [4:0] rs1       = IMEM_RF[19:15];
    wire [4:0] rs2       = IMEM_RF[24:20];
    wire [6:0] funct7    = IMEM_RF[31:25];

    // Identify if the instruction in ID actually writes to a register
    wire id_writes_reg = (opcode == 7'b0110011) || (opcode == 7'b0010011) ||
                         (opcode == 7'b0000011) || (opcode == 7'b0110111) ||
                         (opcode == 7'b0010111) || (opcode == 7'b1101111) ||
                         (opcode == 7'b1100111);

    reg [31:0] reg_file [31:0];
    reg [31:0] reg_rs1        ;
    reg [31:0] reg_rs2        ;

	// For the later writeback stage
    reg     [31:0] wr_data_WB;
    reg            wr_en_WB  ;
    reg     [4:0]  rd_WB     ;
    integer i;

    always @(*) begin
        if (rs1 == 0)
            reg_rs1 = 0;
        else if (wr_en_WB && (rd_WB != 0) && (rd_WB == rs1)) 
            reg_rs1 = wr_data_WB;
        else
            reg_rs1 = reg_file[rs1];
			
        if (rs2 == 0)
            reg_rs2 = 0;
        else if (wr_en_WB && (rd_WB != 0) && (rd_WB == rs2))
            reg_rs2 = wr_data_WB;
        else
            reg_rs2 = reg_file[rs2];
    end

    

    always @(posedge clk or negedge nrst) begin
        if (!nrst) begin
            for (i = 0; i < 32; i = i + 1)
                reg_file[i] <= 32'b0;
        end else begin
            if (wr_en_WB && rd_WB != 5'b0)
                reg_file[rd_WB] <= wr_data_WB;
        end
    end

    // The immediates
    wire [31:0] imm_i = {{20{IMEM_RF[31]}}, IMEM_RF[31:20]}                                                ;
    wire [31:0] imm_s = {{20{IMEM_RF[31]}}, IMEM_RF[31:25], IMEM_RF[11:7]}                                 ;
    wire [31:0] imm_b = {{19{IMEM_RF[31]}}, IMEM_RF[31], IMEM_RF[7], IMEM_RF[30:25], IMEM_RF[11:8], 1'b0} ;
    wire [31:0] imm_u = {IMEM_RF[31:12], 12'b0}                                                            ;
    wire [31:0] imm_j = {{11{IMEM_RF[31]}}, IMEM_RF[31], IMEM_RF[19:12], IMEM_RF[20], IMEM_RF[30:21], 1'b0};

    /*
    //
    EXE
    //
    */

    reg [31:0] PC_PC_ID_EXE ;
    reg [31:0] PC_ID_EXE    ;
    reg [31:0] REG_RD1      ;
    reg [31:0] REG_RD2_1    ;
    reg [31:0] IMM_REG      ;
    reg [6:0]  opcode_ID    ;
    reg [4:0]  rd_ID        ;
    reg [4:0]  rs1_ID       ;
    reg [4:0]  rs2_ID       ;
    reg [2:0]  funct3_ID    ;
    reg [6:0]  funct7_ID    ;
    reg        wr_en_ID     ;

    assign pc_ID = PC_PC_ID_EXE;
    
    // Load detect: If exe is LOAD and ID needs destination reg
    assign stall = (opcode_ID == 7'b0000011) && (rd_ID != 0) && ((rs1 == rd_ID) || (rs2 == rd_ID));

    // Forwarding Unit
    reg [31:0] fwd_rs1;
    reg [31:0] fwd_rs2;
    reg [4:0]  rd_EXE;
    reg        wr_en_EXE;
    reg [4:0]  rd_MEM;
    reg        wr_en_MEM;
    reg [31:0] PC_ALU_DMEM;

    always @(*) begin
        // rs1 Forwarding
        if (wr_en_EXE && (rd_EXE != 0) && (rd_EXE == rs1_ID))
            fwd_rs1 = PC_ALU_DMEM; // Asel wold select instead of rs1 bit in slides
        else if (wr_en_MEM && (rd_MEM != 0) && (rd_MEM == rs1_ID))
            fwd_rs1 = wr_data_WB;
        else
            fwd_rs1 = REG_RD1;

        // Rs2 Forwarding
        if (wr_en_EXE && (rd_EXE != 0) && (rd_EXE == rs2_ID))
            fwd_rs2 = PC_ALU_DMEM; 
        else if (wr_en_MEM && (rd_MEM != 0) && (rd_MEM == rs2_ID))
            fwd_rs2 = wr_data_WB;  
        else
            fwd_rs2 = REG_RD2_1;   
    end

    reg [31:0] alu_out;

    wire signed [31:0] s_rs1 = fwd_rs1;
    wire signed [31:0] s_rs2 = fwd_rs2;

    always @(*) begin
        alu_out = 0;

        // ADD
        if      (opcode_ID == 7'b0110011 && funct3_ID == 3'b000 && funct7_ID == 7'b0000000)
            alu_out = fwd_rs1 + fwd_rs2;

        // SUB
        else if (opcode_ID == 7'b0110011 && funct3_ID == 3'b000 && funct7_ID == 7'b0100000)
            alu_out = fwd_rs1 - fwd_rs2;

        // AND
        else if (opcode_ID == 7'b0110011 && funct3_ID == 3'b111 && funct7_ID == 7'b0000000)
            alu_out = fwd_rs1 & fwd_rs2;

        // OR
        else if (opcode_ID == 7'b0110011 && funct3_ID == 3'b110 && funct7_ID == 7'b0000000)
            alu_out = fwd_rs1 | fwd_rs2;

        // XOR
        else if (opcode_ID == 7'b0110011 && funct3_ID == 3'b100 && funct7_ID == 7'b0000000)
            alu_out = fwd_rs1 ^ fwd_rs2;

        // SLL
        else if (opcode_ID == 7'b0110011 && funct3_ID == 3'b001 && funct7_ID == 7'b0000000)
            alu_out = fwd_rs1 << fwd_rs2[4:0];

        // SRL
        else if (opcode_ID == 7'b0110011 && funct3_ID == 3'b101 && funct7_ID == 7'b0000000)
            alu_out = fwd_rs1 >> fwd_rs2[4:0];

        // SRA
        else if (opcode_ID == 7'b0110011 && funct3_ID == 3'b101 && funct7_ID == 7'b0100000)
            alu_out = s_rs1 >>> fwd_rs2[4:0];

        // SLT
        else if (opcode_ID == 7'b0110011 && funct3_ID == 3'b010 && funct7_ID == 7'b0000000)
            alu_out = (s_rs1 < s_rs2) ? 32'd1 : 32'd0;

        // SLTU
        else if (opcode_ID == 7'b0110011 && funct3_ID == 3'b011 && funct7_ID == 7'b0000000)
            alu_out = (fwd_rs1 < fwd_rs2) ? 32'd1 : 32'd0;

        // ADDI
        else if (opcode_ID == 7'b0010011 && funct3_ID == 3'b000)
            alu_out = fwd_rs1 + IMM_REG;

        // ANDI
        else if (opcode_ID == 7'b0010011 && funct3_ID == 3'b111)
            alu_out = fwd_rs1 & IMM_REG;

        // ORI
        else if (opcode_ID == 7'b0010011 && funct3_ID == 3'b110)
            alu_out = fwd_rs1 | IMM_REG;

        // XORI
        else if (opcode_ID == 7'b0010011 && funct3_ID == 3'b100)
            alu_out = fwd_rs1 ^ IMM_REG;

        // SLLI
        else if (opcode_ID == 7'b0010011 && funct3_ID == 3'b001 && funct7_ID == 7'b0000000)
            alu_out = fwd_rs1 << IMM_REG[4:0];

        // SRLI
        else if (opcode_ID == 7'b0010011 && funct3_ID == 3'b101 && funct7_ID == 7'b0000000)
            alu_out = fwd_rs1 >> IMM_REG[4:0];

        // SRAI
        else if (opcode_ID == 7'b0010011 && funct3_ID == 3'b101 && funct7_ID == 7'b0100000)
            alu_out = s_rs1 >>> IMM_REG[4:0];

        // SLTI
        else if (opcode_ID == 7'b0010011 && funct3_ID == 3'b010)
            alu_out = ($signed(fwd_rs1) < $signed(IMM_REG)) ? 32'd1 : 32'd0;

        // SLTIU
        else if (opcode_ID == 7'b0010011 && funct3_ID == 3'b011)
            alu_out = ($unsigned(fwd_rs1) < $unsigned(IMM_REG)) ? 32'd1 : 32'd0;

        // LOAD address
        else if (opcode_ID == 7'b0000011)
            alu_out = fwd_rs1 + IMM_REG;

        // STORE address
        else if (opcode_ID == 7'b0100011)
            alu_out = fwd_rs1 + IMM_REG;

        // LUI
        else if (opcode_ID == 7'b0110111)
            alu_out = IMM_REG;

        // AUIPC
        else if (opcode_ID == 7'b0010111)
            alu_out = PC_ID_EXE + IMM_REG;

        // JAL
        else if (opcode_ID == 7'b1101111)
            alu_out = PC_ID_EXE + 4;

        // JALRs
        else if (opcode_ID == 7'b1100111)
            alu_out = PC_ID_EXE + 4;
    end

// branching logic
    reg branch_taken;

    always @(*) begin

        next_pc      = pc + 4;
        branch_taken = 0;
        flush        = 0;

        if (opcode_ID == 7'b1100011) begin
            // BEQ
            if (funct3_ID == 3'b000 && fwd_rs1 == fwd_rs2)  branch_taken = 1;
            // BNE
            if (funct3_ID == 3'b001 && fwd_rs1 != fwd_rs2)  branch_taken = 1;
            // BLT
            if (funct3_ID == 3'b100 && s_rs1 < s_rs2)          branch_taken = 1;
            // BGE
            if (funct3_ID == 3'b101 && s_rs1 >= s_rs2)         branch_taken = 1;
            // BLTU
            if (funct3_ID == 3'b110 && fwd_rs1 < fwd_rs2)   branch_taken = 1;
            // BGEU
            if (funct3_ID == 3'b111 && fwd_rs1 >= fwd_rs2)  branch_taken = 1;

            if (branch_taken) begin
                next_pc = PC_ID_EXE + IMM_REG;
                flush   = 1;
            end
        end
        else if (opcode_ID == 7'b1101111) begin
            // JAL: jump target is PC (unbiased pipeline reg) + imm
            next_pc = PC_ID_EXE + IMM_REG;
            flush   = 1;
        end
        else if (opcode_ID == 7'b1100111) begin
            // JALR: (rs1 - bias + imm) & ~1
            next_pc = (fwd_rs1 + IMM_REG) & ~32'h1;
            flush   = 1;
        end
    end

    reg [31:0] PC_EXE_MEM  ;
    reg [31:0] REG_RD2_2   ;
    reg [6:0]  opcode_EXE  ;
    reg [2:0]  funct3_EXE  ;

    assign pc_EXE = PC_ID_EXE;

    /*
    //
    MEM
    //
    */

    reg [31:0] shifted_data;
    reg [31:0] load_addr   ;
    reg  [1:0] byte_offset ;

    always @(*) begin
        shifted_data = 0;
        load_addr    = 0;
        byte_offset  = 0;
        data_mask    = 4'b0000;
        data_addr    = 0;
        data_out     = 0;
        data_wr      = 0;

        // SB
        if (opcode_EXE == 7'b0100011 && funct3_EXE == 3'b000) begin
            data_wr   = 1;
            data_addr = PC_ALU_DMEM & ~32'h3;
            data_mask = 4'b0001 << PC_ALU_DMEM[1:0];
            data_out  = REG_RD2_2 << (PC_ALU_DMEM[1:0] * 8);
        end

        // SH
        else if (opcode_EXE == 7'b0100011 && funct3_EXE == 3'b001) begin
            data_wr   = 1;
            data_addr = PC_ALU_DMEM & ~32'h3;
            data_mask = 4'b0011 << PC_ALU_DMEM[1:0];
            data_out  = REG_RD2_2 << (PC_ALU_DMEM[1:0] * 8);
        end

        // SW
        else if (opcode_EXE == 7'b0100011 && funct3_EXE == 3'b010) begin
            data_wr   = 1;
            data_addr = PC_ALU_DMEM;
            data_mask = 4'b1111;
            data_out  = REG_RD2_2;
        end

        // LOAD
        if (opcode_EXE == 7'b0000011) begin
            load_addr   = PC_ALU_DMEM;
            byte_offset = load_addr[1:0];
            data_mask   = 4'b1111;
            data_addr   = PC_ALU_DMEM & ~32'h3;

            if      (byte_offset == 2'b00) shifted_data = data_in;
            else if (byte_offset == 2'b01) shifted_data = data_in >> 8;
            else if (byte_offset == 2'b10) shifted_data = data_in >> 16;
            else if (byte_offset == 2'b11) shifted_data = data_in >> 24;
        end
    end

    /*
    //
    WB
    //
    */

    reg [31:0] PC_MEM_WB  ;
    reg [6:0]  opcode_MEM ;
    reg [2:0]  funct3_MEM ;
    reg [31:0] ALU_MEM_WB ;
    reg [31:0] SHIFTED_MEM;

    assign pc_MEM = PC_EXE_MEM;
    assign pc_WB  = PC_MEM_WB;

    always @(*) begin
        wr_en_WB   = 0;
        wr_data_WB = 0;
        rd_WB      = rd_MEM;

        // R-TYPE
        if (opcode_MEM == 7'b0110011) begin
            wr_en_WB   = 1;
            wr_data_WB = ALU_MEM_WB;
        end

        // I-TYPE ALU
        if (opcode_MEM == 7'b0010011) begin
            wr_en_WB   = 1;
            wr_data_WB = ALU_MEM_WB;
        end

        // LOAD
        if (opcode_MEM == 7'b0000011) begin
            wr_en_WB = 1;

            // LB
            if      (funct3_MEM == 3'b000 && SHIFTED_MEM[7] == 1'b0)
                wr_data_WB = {24'b0,       SHIFTED_MEM[7:0]};
            else if (funct3_MEM == 3'b000 && SHIFTED_MEM[7] == 1'b1)
                wr_data_WB = {{24{1'b1}},  SHIFTED_MEM[7:0]};
            // LBU
            else if (funct3_MEM == 3'b100)
                wr_data_WB = {24'b0,       SHIFTED_MEM[7:0]};
            // LH
            else if (funct3_MEM == 3'b001 && SHIFTED_MEM[15] == 1'b0)
                wr_data_WB = {16'b0,       SHIFTED_MEM[15:0]};
            else if (funct3_MEM == 3'b001 && SHIFTED_MEM[15] == 1'b1)
                wr_data_WB = {{16{1'b1}},  SHIFTED_MEM[15:0]};
            // LHU
            else if (funct3_MEM == 3'b101)
                wr_data_WB = {16'b0,       SHIFTED_MEM[15:0]};
            // LW
            else if (funct3_MEM == 3'b010)
                wr_data_WB = SHIFTED_MEM;
        end

        // LUI
        if (opcode_MEM == 7'b0110111) begin
            wr_en_WB   = 1;
            wr_data_WB = ALU_MEM_WB;
        end

        // AUIPC
        if (opcode_MEM == 7'b0010111) begin
            wr_en_WB   = 1;
            wr_data_WB = ALU_MEM_WB;
        end

        // JAL
        if (opcode_MEM == 7'b1101111) begin
            wr_en_WB   = 1;
            wr_data_WB = ALU_MEM_WB;
        end

        // JALR
        if (opcode_MEM == 7'b1100111) begin
            wr_en_WB   = 1;
            wr_data_WB = ALU_MEM_WB;
        end
    end

    // Pipeline registers clocking
    always @(posedge clk or negedge nrst) begin
        if (!nrst) begin
            IMEM_RF      <= 0;
            PC_PC_ID_EXE <= 0;

            // ID/EXE
            REG_RD1      <= 0;
            REG_RD2_1    <= 0;
            IMM_REG      <= 0;
            PC_ID_EXE    <= 0;
            opcode_ID    <= 0;
            rd_ID        <= 0;
            rs1_ID       <= 0;
            rs2_ID       <= 0;
            funct3_ID    <= 0;
            funct7_ID    <= 0;
            wr_en_ID     <= 0;

            // EXE/MEM
            PC_ALU_DMEM  <= 0;
            REG_RD2_2    <= 0;
            PC_EXE_MEM   <= 0;
            opcode_EXE   <= 0;
            rd_EXE       <= 0;
            funct3_EXE   <= 0;
            wr_en_EXE    <= 0;

            // MEM/WB
            ALU_MEM_WB   <= 0;
            SHIFTED_MEM  <= 0;
            PC_MEM_WB    <= 0;
            opcode_MEM   <= 0;
            rd_MEM       <= 0;
            funct3_MEM   <= 0;
            wr_en_MEM    <= 0;

        end else begin

            // IF -> ID
            if (flush) begin
                IMEM_RF      <= 32'h00000000; // Garbage
                PC_PC_ID_EXE <= 0;
            end else if (!stall) begin
                IMEM_RF      <= inst;
                PC_PC_ID_EXE <= pc;
            end

            // ID -> EXE
            if (stall || flush) begin
                // Zero everything way
                REG_RD1      <= 0;
                REG_RD2_1    <= 0;
                IMM_REG      <= 0;
                PC_ID_EXE    <= 0;
                opcode_ID    <= 0;
                rd_ID        <= 0;
                rs1_ID       <= 0;
                rs2_ID       <= 0;
                funct3_ID    <= 0;
                funct7_ID    <= 0;
                wr_en_ID     <= 0;
            end else begin
                REG_RD1      <= reg_rs1;
                REG_RD2_1    <= reg_rs2;
                PC_ID_EXE    <= PC_PC_ID_EXE;
                opcode_ID    <= opcode;
                rd_ID        <= rd;
                rs1_ID       <= rs1;
                rs2_ID       <= rs2;
                funct3_ID    <= funct3;
                funct7_ID    <= funct7;
                wr_en_ID     <= id_writes_reg;
                
                // imm
                if      (opcode == 7'b0100011)
                    IMM_REG  <= imm_s;
                else if (opcode == 7'b1100011)
                    IMM_REG  <= imm_b;
                else if (opcode == 7'b0110111 || opcode == 7'b0010111)
                    IMM_REG  <= imm_u;
                else if (opcode == 7'b1101111)
                    IMM_REG  <= imm_j;
                else
                    IMM_REG  <= imm_i;
            end

            // EXE -> MEM
            PC_ALU_DMEM  <= alu_out;
            REG_RD2_2    <= fwd_rs2; // forwarded!
            PC_EXE_MEM   <= PC_ID_EXE;
            opcode_EXE   <= opcode_ID;
            rd_EXE       <= rd_ID;
            funct3_EXE   <= funct3_ID;
            wr_en_EXE    <= wr_en_ID;

            // MEM -> WB
            ALU_MEM_WB   <= PC_ALU_DMEM;
            SHIFTED_MEM  <= shifted_data;
            PC_MEM_WB    <= PC_EXE_MEM;
            opcode_MEM   <= opcode_EXE;
            rd_MEM       <= rd_EXE;
            funct3_MEM   <= funct3_EXE;
            wr_en_MEM    <= wr_en_EXE;

        end
    end

endmodule
