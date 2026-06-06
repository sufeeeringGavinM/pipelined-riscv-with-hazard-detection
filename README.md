# pipelined-riscv-with-hazard-detection
A pipelined 5-stage RISC-V with hazard detection processor simulated in verilog.

final contains the final synthesized-with-LibreLane nom_tt .sdf (for simulating hold, c-q, etc. delays), .pnl.v (for simulating with something gtkwave), and .v (the actual code in verilog) files
lib contains the library files for SKY130
rars contains the external RISC-V simulator I checked against to test correctness
rtl contains the rtl file
sim contains the simulation files

# requirements
The only requirements are IIC-OSIC-TOOLS, which requires Docker. Also, cvc to run the simulation on the synthesized version.
