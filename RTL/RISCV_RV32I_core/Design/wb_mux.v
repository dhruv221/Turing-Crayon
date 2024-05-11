`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dhruv Wadhwa
// 
// Create Date: 11.05.2024 00:34:24
// Design Name: wb_mux
// Module Name: wb_mux
// Project Name: RISCV_RV32I_core
// Target Devices: Nexys 4 DDR
//
// Description: writeback source selection mux
// 
// Dependencies: none
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module wb_mux(
    input [31:0] pc_next,
    input [31:0] result,
    input [31:0] data_out,
    input [31:0] imm_x,
    input  [1:0] wb_sel,
    output reg [31:0] rd_data
    );

    always @(*) begin
        case (wb_sel)
            2'd0: rd_data <= pc_next;
            2'd1: rd_data <= result;
            2'd2: rd_data <= data_out;
            2'd3: rd_data <= imm_x;

            default: rd_data <= data_out;
        endcase
    end
endmodule
