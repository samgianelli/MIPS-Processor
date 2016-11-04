`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2016 02:28:14 PM
// Design Name: 
// Module Name: Datapath
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


module Datapath(Clk, Reset, PC_Counter, Reg_Write, RegWrite_or);
    input Clk, Reset;
    output wire [31:0] PC_Counter;
    output wire [31:0] Reg_Write;
    wire [31:0] IM_out, ReadReg1, ReadReg2; 
    wire [31:0] ALU_out;
    
    //// DEBUGGIN OUTPUTS (set back to normal wires when done)///////////
    output wire RegWrite_or;
    wire  Branch_type, Branch_ineq;
    wire [31:0] Mux_Mem, Mux_regData_HiLo;
    wire [31:0] Mux_regData_Mov;
    wire [31:0] Mux_Branch_out, Mux_JumpType, Mux_Jump;
    
    ///// WIRES BETWEEN MODULES ///////////////    FIXME: re-ordr bit declarations to BEFORE name
    wire [63:0] HiLoAddition;
    wire [31:0] SE_out , Mux_ALU_In;
    wire [31:0] ReadMem;
    wire [31:0] PC_PlusFour, Branch_Shift, regFile_writeData;  //Mux_Mem, Mux_regData_HiLo
    wire [31:0] ALU_hi, Hi, Lo, Lo_in, Hi_in, HiLo_out, Branch_add, Address_to_PC, RsRtReg, HiRsMux, SignExtendOrNot;
    wire [4:0] Mux_RegF_In, Mux_RegF_RdRt;
    wire zero_inv;

       
    ///// CONTROLLER WIRES ////////////////////   
    wire [4:0] ALUOp;
    wire [3:0] MEMop;
    wire [1:0] BRANCHop;
    wire ALUsrc, RegDst, Jump, Branch, MemRead, MemWrite, MemToReg, RegWrite, WriteHi, WriteLo, HiOrLo, HiLoReg, HiLo_sel;
    wire ALU_zero;
    wire Mux_Mov;
    wire compare_out, xnor_out, Mux_Branch, and_mov_out, RsRtMux, HiRsSel; //RegWrite_or
    wire SignExtensionX, SignExtendImmediate;
    wire regAddr_jal, regWrite_jal, JumpType, Branch_sel;
    
    
    
    ///// DATAPATH ////////////////////////////
    
    // Controller Module
    // CURRENT IS NOT CORRECT
    Controller Controller_1(IM_out, ALUOp, ALUSrc, RegDst, Jump, Branch, MemRead, MemWrite, MemToReg, 
        RegWrite, WriteHi, WriteLo, HiOrLo, HiLoReg, MovEn, Movz, SignExtensionX, Add64, HiLo_sel, RsRtMux, 
        HiRsSel, SignExtendImmediate, MEMop, BRANCHop, regAddr_jal, regWrite_jal, JumpType, Branch_sel, zero_sel);
    
    // Instruction Fetch Unit  
    ProgramCounter ProgramCounter_1( Address_to_PC, PC_Counter, Reset, Clk);
    PCAdder PCAdder_1(PC_Counter, PC_PlusFour);
    InstructionMemory InstructionMemory_1(PC_Counter, IM_out);
    
    // RegisterFile Read
    Mux5Bit2To1 Mux5Bit2To1_rdReg(Mux_RegF_RdRt, IM_out[20:16], IM_out[15:11], RegDst);
    Mux5Bit2To1 Mux5Bit2To1_Jal(Mux_RegF_In, Mux_RegF_RdRt, 5'b11111, regAddr_jal);
    RegisterFile RegisterFile_1(IM_out[25:21], IM_out[20:16], Mux_RegF_In, Reg_Write, RegWrite_or, Clk, ReadReg1, ReadReg2);
    SignExtension SignExtension_1(IM_out[15:0], SE_out[31:0]);
    Mux32Bit2To1 Mux32Bit2To1_SignExtendImmediate(SignExtendOrNot, SE_out[31:0] ,{{16{1'b0}},{IM_out[15:0]}} ,SignExtendImmediate );
    Mux32Bit2To1 Mux32Bit2To1_ALUsrc(Mux_ALU_In, ReadReg2, SignExtendOrNot, ALUSrc);
    Mux32Bit2To1 Mux32Bit2To1_RsShift(RsRtReg, ReadReg1, {{27{1'b0}},{IM_out[10:6]}},  RsRtMux);
    
    // RegisterFile Write
    Mux32Bit2To1 Mux32Bit2To1_HiLo(Mux_regData_HiLo, Mux_Mem, HiLo_out, HiLoReg);
    Mux32Bit2To1 Mux32Bit2To1_Mov(Mux_regData_Mov, Mux_regData_HiLo, ReadReg1, MovEn);
    Mux32Bit2To1 Mux32Bit2To1_Jal(Reg_Write, Mux_regData_Mov, PC_PlusFour + 32'h00000000, regWrite_jal);
    
    CompareZero CompareZero_2(ReadReg2,compare_out);
    Xnor2 XNOR2_2(compare_out, Movz, xnor_out); 
    And2 And2_2(xnor_out, MovEn, and_mov_out);   
    Or2 Or2_1(and_mov_out, RegWrite, RegWrite_or);
    
    
    // ALU
    ALU32Bit ALU32Bit_1( ALUOp, RsRtReg, Mux_ALU_In, ALU_out, ALU_hi, ALU_zero);
    Mux1Bit2To1 Mux1Bit2To1_ZeroSel(zero_inv, ALU_zero, ~ALU_zero, zero_sel);
    
    // Hi Lo Registers
    HiLoRegisterFile HiLoRegisterFile_1(Clk, Lo_in, HiRsMux, WriteLo, WriteHi, Hi, Lo);
    Adder64Bit Adder64Bit_1({{Hi},{Lo}}, {{ALU_hi},{ALU_out}}, Add64, HiLoAddition);
    Mux32Bit2To1 Mux32Bit2To1_LoData(Lo_in, ALU_out, HiLoAddition[31:0], HiLo_sel); 
    Mux32Bit2To1 Mux32Bit2To1_HiData(Hi_in, ALU_hi, HiLoAddition[63:32], HiLo_sel);
    Mux32Bit2To1 Mux32Bit2To1_HiRs(HiRsMux, Hi_in, ReadReg1, HiRsSel);
    Mux32Bit2To1 Mux32Bit2To1_HiLoOut(HiLo_out, Lo, Hi, HiOrLo);
    
    // Data Memory Read/Write
    DataMemory DataMemory_1(ALU_out, ReadReg2, Clk, MemWrite, MemRead, ReadMem, MEMop);
    Mux32Bit2To1 Mux32Bit2To1_Mem(Mux_Mem, ALU_out, ReadMem, MemToReg);    //SWAPPED inA and inB TO MATCH CONTROL SIGNAL
    
    // Branch / Jump / +4
    //ShiftLeft2 ShiftLeft2_Jump(Instruction[25:0], Jump_Shift);
    Mux32Bit2To1 Mux32Bit2To1_JumpType(Mux_JumpType, {{PC_PlusFour[31:28]},{IM_out[25:0] << 2}}, ReadReg1, JumpType);
    ShiftLeft2 ShiftLeft2_Branch(SE_out, Branch_Shift);
    Adder32Bit Adder32Bit_Branch(PC_PlusFour, Branch_Shift, Branch_add);
    BranchLogic BranchLogic_1(ALU_out, ALU_zero, BRANCHop, Branch_ineq);
    Mux1Bit2To1 Mux1Bit2To1_Branch_eqIneq(Branch_type, zero_inv, Branch_ineq, Branch_sel);
    And2 And2_Branch(Branch_type, Branch, Mux_Branch);
    Mux32Bit2To1 Mux32Bit2To1_Branch(Mux_Branch_out,PC_PlusFour, Branch_add, Mux_Branch);
    Mux32Bit2To1 Mux32Bit2To1_BranchOrJump(Address_to_PC, Mux_Branch_out, Mux_JumpType, Jump); 
    
    
    
    


endmodule
