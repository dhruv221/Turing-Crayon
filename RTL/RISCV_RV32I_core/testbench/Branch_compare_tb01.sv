`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Engineer: Dhruv Wadhwa
// 
// Create Date: 14.04.2024 14:30:03
// Design Name: Branch_compare_tb01
// Module Name: Branch_compare_tb01
// Project Name: RISCV_RV32I_core
// Target Devices: Nexys 4 DDR
// 
// Description: testbench 1 for Branch_compare.v
// 
// Dependencies: none
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Branch_compare_tb01;
    parameter CLK_PERIOD = 10;  // Clock period in ns
    logic clk = 1;
    logic [31:0] rs1;           // input
    logic [31:0] rs2;           // input
    logic [2:0] funct3;         // input
    logic brq;                  // input

    Branch_compare dut(         // instantiate DUT
        .rs1(rs1),
        .rs2(rs2),
        .funct3(funct3),
        .brq(brq)
    );

    always #((CLK_PERIOD / 2)) clk <= ~clk;   // Clock generation
    initial begin
        //-----beq-----//
            funct3 = 3'b000;    
            rs1 =  32'd0;       //rs1= 0
            rs2 = -32'd0;       //rs2=-0
        #10;
            rs1 =  32'd10;      //rs1= 10
            rs2 = -32'd10;      //rs2=-10
        
        //-----bne-----//
        #10;
            funct3 = 3'b001;    
            rs1 =  32'd10;      //rs1= 10
            rs2 = -32'd10;      //rs2=-10
        #10;
            rs1 = -32'd10;      //rs1=-10
            rs2 = -32'd10;      //rs2=-10
        
        //-----blt-----//
        #10;
            funct3 = 3'b100;    
            rs1 = -32'd10;      //rs1=-10
            rs2 =  32'd10;      //rs2= 10
        #10;
            rs1 =  32'd10;      //rs1= 10
            rs2 = -32'd10;      //rs2=-10

        //-----bge-----//
        #10;
            funct3 = 3'b101;    
            rs1 =  32'd10;      //rs1= 10
            rs2 = -32'd10;      //rs2=-10
        #10;
            rs1 =  32'd10;      //rs1= 10
            rs2 =  32'd10;      //rs2= 10
        #10;
            rs1 = -32'd10;      //rs1=-10
            rs2 =  32'd10;      //rs2= 10
        
        //-----bltu-----//
        #10;
            funct3 = 3'b110;    
            rs1 =  32'd10;      //rs1= 10
            rs2 =  32'd11;      //rs2= 11
        #10;
            rs1 = -32'd1;       //rs1=-1
            rs2 =  32'd1;       //rs2= 1

        //-----bgeu-----//
        #10;
            funct3 = 3'b111;    
            rs1 =  32'd1;       //rs1= 1
            rs2 = -32'd1;       //rs2=-1
        #10; 
            rs1 =  32'd1;       //rs1= 1
            rs2 =  32'd1;       //rs2= 1
        #10; 
            rs1 = -32'd1;       //rs1=-1
            rs2 =  32'd1;       //rs2= 1
        
        
        //End simulation
        #20;    
        $finish;
    end
endmodule
