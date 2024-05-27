`timescale 1ns / 1ps


module Data_mem(
    input sysclk, pixel_clk,
    input we_A,
    input [18:0] addr_A, addr_B,
    input [7:0] di_A,
    output [7:0] dout_A,
    output reg [7:0] dout_B
    );

    (*rom_style = "block"*) reg [7:0] Data_mem [0:524287];

    initial
        $readmemh("data_01.mem", Data_mem);
   
    // port A
    always @(negedge sysclk) begin
        if (we_A)
            Data_mem[addr_A] <= di_A;
    end

    assign dout_A = Data_mem[addr_A];

    
    
    // port B
    always @(negedge pixel_clk) begin
        dout_B <= Data_mem[addr_B];
    end
endmodule
