`timescale 1ns/1ps

module riscv_tb;
    parameter CLK_PERIOD = 10;
    logic clk = 1;
    logic rst = 0;
    logic [31:0]inst;
    logic [7:0]dmem_dout = 0;

    logic [31:0] inst_addr;
    logic [31:0]result;
    logic dmem_we;
    logic [31:0]dmem_din;

    // logic funct3_2;
    // logic [4:0] rd_addr;
    // logic [4:0] rs1_addr;
    // logic [4:0] rs2_addr;

    design_1_wrapper dut(
        .sysclk(clk),
        .sysreset(rst),
        .inst(inst),
        .rd_addr(inst[11:7]),
        .rs1_addr(inst[19:15]),
        .rs2_addr(inst[24:20]),
        .dmem_dout(dmem_dout),
        .result(result),
        .funct3_2(inst[14]),
        .dmem_we(dmem_we),
        .dmem_din(dmem_din),
        .inst_addr(inst_addr)
    );

    always #(CLK_PERIOD / 5) clk <= ~clk;
        initial begin
            inst = 32'h00700093;
            #10;
            #10;
            $finish;
    end

endmodule
