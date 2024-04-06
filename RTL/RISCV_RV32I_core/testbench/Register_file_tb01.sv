`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// Engineer: Dhruv Wadhwa
// 
// Create Date: 06.04.2024 20:32:46
// Design Name: Register_file_tb01
// Module Name: Register_file_tb01
// Project Name: RISCV_RV32I_core
// Target Devices: Nexys 4 DDR
// 
// Description: testbench 1 for Register_file.v
// 
// Dependencies: none
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Register_file_tb01;

    parameter CLK_PERIOD = 10;  // Clock period in ns
    logic sysclk = 1;           // Input
    logic sysreset = 0;         // Input
    logic we = 0;               // Input
    logic [4:0] rd_addr = 0;    // Input
    logic [4:0] rs1_addr = 0;   // Input
    logic [4:0] rs2_addr = 0;   // Input
    logic [31:0] rd_data = 0;   // Input
    logic [31:0] rs1;           // Output
    logic [31:0] rs2;           // Output
    
    Register_file dut (         // Instantiate DUT
        .sysclk(sysclk),
        .sysreset(sysreset),
        .we(we),
        .rd_addr(rd_addr),
        .rs1_addr(rs1_addr),
        .rs2_addr(rs2_addr),
        .rd_data(rd_data),
        .rs1(rs1),
        .rs2(rs2)
    );


    always #((CLK_PERIOD / 2)) sysclk <= ~sysclk;   // Clock generation
    initial begin
        //Initialize inputs    
        //t=0ns                               
        sysreset = 1;                               
        we = 0;
        rd_addr = 0;
        rs1_addr = 0;
        rs2_addr = 0;
        rd_data = 0;

        #15;                   
            sysreset = 0;
        #10;
            rs1_addr = 0;
            rs2_addr = 1;
        #10;
            we = 1;
            rd_addr = 31;
            rd_data = 32'hffffffff;
            rs1_addr = 31;
            rs2_addr = 31;

        //End simulation
        #20;    
        $finish;
    end

endmodule
