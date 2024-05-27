`timescale 1ns/1ps

module riscv_tb;
    parameter CLK_PERIOD = 10;
    // io ports
    logic [31:0] inst_addr;
    logic sysreset = 0;
    logic sysclk = 1;
    logic [31:0] instruction;
    logic [7:0] dmem_dout = 0;
    logic [31:0] dmem_addr;
    logic dmem_we;
    logic [7:0] dmem_din;
    // for debug


    // TOP_TuringCrayonCore dut(
    //     .inst_addr(inst_addr),
    //     .sysreset(sysreset),
    //     .sysclk(sysclk),
    //     .instruction(instruction),
    //     .dmem_dout(dmem_dout),
    //     .dmem_addr(dmem_addr),
    //     .dmem_we(dmem_we),
    //     .dmem_din(dmem_din)
    // );

    // control signals:
    wire brq;
    wire pc_sel, reg_we, A_sel, B_sel;
    wire [2:0] inst_type; 
    wire [3:0] alu_op; 
    wire [2:0] funct3; 
    wire mem_we;
    wire [1:0] wb_sel;

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
    wire [31:0] rd_data, rs1, rs2;
    Register_file Register_file(
        .sysclk(sysclk),
        .sysreset(sysreset),
        .we(reg_we),
        .rd_addr(instruction[11:7]),
        .rd_data(rd_data),
        .rs1_addr(instruction[19:15]),
        .rs2_addr(instruction[24:20]),
        .rs1(rs1),
        .rs2(rs2)
    );
    // IMM GENERATOR
    wire [31:0] imm_x;
    Imm_generator Imm_generator(
        .inst(instruction),
        .inst_type(inst_type),
        .imm_x(imm_x)
    );
    // MUX A
    wire [31:0] A_in, B_in;
    alu_mux alu_mux_A(
        .inp_0(pc_curr),
        .inp_1(rs1),
        .sel(A_sel),
        .alu_in(A_in)
    );
    alu_mux alu_mux_B(
        .inp_0(rs2),
        .inp_1(imm_x),
        .sel(B_sel),
        .alu_in(B_in)
    );
    // ALU
    Alu Alu(
        .A_in(A_in),
        .B_in(B_in),
        .alu_op(alu_op),
        .result(alu_result)
    ); 
    // BRANCH COMPARE
    Branch_compare Branch_compare(
        .rs1(rs1),
        .rs2(rs2),
        .funct3(funct3),
        .brq(brq)
    );
    // WB MUX
    wire [31:0] xdmem_d;
    wb_mux wb_mux(
        .pc_next(pc_next),
        .result(alu_result),
        .imm_x(imm_x),
        .data_out(xdmem_d),
        .wb_sel(wb_sel),
        .rd_data(rd_data)
    );
    // LOAD UNIT
    Load_unit Load_unit(
        .dmem_dout(dmem_dout),
        .funct3_2(funct3[2]),
        .xdmem_d(xdmem_d)
    );

    // CONTROL UNIT
    Control_unit Control_unit(
        .inst(instruction),
        .brq(brq),
        .pc_sel(pc_sel),
        .reg_we(reg_we),
        .A_sel(A_sel),
        .B_sel(B_sel),
        .inst_type(inst_type),
        .alu_op(alu_op),
        .funct3(funct3),
        .mem_we(mem_we),
        .wb_sel(wb_sel)
    );

    always #(CLK_PERIOD / 2) sysclk <= ~sysclk;
        initial begin
                sysreset = 1;
                instruction = 32'h00A00093;
                dmem_dout = 0;
            #10;
                sysreset = 0;
            #10;
                instruction = 32'h000082A3;
            #10;
                instruction = 32'h002081B3;
            // #10;
            //     instruction = 32'h00519213;
            // #10;
            //     instruction = 32'h003262B3;
            // #10;
            //     instruction = 32'h40200333;
            #20;
            $finish;
    end

    assign dmem_addr = alu_result;
    assign dmem_din = rs2[7:0];
    assign dmem_we = mem_we;
    assign inst_addr = pc_curr;
endmodule