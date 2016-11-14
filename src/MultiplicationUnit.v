`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2016 02:06:24 PM
// Design Name: 
// Module Name: MultiplicationUnit
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


module MultiplicationUnit(Clk, ALU_out, ALU_hi, ReadReg1, WriteLo, WriteHi, Add64, HiLo_sel, HiRsSel, HiOrLo, HiLo_out);
    input Clk;
    input [31:0] ALU_out, ALU_hi, ReadReg1;    //Data Inputs
    input WriteLo, WriteHi, Add64, HiLo_sel, HiRsSel, HiOrLo;   //Control Inputs
    output [31:0] HiLo_out;
    
    wire [31:0] Hi, Lo, Lo_in, Hi_in, HiRsMux, HiLo_out;
    wire [63:0] HiLoAddition;

    HiLoRegisterFile HiLoRegisterFile_1(Clk, Lo_in, HiRsMux, WriteLo, WriteHi, Hi, Lo);
    Adder64Bit Adder64Bit_1({{Hi},{Lo}}, {{ALU_hi},{ALU_out}}, Add64, HiLoAddition);
    Mux32Bit2To1 Mux32Bit2To1_LoData(Lo_in, ALU_out, HiLoAddition[31:0], HiLo_sel); 
    Mux32Bit2To1 Mux32Bit2To1_HiData(Hi_in, ALU_hi, HiLoAddition[63:32], HiLo_sel);
    Mux32Bit2To1 Mux32Bit2To1_HiRs(HiRsMux, Hi_in, ReadReg1, HiRsSel);
    Mux32Bit2To1 Mux32Bit2To1_HiLoOut(HiLo_out, Lo, Hi, HiOrLo);
    
endmodule
