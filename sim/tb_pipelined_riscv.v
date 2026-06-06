`timescale 1ns/1ps
`define MEM_DEPTH       4096
`define MEM_WIDTH       8
`define CLK_PERIOD      20
`define ADDR_WIDTH      32
`define WORD_WIDTH      32
`define BYTES_PER_WORD  (`WORD_WIDTH / 8)

module tb_pipelined_riscv ();

    reg                        clk;
    reg                        nrst;
    wire [`ADDR_WIDTH-1:0]     inst_addr;
    wire [`WORD_WIDTH-1:0]     inst;
    wire [`ADDR_WIDTH-1:0]     data_addr;
    wire [`WORD_WIDTH-1:0]     proc_data_in;
    wire [`WORD_WIDTH-1:0]     proc_data_out;
    wire [`BYTES_PER_WORD-1:0] proc_data_mask;
    wire                       data_wr;

    reg [31:0] correct[0:`MEM_DEPTH-1];
    integer i;

    wire VDD;
    wire VSS;

    assign VDD = 1'b1;
    assign VSS = 1'b0;
	
    // =====================================================
    // 🔹 INSTRUCTION MEMORY (inlined)
    // =====================================================
    reg [`MEM_WIDTH-1:0] IMEM [0:`MEM_DEPTH-1];

    initial begin
        $readmemh("instmem.txt", IMEM);
    end

    assign inst = {IMEM[inst_addr+3],
                   IMEM[inst_addr+2],
                   IMEM[inst_addr+1],
                   IMEM[inst_addr]};

    // =====================================================
    // 🔹 DATA MEMORY (inlined)
    // =====================================================
    reg [`MEM_WIDTH-1:0] DMEM [0:`MEM_DEPTH-1];

    initial begin
        $readmemh("datamem.txt", DMEM);
    end

    // write (IDENTICAL behavior)
    always @(posedge clk) begin
        if (data_wr) begin
            if (proc_data_mask[0]) DMEM[data_addr]   <= proc_data_out[7:0];
            if (proc_data_mask[1]) DMEM[data_addr+1] <= proc_data_out[15:8];
            if (proc_data_mask[2]) DMEM[data_addr+2] <= proc_data_out[23:16];
            if (proc_data_mask[3]) DMEM[data_addr+3] <= proc_data_out[31:24];
        end
    end

    // read (IDENTICAL behavior)
    assign proc_data_in = {DMEM[data_addr+3],
                           DMEM[data_addr+2],
                           DMEM[data_addr+1],
                           DMEM[data_addr]};

    // =====================================================
    // 🔹 DUT
    // =====================================================
    pipelined_riscv_hazard UUT (
    `ifdef USE_POWER_PINS
        .VPWR      (VDD),
        .VGND      (VSS),
    `endif
        .clk       (clk),
        .nrst      (nrst),
        .inst_addr (inst_addr),
        .inst      (inst),
        .data_addr (data_addr),
        .data_in   (proc_data_in),
        .data_out  (proc_data_out),
        .data_mask (proc_data_mask),
        .data_wr   (data_wr)
    );

    // =====================================================
    // 🔹 CLOCK
    // =====================================================
    always begin
        #(`CLK_PERIOD/2) clk = ~clk;
    end

    `ifdef ENABLE_SDF
        initial begin
            $sdf_annotate("../final/pipelined_riscv_hazard__nom_tt_025C_1v80.sdf", UUT);
        end
    `endif

    // =====================================================
    // 🔹 TEST FLOW (UNCHANGED)
    // =====================================================
    initial begin
    `ifdef USE_POWER_PINS
        $dumpfile("tb_pipelined_riscv_pls.vcd");
    `else
        $dumpfile("tb_pipelined_riscv.vcd");
    `endif
        $dumpvars(0, tb_pipelined_riscv);

        clk  = 1'b0;
        nrst = 1'b0;

        #(`CLK_PERIOD*10)
        nrst = 1'b1;

        #(`CLK_PERIOD*10000)

        // SAME FORMAT — just DMEM instead of DMEM.memory
        $writememh("datamem_out.txt", DMEM);

        $readmemh("datamem_answer.txt", correct);

        for (i=0; i<1024; i=i+1) begin
			if ({DMEM[4*i+3], DMEM[4*i+2], DMEM[4*i+1], DMEM[4*i]} !== correct[i]) begin
				$display("Mismatch at word %0d | expected=%h got=%h",
						 i+1,
						 correct[i],
						 {DMEM[4*i+3], DMEM[4*i+2], DMEM[4*i+1], DMEM[4*i]});
				
			end
		end
	
		
        $finish;
    end

endmodule

