`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.05.2024 03:10:34
// Design Name: 
// Module Name: TOP_TuringCrayonCore
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module TOP_TuringCrayonCore(
        output [31:0] inst_addr,
        input sysreset,
        input sysclk,
        input [31:0] instruction,

        input [7:0] dmem_dout,
        output [31:0] dmem_addr,
        output dmem_we,
        output [7:0] dmem_din
    );

    // control signals:
    wire brq;
    wire pc_sel, reg_we, A_sel, B_sel, inst_type, alu_op, funct3, mem_we, wb_we;

    // POGRAM COUNTER
    wire [31:0] alu_result, pc_curr, pc_next;
    Program_counter Program_counter(
        .sysreset(sysreset),
        .sysclk(sysclk),
        .pc_in(alu_result),
        .pc_sel(pc_sel),
        .pc_curr(pc_curr),
        .pc_next(pc_next)
    ); 
    // REGISTER FILE
    Register_file Register_file(
        .sysclk(sysclk),
        .sysreset(sysreset),
        .we(reg_we),
        .rd_addr(instruction[11:7]),
        .
    );

endmodule
