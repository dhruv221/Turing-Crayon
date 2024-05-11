`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// Engineer: Dhruv Wadhwa
// 
// Create Date:    11.05.2024 20:27:58
// Design Name:    Load_unit
// Module Name:    Load_unit
// Project Name:   RISCV_RV32I_core
// Target Devices: Nexys 4 DDR
// 
// Description: sx or zx data mem output based on bit 2 of funct 3
//                       +---------------------+
//             dmem_dout-|                     |-> xdmem_d
//              funct3_2-|       Load          |
//                       |       unit          |
//                       |                     |
//                       +---------------------+
// 
// Dependencies: none
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module Load_unit(
    input [7:0] dmem_dout,
    input funct3_2,
    output reg [31:0] xdmem_d
    );

    wire [31:0] zx_val = {24'd0, dmem_dout[7:0]};
    wire [31:0] sx_val = {{25{dmem_dout[7]}}, dmem_dout[6:0]};

    always @(*) begin
        case (funct3_2)
            1'b0: xdmem_d <= zx_val;
            1'b1: xdmem_d <= sx_val;
        endcase
    end
endmodule
