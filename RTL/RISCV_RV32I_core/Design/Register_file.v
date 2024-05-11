`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// Engineer: Agastasya Dahiya
// 
// Create Date:    06.04.2024 17:07:38
// Design Name:    Register_file
// Module Name:    Register_file
// Project Name:   RISCV_RV32I_core
// Target Devices: Nexys 4 DDR
// 
// Description: Regiter File for rv32i 
//                       +---------------------+
//                       |                     |
//                  clk -|                     |-> rs1
//                 reset-|      Register       |-> rs2
//                    we-|       File          |
//               rd_addr-|                     |
//               rd_data-|                     |
//              rs1_addr-|                     |
//              rs2_addr-|                     |
//                       |                     |
//                       +---------------------+
//              at rising clk: if (we) rd=data, if (rst) all register = 0
//              always output rs1 and rs2 data based on rs1 and rs2 address
// 
// Dependencies: none
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Register_file(
    input wire sysclk,          // system clock
    input wire sysreset,        // system reset
    input wire we,              // write enable
    input wire [4:0] rd_addr,   // rd address
    input wire [4:0] rs1_addr,  // rs1 address
    input wire [4:0] rs2_addr,  // rs2 address
    input wire [31:0] rd_data,  // rd  data in
    output wire [31:0] rs1,     // rs1 data out
    output wire [31:0] rs2      // rs2 data out
    );


    reg [31:0] regFile[0:31];

    integer i;
    always @(posedge sysclk) begin
        if (we) begin
            regFile[rd_addr] <= rd_data;
            regFile[0] <= 32'd0;
        end
        
        if (sysreset) begin
            for (i = 0; i < 32; i = i+1)
            regFile[i] <= 0;
        end
    end

    assign rs1 = regFile[rs1_addr];
    assign rs2 = regFile[rs2_addr];

endmodule