`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2016 10:30:44 PM
// Design Name: 
// Module Name: ID_EX
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


module ID_EX(Clk, Read1_in, Read1_out, Read2_in, Read2_out, ALUOp_in, ALUOp_out, MovEn_in, MovEn_out, Movz_in, Movz_out, MemRead_in, MemRead_out, 
    MemWrite_in, MemWrite_out, MemToReg_in, MemToReg_out, RegWrite_in, RegWrite_out, WriteHi_in, WriteHi_out, WriteLo_in, WriteLo_out, HiOrLo_in, 
    HiOrLo_out, HiLoReg_in, HiLoReg_out, Add64_in, Add64_out, HiLoSelect_in, HiLoSelect_out, HiRsSel_in, HiRsSel_out, MEMop_in, MEMop_out, 
    regWrite_jal_in, regWrite_jal_out, rs_in, rs_out, rt_in, rt_out, rd_in, rd_out, RegDst_in, RegDst_out, regAddr_jal_in, 
    regAddr_jal_out, PC_in, PC_out);
    input [31:0] Read1_in, Read2_in;
    input Clk;
    output reg [31:0] Read1_out, Read2_out;
    input [4:0] ALUOp_in;
    input MovEn_in, Movz_in;
    output reg [4:0] ALUOp_out;
    output reg MovEn_out, Movz_out;
    input MemRead_in, MemWrite_in, MemToReg_in, RegWrite_in, WriteHi_in, WriteLo_in, HiOrLo_in, HiLoReg_in, Add64_in, HiLoSelect_in, HiRsSel_in;
    input [3:0] MEMop_in;
    output reg MemRead_out, MemWrite_out, MemToReg_out, RegWrite_out, WriteHi_out, WriteLo_out, HiOrLo_out, HiLoReg_out, Add64_out, HiLoSelect_out, HiRsSel_out;
    output reg [3:0] MEMop_out;
    input regWrite_jal_in;
    output reg regWrite_jal_out;
    input [31:0] rs_in, rt_in, rd_in;
    output reg [31:0] rs_out, rt_out, rd_out; 
    input RegDst_in, regAddr_jal_in;
    output reg RegDst_out, regAddr_jal_out;
    input [31:0] PC_in;
    output reg [31:0] PC_out;
    
    
    always@(posedge Clk) begin  
        Read1_out <= Read1_in;
        Read2_out <= Read2_in;
        ALUOp_out <= ALUOp_in;
        MovEn_out <= MovEn_in;
        Movz_out <= Movz_in;
        MemRead_out <= MemRead_in;
        MemWrite_out <= MemWrite_in;
        MemToReg_out <= MemToReg_in;
        RegWrite_out <= RegWrite_in;
        WriteHi_out <= WriteHi_in;
        WriteLo_out <= WriteLo_in;
        HiOrLo_out <= HiOrLo_in;
        HiLoReg_out <= HiLoReg_in;
        Add64_out <= Add64_in;
        HiLoSelect_out <= HiLoSelect_in;
        HiRsSel_out <= HiRsSel_in;
        MEMop_out <= MEMop_in;
        regWrite_jal_out <= regWrite_jal_in;
        rs_out <= rs_in;
        rt_out <= rt_in;
        rd_out <= rd_in;
        RegDst_out <= RegDst_in;
        regAddr_jal_out <= regAddr_jal_in;
        PC_out <= PC_in;
    end
    
endmodule
