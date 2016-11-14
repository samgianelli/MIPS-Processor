`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2016 07:17:01 PM
// Design Name: 
// Module Name: InstructionDecode
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


module InstructionDecode(Clk, Instruction, PC_in, regWrite, WriteData, WriteRegister_in, PC_out, Read1, Read2, RsRtMux, ALUSrc, SignExtendImmediate, regAddr_jal, JumpType, Jump, Branch, BRANCHop, Branch_sel, zero_sel);
    input [31:0] Instruction, PC_in, WriteData;
    input [4:0] WriteRegister_in;
    input Clk, regWrite;
    output wire [31:0] PC_out, Read1, Read2;
    
    //Selectors
    input RsRtMux, ALUSrc, SignExtendImmediate, regAddr_jal, JumpType, Jump, Branch_sel, Branch, zero_sel;
    input [1:0] BRANCHop;
    //Wires
    wire [31:0] regRead1, regRead2, SignExtend, SignExtendOrNot, Branch_Shift, Branch_add, Mux_JumpType, Mux_Branch_out;
    wire [4:0] RtRd;
    wire compare_out, zeroFlag;
    
    //RegisterFile
    RegisterFile RegisterFile_1(Instruction[25:21], Instruction[20:16], WriteRegister_in, WriteData, regWrite, Clk, regRead1, regRead2);
    Mux32Bit2To1 Mux32Bit2To1_RsShift(Read1, regRead1, {{27{1'b0}},{Instruction[10:6]}}, RsRtMux);
    Mux32Bit2To1 Mux32Bit2To1_ALUsrc(Read2, regRead2, SignExtendOrNot, ALUSrc);

    //SignExtension
    SignExtension SignExtension_1(Instruction[15:0], SignExtend[31:0]);
    Mux32Bit2To1 Mux32Bit2To1_SignExtendImmediate(SignExtendOrNot, SignExtend[31:0], {{16{1'b0}}, {Instruction[15:0]}}, SignExtendImmediate);
    
    
    //Branch and jump Stuff
    ShiftLeft2 ShiftLeft2_Branch(SignExtendOrNot, Branch_Shift);
    Adder32Bit Adder32Bit_Branch(PC_in, Branch_Shift, Branch_add);
    Mux32Bit2To1 Mux32Bit2To1_Branch(Mux_Branch_out, PC_in, Branch_add, Mux_Branch);
    Mux32Bit2To1 Mux32Bit2To1_JumpType(Mux_JumpType, {{PC_in[31:28]},{Instruction[25:0] << 2}}, regRead1, JumpType);
    Mux32Bit2To1 Mux32Bit2To1_BranchOrJump(PC_out, Mux_Branch_out, Mux_JumpType, Jump); 
    Comparator Comparator_Branch(regRead1, regRead2, zeroFlag);
    Mux1Bit2To1 Mux1Bit2To1_ZeroSel(zero_inv, zeroFlag, ~zeroFlag, zero_sel);    
    BranchLogic BranchLogic_1(regRead1, zeroFlag, BRANCHop, Branch_ineq);
    Mux1Bit2To1 Mux1Bit2To1_Branch_eqIneq(Branch_type, zero_inv, Branch_ineq, Branch_sel);
    And2 And2_Branch(Branch_type, Branch, Mux_Branch);
    
endmodule
