# Turing-Crayon
Verilog RTL for RV32I - ISA based single cycle RISCV core with separate instruction and data memory and a 640x480 res VGA driver. The system is capable of executing rv32i instructions and drawing 640x480 resolution vga graphics.

The name Turing Crayon was inspired by by Alan Turing and Seymour Cray while mentioning its ability to draw bit mapped vga graphics.

## File Structure
- RTL/RISCV_RV32I_core: rv32i core description
- RTL/VGA_driver: vga driver description
- RTL/Turing_Crayon: integration of RISCV_RV32I_core, VGA_driver.
