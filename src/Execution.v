`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2016 11:08:13 PM
// Design Name: 
// Module Name: Execution
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


module Execution(Read1, Read2, ALUop, MovEn, Movz, rt, rd, ALU_out, ALU_hi, RegWrite_in, RegWrite_out, RegDst, regAddr_jal, WriteRegister_out);
    input [31:0] Read1, Read2;
    input [4:0] ALUop, rt, rd;
    input MovEn, Movz, RegWrite_in, RegDst, regAddr_jal;
    output wire [31:0] ALU_out, ALU_hi;
    output wire RegWrite_out;
    output wire [4:0] WriteRegister_out;
    
    
    wire [31:0] ALU_Mov;
    wire ALU_zero, compare_out, xnor_out, and_mov_out;
    
    //ALU
    ALU32Bit ALU32Bit_1(ALUop, Read1, Read2, ALU_Mov, ALU_hi, ALU_zero);
    
    //Mov Selector
    Mux32Bit2To1 Mux32Bit2To1_Mov(ALU_out, ALU_Mov, Read1, MovEn);
    CompareZero CompareZero_2(Read2, compare_out);
    Xnor2 XNOR2_2(compare_out, Movz, xnor_out); 
    And2 And2_2(xnor_out, MovEn, and_mov_out);   
    Or2 Or2_1(and_mov_out, RegWrite_in, RegWrite_out);
    
    //RtRdJal WriteData
    Mux5Bit2To1 Mux5Bit2To1_rdReg(RtRd, rt, rd, RegDst);
    Mux5Bit2To1 Mux5Bit2To1_Jal(WriteRegister_out, RtRd, 5'b11111, regAddr_jal);
    
endmodule
