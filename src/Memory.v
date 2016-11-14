`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2016 02:07:43 PM
// Design Name: 
// Module Name: WriteBack
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


module Memory(Clk, ReadReg1, ReadReg2, MemRead, MemWrite, MemToReg, WriteHi, WriteLo, HiOrLo, HiLoReg, Add64, HiLoSelect, HiRsSel, MEMop, ALU_result, ALU_hi, DEF_HiLo_MUX);
    input Clk;
    input MemRead, MemWrite, MemToReg, WriteHi, WriteLo, HiOrLo, HiLoReg, Add64, HiLoSelect, HiRsSel;
    input [3:0] MEMop;
    input [31:0] ALU_result, ALU_hi, ReadReg1, ReadReg2;
    wire [31:0] ReadData, ALU_MEM_MUX, MemRead, HiLo_out;
    output [31:0] DEF_HiLo_MUX;

    DataMemory DataMemory_1(ALU_result, ReadReg2, Clk, MemWrite, MemRead, ReadData, MEMop);  // copied from module headers, rewrite to match this module input
    MultiplicationUnit MulitplicationUnit_1(Clk, ALU_out, ALU_hi, ReadReg1, WriteLo, WriteHi, Add64, HiLo_sel, HiRsSel, HiOrLo, HiLo_out);
    
    Mux32Bit2To1 Mux32Bit2To1_AluMem(ALU_MEM_MUX, ALU_result, ReadData, MemToReg);
    Mux32Bit2To1 Mux32Bit2To1_DefHiLo(DEF_HiLo_MUX, ALU_MEM_MUX, HiLo_out, HiLoReg);
    

endmodule
