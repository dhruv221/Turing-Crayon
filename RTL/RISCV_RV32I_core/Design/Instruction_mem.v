`timescale 1ns / 1ps
// instruction memory for RISC-V core


module Instruction_mem(
    input [31:0] inst_addr,
    output reg [31:0] instruction
    );

    reg [31:0] Instruction_mem [0:1023];

    initial begin
        $readmemh ("Instruction_mem.mem", Instruction_mem);
    end

    always @(*) begin
        instruction <= Instruction_mem[inst_addr];
    end
endmodule
