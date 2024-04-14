`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Engineer: Dhruv Wadhwa
// 
// Create Date:    13.04.2024 16:42:23
// Design Name:    Branch_compare
// Module Name:    Branch_compare
// Project Name:   RISCV_RV32I_core
// Target Devices: Nexys 4 DDR 
// 
// Description: B type instruction comparison bw rs1 & rs2
//                       +---------------------+
//                   rs1-|                     |-> brq
//                   rs2-|       Branch        |
//                funct3-|      compare        |
//                       |                     |
//                       +---------------------+
//
//              capable of performing:
//              1. beq  - 000
//              2. bne  - 001
//              3. blt  - 100
//              4. bge  - 101
//              5. bltu - 110
//              6. bgeu - 111
// 
// Dependencies: none
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Branch_compare(
    input wire [31:0] rs1,
    input wire [31:0] rs2,
    input wire [2:0] funct3,
    output reg brq
    );

    always @(rs1, rs2, funct3)
    begin
        case(funct3) 
            3'b000: brq = ($signed(rs1) == $signed(rs2)) ? 1 : 0;   //beq
            3'b001: brq = ($signed(rs1) != $signed(rs2)) ? 1 : 0;   //bne
            3'b100: brq = ($signed(rs1) <  $signed(rs2)) ? 1 : 0;   //blt
            3'b101: brq = ($signed(rs1) >= $signed(rs2)) ? 1 : 0;   //bge
            3'b110: brq = (rs1 <  rs2) ? 1 : 0;                     //bltu
            3'b111: brq = (rs1 >= rs2) ? 1 : 0;                     //bgeu

            default: brq = (rs1 == rs1) ? 1 : 0;
        endcase
    end
endmodule
