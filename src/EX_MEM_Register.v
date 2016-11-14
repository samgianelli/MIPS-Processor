`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2016 02:53:30 PM
// Design Name: 
// Module Name: ID_EX_Register
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


module EX_MEM_Register(Clk, MemRead_in, MemRead_out, MemWrite_in, MemWrite_out, MemToReg_in, MemToReg_out, RegWrite_in, RegWrite_out, 
                        WriteHi_in, WriteHi_out, WriteLo_in, WriteLo_out, HiOrLo_in, HiOrLo_out, HiLoReg_in, HiLoReg_out, Add64_in, Add64_out, 
                        HiLoSelect_in, HiLoSelect_out, HiRsSel_in, HiRsSel_out, MEMop_in, MEMop_out, regWrite_jal_in, regWrite_jal_out, 
                        ALU_in, ALU_out, ALU_hi_in, ALU_hi_out, RtRd_in, RtRd_out, Read1_in, Read1_out, Read2_in, Read2_out, PC_in, PC_out);
    input Clk;
    input MemRead_in, MemWrite_in, MemToReg_in, RegWrite_in, WriteHi_in, WriteLo_in, HiOrLo_in, HiLoReg_in, Add64_in, HiLoSelect_in, HiRsSel_in;
    input [3:0] MEMop_in;
    input [31:0] ALU_in, ALU_hi_in;
    
    output reg MemRead_out, MemWrite_out, MemToReg_out, RegWrite_out, WriteHi_out, WriteLo_out, HiOrLo_out, HiLoReg_out, Add64_out, HiLoSelect_out, HiRsSel_out;
    output reg [3:0] MEMop_out;
    output reg [31:0] ALU_out, ALU_hi_out;
    
    input regWrite_jal_in;
    output reg regWrite_jal_out;
    
    input [4:0] RtRd_in;
    output reg [4:0] RtRd_out;
    input [31:0] Read1_in, Read2_in, PC_in;
    output reg [31:0] Read1_out, Read2_out, PC_out;
    
    always@(posedge Clk) begin
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
        Read1_out <= Read1_in;
        Read2_out <= Read2_in;
        PC_out <= PC_in;
    end


endmodule
