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
//                        |                     |-> alu_op
//                        |                     |-> mem_we
//                        |                     |-> wb_sel
//                        |                     |
//                        +---------------------+
//
// 
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
    output reg A_sel,
    output reg B_sel,
    output reg [2:0] inst_type,
    output reg [3:0] alu_op,
    output [2:0] funct3,
    output reg mem_we,
    output reg [1:0] wb_sel
    );

    wire [6:0] op_code;
    assign op_code = inst[6:0];
    assign funct3 = inst[14:12];
    wire funct7b5;
    assign funct7b5 = inst[30];
    //assign alu_op = {inst[30], funct3};

    always @(*) begin
        case (op_code) 
            // lui
            7'b0110111: begin
                            pc_sel    <= 0;
                            reg_we    <= 1;
                            A_sel     <= 1;
                            B_sel     <= 0;
                            inst_type <= 3'd0;
                            alu_op    <= 4'b0000;
                            mem_we    <= 0;
                            wb_sel    <= 2'd2;
                        end

            // auipc
            7'b0010111: begin
                            pc_sel    <= 0;
                            reg_we    <= 1;
                            A_sel     <= 0;
                            B_sel     <= 1;
                            inst_type <= 3'd0;
                            alu_op    <= 4'b0000;
                            mem_we    <= 0;
                            wb_sel    <= 2'd1;
                        end

            // jal
            7'b1101111: begin
                            pc_sel    <= 1;
                            reg_we    <= 1;
                            A_sel     <= 0;
                            B_sel     <= 1;
                            inst_type <= 3'd1;
                            alu_op    <= 4'b0000;
                            mem_we    <= 0;
                            wb_sel    <= 2'd0;
                        end

            // jalr
            7'b1100111: begin
                            pc_sel    <= 1;
                            reg_we    <= 1;
                            A_sel     <= 1;
                            B_sel     <= 1;
                            inst_type <= 3'd2;
                            alu_op    <= 4'b0000;
                            mem_we    <= 0;
                            wb_sel    <= 2'd0;
                        end

            // branch
            7'b1100011: begin
                            case(brq)
                                1'b0:begin
                                        pc_sel    <= 0;
                                        reg_we    <= 0;
                                        A_sel     <= 1;
                                        B_sel     <= 0;
                                        inst_type <= 3'd4;
                                        alu_op    <= 4'b0000;
                                        mem_we    <= 0;
                                        wb_sel    <= 2'd1;
                                    end

                                1'b1:begin
                                        pc_sel    <= 1;
                                        reg_we    <= 0;
                                        A_sel     <= 0;
                                        B_sel     <= 1;
                                        inst_type <= 3'd4;
                                        alu_op    <= 4'b0000;
                                        mem_we    <= 0;
                                        wb_sel    <= 2'd1;
                                    end
                            endcase
                        end

            // load
            7'b0000011: begin
                            pc_sel    <= 0;
                            reg_we    <= 1;
                            A_sel     <= 1;
                            B_sel     <= 1;
                            inst_type <= 3'd2;
                            alu_op    <= 4'b0000;
                            mem_we    <= 0;
                            wb_sel    <= 2'd3;
                        end

            // S-Type
            7'b0100011: begin
                            pc_sel    <= 0;
                            reg_we    <= 0;
                            A_sel     <= 1;
                            B_sel     <= 1;
                            inst_type <= 3'd3;
                            alu_op    <= 4'b0000;
                            mem_we    <= 1;
                            wb_sel    <= 2'd1;
                        end
            // I-Type
            7'b0010011: begin
                            case(funct3)
                                3'b001: begin
                                            pc_sel    <= 0;
                                            reg_we    <= 1;
                                            A_sel     <= 1;
                                            B_sel     <= 1;
                                            inst_type <= 3'd2;
                                            alu_op    <= {funct7b5, funct3};
                                            mem_we    <= 0;
                                            wb_sel    <= 2'd1;
                                        end
                                3'b101: begin
                                            pc_sel    <= 0;
                                            reg_we    <= 1;
                                            A_sel     <= 1;
                                            B_sel     <= 1;
                                            inst_type <= 3'd2;
                                            alu_op    <= {funct7b5, funct3};
                                            mem_we    <= 0;
                                            wb_sel    <= 2'd1;
                                        end
                                default: begin
                                            pc_sel    <= 0;
                                            reg_we    <= 1;
                                            A_sel     <= 1;
                                            B_sel     <= 1;
                                            inst_type <= 3'd2;
                                            alu_op    <= {1'b0, funct3};
                                            mem_we    <= 0;
                                            wb_sel    <= 2'd1;
                                        end
                            endcase
                        end

            // R-Type
            7'b0110011: begin
                            pc_sel    <= 0;
                            reg_we    <= 1;
                            A_sel     <= 1;
                            B_sel     <= 0;
                            inst_type <= 3'd0;
                            alu_op    <= {funct7b5, funct3};
                            mem_we    <= 0;
                            wb_sel    <= 2'd1;
                        end

            default: begin
                            pc_sel    <= 0;
                            reg_we    <= 1;
                            A_sel     <= 1;
                            B_sel     <= 0;
                            inst_type <= 3'd0;
                            alu_op    <= {funct7b5, funct3};
                            mem_we    <= 0;
                            wb_sel    <= 2'd1;
                        end
        endcase
    end

endmodule
