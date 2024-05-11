`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// Engineer: Dhruv Wadhwa
// 
// Create Date:    10.05.2024 18:17:27
// Design Name:    Control_unit
// Module Name:    Control_unit
// Project Name:   RISCV_RV32I_core
// Target Devices: Nexys 4 DDR
// 
// Description: 
//                        +---------------------+
//                   inst-|                     |-> pc_sel
//                    brq-|                     |-> reg_we
//                        |                     |-> inst_type
//                        |       Control       |-> A_sel
//                        |        unit         |-> B_sel
//                        |                     |-> funct3
//                        |                     |-> funct7_b5
//                        |                     |-> mem_we
//                        |                     |-> wb_sel
//                        |                     |
//                        +---------------------+
//
// Dependencies: none
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Control_unit(
    input [31:0] inst,
    input brq,

    output reg pc_sel,
    output reg reg_we,
    output reg [2:0] inst_type,
    output reg A_sel,
    output reg B_sel,
    output [2:0] funct3,
    output [3:0] alu_op,
    output reg mem_we,
    output reg [1:0] wb_sel
    );

    wire [6:0] op_code;
    assign op_code = inst[6:0];
    assign funct3 = inst[14:12];
    assign alu_op = {inst[30], funct3};

    always @(*) begin
        case (op_code) 
            // R type instruction:
            7'b0110011: begin
                            pc_sel    <= 0;
                            reg_we    <= 1;
                            A_sel     <= 1;
                            B_sel     <= 0;
                            inst_type <= 3'd0;
                            mem_we    <= 0;
                            wb_sel    <= 2'd1;
                        end
            // I type arithmetic instruction:
            7'b0010011: begin
                            pc_sel    <= 0;
                            reg_we    <= 1;                           
                            A_sel     <= 1;
                            B_sel     <= 1;
                            inst_type <= 3'd2;
                            mem_we    <= 0;
                            wb_sel    <= 2'd1;
                        end
            // I type lb instruction:
            7'b0000011: begin
                            pc_sel    <= 0;
                            reg_we    <= 1;
                            A_sel     <= 1;
                            B_sel     <= 1;
                            inst_type <= 3'd2;
                            mem_we    <= 0;
                            wb_sel    <= 2'd1;
                        end 
            // I type jalr instruction:
            7'b1100111: begin
                            pc_sel    <= 1;
                            reg_we    <= 1;
                            A_sel     <= 1;
                            B_sel     <= 1;
                            inst_type <= 3'd2;
                            mem_we    <= 0;
                            wb_sel    <= 2'd0;
                        end              
            // U type lui instruction:
            7'b0110111: begin
                            pc_sel    <= 0;
                            reg_we    <= 1;
                            A_sel     <= 1;
                            B_sel     <= 1;
                            inst_type <= 3'd0;
                            mem_we    <= 0;
                            wb_sel    <= 2'd3;
                        end
            // U type auipc instruction:
            7'b0010111: begin
                            pc_sel    <= 0;
                            reg_we    <= 1;
                            A_sel     <= 0;
                            B_sel     <= 1;
                            inst_type <= 3'd0;
                            mem_we    <= 0;
                            wb_sel    <= 2'd1;
                        end
            // J type jal instruction:
            7'b1101111: begin
                            pc_sel    <= 1;
                            reg_we    <= 1;
                            A_sel     <= 0;
                            B_sel     <= 1;
                            inst_type <= 3'd1;
                            mem_we    <= 0;
                            wb_sel    <= 2'd0;
                        end
            // S type instruction:
            7'b0100011: begin
                            pc_sel    <= 0;
                            reg_we    <= 0;
                            A_sel     <= 1;
                            B_sel     <= 1;
                            inst_type <= 3'd3;
                            mem_we    <= 1;
                            wb_sel    <= 2'd0;
                        end
            // B type instruction:
            7'b1100011: begin
                            if (brq) begin
                                pc_sel    <= 1;
                                reg_we    <= 0;
                                A_sel     <= 0;
                                B_sel     <= 1;
                                inst_type <= 3'd4;
                                mem_we    <= 0;
                                wb_sel    <= 2'd0;
                            end
                            else begin
                                pc_sel    <= 0;
                                reg_we    <= 0;
                                A_sel     <= 0;
                                B_sel     <= 1;
                                inst_type <= 3'd4;
                                mem_we    <= 0;
                                wb_sel    <= 2'd0;
                            end
                        end



            default: begin
                            pc_sel    <= 0;
                            reg_we    <= 1;
                            A_sel     <= 1;
                            B_sel     <= 0;
                            inst_type <= 3'd0;
                            mem_we    <= 0;
                            wb_sel    <= 2'd3;
                        end
        endcase
    end

endmodule
