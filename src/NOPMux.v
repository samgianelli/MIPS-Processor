`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2016 06:53:55 PM
// Design Name: 
// Module Name: NOPMux
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


module NOPMux(nop, ALUOp, MovEn, Movz, MemRead, MemWrite, MemWrite, RegWrite, WriteHi, WriteLo, HiOrLo, HiLoReg, Add64, HiLoSelect, HiRsSel, MEMop, regWrite_jal, RegDst, regAddr_jal, ALUOpNOP, MovEnNOP, MovzNOP, MemReadNOP, MemWriteNOP, MemWriteNOP, RegWriteNOP, WriteHiNOP, WriteLoNOP, HiOrLoNOP, HiLoRegNOP, Add64NOP, HiLoSelectNOP, HiRsSelNOP, MEMopNOP, regWrite_jalNOP, RegDstNOP, regAddr_jalNOP);
    input nop;
    input MovEn, Movz, MemRead, MemWrite, MemWrite, RegWrite, WriteHi, WriteLo, HiOrLo, HiLoReg, Add64, HiLoSelect, HiRsSel, regWrite_jal, RegDst, regAddr_jal;
    input [4:0] ALUOp;
    input [3:0] MEMop;
    output reg [4:0] ALUOpNOP;
    output reg [3:0] MEMopNOP;
    output reg  MovEnNOP, MovzNOP, MemReadNOP, MemWriteNOP, RegWriteNOP, WriteHiNOP, WriteLoNOP, HiOrLoNOP, HiLoRegNOP, Add64NOP, HiLoSelectNOP, HiRsSelNOP, regWrite_jalNOP, RegDstNOP, regAddr_jalNOP;
    
    always@(*) begin
        if (nop == 1) begin
        ALUOpNOP <= ALUOp;
            MovEnNOP <= MovEn;
            MovzNOP <= Movz;
            MemReadNOP <= MemRead;
            MemWriteNOP <= MemWrite;
            RegWriteNOP <= RegWrite;
            WriteHiNOP <= WriteHi;
            WriteLoNOP <= WriteLo;
            HiOrLoNOP <= HiOrLo;
            HiLoRegNOP <= HiLoReg;
            Add64NOP <= Add64;
            HiLoSelectNOP <= HiLoSelect;
            HiRsSelNOP <= HiRsSel;
            MEMopNOP <= MEMop;
            regWrite_jalNOP <= regWrite_jal;
            RegDstNOP <= RegDst;
            regAddr_jalNOP <= regAddr_jal;
        end
        else begin
            ALUOpNOP <= 0;
            MovEnNOP <= 0;
            MovzNOP <= 0;
            MemReadNOP <= 0;
            MemWriteNOP <= 0;
            RegWriteNOP <= 0;
            WriteHiNOP <= 0;
            WriteLoNOP <= 0;
            HiOrLoNOP <= 0;
            HiLoRegNOP <= 0;
            Add64NOP <= 0;
            HiLoSelectNOP <= 0;
            HiRsSelNOP <= 0;
            MEMopNOP <= 0;
            regWrite_jalNOP <= 0;
            RegDstNOP <= 0;
            regAddr_jalNOP <= 0;
        end
    end

endmodule
