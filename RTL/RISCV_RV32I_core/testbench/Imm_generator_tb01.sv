`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// Engineer: Dhruv Wadhwa
// 
// Create Date: 10.04.2024 20:32:46
// Design Name: Register_file_tb01
// Module Name: Register_file_tb01
// Project Name: RISCV_RV32I_core
// Target Devices: Nexys 4 DDR
// 
// Description: testbench 1 for Imm_generator.v
// 
// Dependencies: none
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Imm_generator_tb01;

    parameter CLK_PERIOD = 10;  // Clock period in ns
    logic clk = 1;
    logic [31:0] inst;          // input
    logic [2:0]  inst_type;     // input
    logic [31:0] imm_x;         // output

    Imm_generator dut (         // Instantiate DUT
        .inst(inst),
        .inst_type(inst_type),
        .imm_x(imm_x)
    );

    always #((CLK_PERIOD / 2)) clk <= ~clk;   // Clock generation
    initial begin
        //Initialize inputs    
        //t=0ns                               
        inst = 32'hf0e1d2c3;                               
        inst_type = 3'd0;
        #10
           inst_type = 3'd1; 
        #10
           inst_type = 3'd2; 
        #10
           inst_type = 3'd3; 
        #10
           inst_type = 3'd4; 

        //End simulation
        #20;    
        $finish;
    end
endmodule
