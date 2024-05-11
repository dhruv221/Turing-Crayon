`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dhruv Wadhwa
// 
// Create Date: 11.05.2024 00:22:30
// Design Name: alu_mux
// Module Name: alu_mux
// Project Name: RISCV_RV32I_core
// Target Devices: Nexys 4 DDR
//
// Description: Alu source selection mux
// 
// Dependencies: none
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module alu_mux(
    input [31:0] inp_0,
    input [31:0] inp_1,
    input sel,
    output reg [31:0] alu_in
    );

    always @(*) begin
        case (sel)
            1'b0: alu_in <= inp_0;
            1'b1: alu_in <= inp_1;
        endcase
    end
endmodule
