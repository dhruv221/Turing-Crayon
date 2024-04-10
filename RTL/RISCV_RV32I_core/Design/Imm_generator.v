`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// Engineer: Dhruv Wadhwa
// 
// Create Date:    10.04.2024 17:07:38
// Design Name:    Imm_generator
// Module Name:    Imm_generator
// Project Name:   RISCV_RV32I_core
// Target Devices: Nexys 4 DDR
// 
// Description: immediate value generator for rv32i 
//                       +---------------------+
//                  inst-|                     |-> imm_x
//              imm_type-|        Imm          |
//                       |     generator       |
//                       |                     |
//                       +---------------------+
//              from input instruction it generates different types of imm values:
//              1. imm_U, 
//              2. imm_J, 
//              3. imm_I,
//              4. imm_S, 
//              5. imm_B
// 
// Dependencies: none
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Imm_generator(
    input [31:0] inst,
    input [2:0] inst_type,
    output reg [31:0] imm_x
    );

    //all possible imm declarations
    wire [31:0] imm_U, imm_J, imm_I, imm_S, imm_B;

    // 1. U type     1           2
    assign imm_U = {inst[31:12], 12'd0};
    // 2. J type     1              2            3         4            5
    assign imm_J = {{12{inst[31]}}, inst[19:12], inst[20], inst[30:21], 1'b0};
    // 3. I type     1              2
    assign imm_I = {{20{inst[31]}}, inst[31:20]};
    // 4. S type     1              2            3
    assign imm_S = {{20{inst[31]}}, inst[31:25], inst[11:7]};
    // 5. B type     1              2        3            4           5
    assign imm_B = {{20{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1'b0};

    always @(inst or inst_type)
    begin
        case(inst_type)
            3'd0: imm_x = imm_U; // U type
            3'd1: imm_x = imm_J; // J type
            3'd2: imm_x = imm_I; // I type
            3'd3: imm_x = imm_S; // S type
            3'd4: imm_x = imm_B; // B type
            
            default: imm_x = imm_I; // I type
        endcase
    end

endmodule
