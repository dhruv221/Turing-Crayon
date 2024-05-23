`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// Engineer: Agastasya Dahiya
// 
// Create Date:    09.05.2024 19:43:18
// Design Name:    Alu
// Module Name:    Alu
// Project Name:   RISCV_RV32I_core
// Target Devices: Nexys 4 DDR
// 
// Description: alu_op - 3 bits of funct3 and bit 1 bit of funct7 (bit 30 of instruction)
//              as bit 30 of inst differentiates between sra/srl instruction or add/sub
//                        +---------------------+
//                   A_in-|                     |
//                   B_in-|         Alu         |-> result
//                 alu_op-|                     |
//                        +---------------------+
//              depending on the alu_op, ALU will perform the following operations:
//              1. ADD, 
//              2. AND, 
//              3. OR,
//              4. SLL, 
//              5. SRA,
//              6. SRL,
//              7. SUB,
//              8. XOR,
//              9. SLT,
//              10. SLTU
//
// Dependencies: none
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module Alu(
    input [31:0] A_in,        // Input
    input [31:0] B_in,        // Input
    input [3:0] alu_op,       // Operation code: 4 bits
    output reg [31:0] result  // Output result
    );


    always @ (A_in, B_in, alu_op)
    begin
        case(alu_op)
            4'b0000: result = A_in + B_in;                                    // ADD
            4'b0111: result = A_in & B_in;                                    // AND
            4'b0110: result = A_in | B_in;                                    // OR
            4'b0001: result = A_in << B_in[4:0];                              // SLL
            4'b1101: result = $signed(A_in) >>> B_in[4:0];                    // SRA
            4'b0101: result = A_in >> B_in[4:0];                              // SRL
            4'b1000: result = A_in - B_in;                                    // SUB
            4'b0100: result = A_in ^ B_in;                                    // XOR
            4'b0010: result = ($signed(A_in) < $signed(B_in)) ? 1 : 0;        // SLT
            4'b0011: result = (A_in < B_in) ? 1 : 0;                          // SLTU

            default: result = A_in + B_in;                                    // ADD
        endcase
    end

endmodule
