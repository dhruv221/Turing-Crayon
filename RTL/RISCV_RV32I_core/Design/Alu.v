`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// Engineer: Agastasya Dahiya
// 
// Create Date:    13.04.2024 22:49:38
// Design Name:    Alu
// Module Name:    Alu
// Project Name:   RISCV_RV32I_core
// Target Devices: Nexys 4 DDR
// 
// Description: immediate value generator for rv32i 
//                       +---------------------+
//                   rs1-|                     |
//                       |         ALU         |-> rd
//                   rs2-|                     |
//                       +---------------------+
//              depending on the opcode, ALU will perform the following operations:
//              1. ADD, 
//              2. AND, 
//              3. OR,
//              4. SLL, 
//              5. SRA,
//              6. SRL,
//              7. SUB,
//              8. XOR
//
// Dependencies: none
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module Alu(
    input [31:0] rs1,     // Input operand A
    input [31:0] rs2,     // Input operand B
    input [3:0] ALUsel,   // Operation code: 4 bits
    output reg [31:0] rd  // Output result
    );


always @ (rs1, rs2, ALUsel)
begin
    case(ALUsel)
        4'b0000: rd = rs1 + rs2;           // add operation
        4'b0111: rd = rs1 & rs2;           // and operation
        4'b0110: rd = rs1 | rs2;           // or operation
        4'b0001: rd = rs1 << rs2[4:0];     // shift left logical operation
        4'b1101: rd = rs1 >>> rs2[4:0];    // shift right arithmetic operation
        4'b0101: rd = rs1 >> rs2[4:0];     // shift right logical operation
        4'b1000: rd = rs1 + ~(rs2) + 1;    // subtract operation
        4'b0100: rd = rs1 ^ rs2;           // XOR operation

        default: rd = 32'bx; // Default output
    endcase
end

endmodule
