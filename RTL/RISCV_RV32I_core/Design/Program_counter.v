`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// Engineer: Dhruv Wadhwa
// 
// Create Date:    10.05.2024 18:17:27
// Design Name:    Program_counter
// Module Name:    Program_counter
// Project Name:   RISCV_RV32I_core
// Target Devices: Nexys 4 DDR
// 
// Description: Program counter for 32 bit wide instruction memory
//
//                        +---------------------+
//                 sysclk-|                     |
//                        |                     |-> pc_curr
//               sysreset-|                     |
//                        |         PC          |-> pc_next
//                 pc_src-|                     |
//                        |                     |
//                  pc_in-|                     |
//                        +---------------------+
//
// Dependencies: none
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Program_counter(
    input sysclk,          // system clock
    input sysreset,        // system reset
    input [31:0] pc_in,    // pc input value
    input pc_src,          // pc update source select
    output [31:0] pc_curr, // pc current value
    output [31:0] pc_next  // pc next value
    );

    reg [31:0] PC;

    always @(posedge sysclk) begin
        case (pc_src)
            1'b0: PC <= PC + 1;
            1'b1: PC <= pc_in;

            default: PC <= PC + 1;
        endcase

        if (sysreset)
            PC <= 0;
    end

    assign pc_curr = PC;
    assign pc_next = PC + 1;
endmodule
