`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2016 04:11:57 PM
// Design Name: 
// Module Name: Pipeline_Datapath
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


module Pipeline_Datapath(Clk, Reset, PC_Counter, Reg_Write, s1, s2, s3, s4);
    input Clk, Reset;
    output [31:0] PC_Counter, s1, s2, s3, s4;
    output Reg_Write;
    
    wire PCWrite, IF_ID_Write, nop;
    
    //Controller_out
    wire [4:0] ALUOp;
    wire [3:0] MEMop;
    wire [1:0] BRANCHop;
    wire ALUSrcNOP, RegDstNOP, JumpNOP, BranchNOP, MemReadNOP, MemWriteNOP, MemToRegNOP, RegWriteNOP, WriteHiNOP, WriteLoNOP, HiOrLoNOP, HiLoRegNOP, HiLoSelectNOP, ALU_zeroNOP, Mux_MovNOP, compare_outNOP;
    wire xnor_outNOP, Mux_BranchNOP, and_mov_outNOP, RsRtMuxNOP, HiRsSelNOP, SignExtensionXNOP, SignExtendImmediateNOP, regAddr_jalNOP, regWrite_jalNOP, JumpTypeNOP, Branch_selNOP; 
    wire MovEnNOP, MovzNOP, Add64NOP, zero_selNOP;
    wire ALUSrc, RegDst, Jump, Branch, MemRead, MemWrite, MemToReg, RegWrite, WriteHi, WriteLo, HiOrLo, HiLoReg, HiLoSelect, ALU_zero, Mux_Mov, compare_out;
    wire xnor_out, Mux_Branch, and_mov_out, RsRtMux, HiRsSel, SignExtensionX, SignExtendImmediate, regAddr_jal, regWrite_jal, JumpType, Branch_sel; 
    wire MovEn, Movz, Add64, zero_sel;
    

    //InstructionFetch and IF_ID
    wire [31:0] Instruction_IF_in, PC_IF_in;
    //IF_ID to InstructionDecode
    wire [31:0] Instruction_IF_out, PC_IF_out;
    //InstructionDecode to _ID_EX
    wire [31:0] PC_ID_in, Read1_ID_in, Read2_ID_in;
    //ID_EX to Execution
    wire [31:0] Read1_ID_out, Read2_ID_out, PC_ID_out;
    wire [4:0] ALUOp_ID_out, rs_ID_out, rt_ID_out, rd_ID_out;
    wire [3:0] MEMop_ID_out;
    wire MovEn_ID_out, Movz_ID_out, MemRead_ID_out, MemWrite_ID_out, MemToReg_ID_out, RegWrite_ID_out, WriteHi_ID_out, WriteLo_ID_out, HiOrLo_ID_out, 
        HiLoReg_ID_out, Add64_ID_out, HiLoSelect_ID_out, HiRsSel_ID_out, regWrite_jal_ID_out, RegDst_ID_out, regAddr_jal_ID_out;
    //Execution to EX_MEM_Register
    wire [31:0] ALU_EX_in, ALU_EX_hi_in, RtRd_EX_in, ALU_EX_out, ALU_hi_EX_out;
    wire RegWrite_EX_in, MemRead_EX_out, MemWrite_EX_out, MemToReg_EX_out, RegWrite_EX_out, WriteHi_EX_out, WriteLo_EX_out, HiOrLo_EX_out, HiLoReg_EX_out,
        Add64_EX_out, HiLoSelect_EX_out, HiRsSel_EX_out, MEMop_EX_out, regWrite_jal_EX_out;
    wire [4:0] RtRd_EX_out;
    //EX_Mem reg
    wire [31:0] Read1_EX_out, Read2_EX_out, DEF_HiLo_MUX, PC_EX_out;
    //WB
    wire [31:0] PC_WB_out, RegData_WB_out, RegDst_WB_out, WriteData;
    wire [4:0] WriteRegister_in;
    wire regWrite_jal_WB_out, RegWrite_WB_out;
    Controller Controller_1(Instruction_IF_out, ALUOp, ALUSrc, RegDst, Jump, Branch, MemRead, MemWrite, MemToReg, 
                RegWrite, WriteHi, WriteLo, HiOrLo, HiLoReg, MovEn, Movz, SignExtensionX, Add64, HiLoSelect, RsRtMux, 
                HiRsSel, SignExtendImmediate, MEMop, BRANCHop, regAddr_jal, regWrite_jal, JumpType, Branch_sel, zero_sel);
        
    InstructionFetch InstructionFetch_1(Clk, Reset, /**/PC_in, Instruction_IF_in, PC_IF_in, PCWrite);  
    
    IF_ID IF_ID_1(Clk, Instruction_IF_in, Instruction_IF_out, PC_IF_in, PC_IF_out);
    //Pending the ones that come from WB
    InstructionDecode InstructionDecode_1(Clk, Instruction_IF_out, PC_IF_out, RegWrite, /**/WriteData, /**/WriteRegister_in, PC_ID_in, Read1_ID_in, 
        Read2_ID_in, RsRtMux, ALUSrc, SignExtendImmediate, regAddr_jal, JumpType, Jump, Branch, BRANCHop, Branch_sel, zero_sel);
    
    NOPMux NOPMux_1(nop, ALUOp, MovEn, Movz, MemRead, MemWrite, MemWrite, RegWrite, WriteHi, WriteLo, HiOrLo, HiLoReg, Add64, HiLoSelect, HiRsSel, MEMop, regWrite_jal, RegDst, regAddr_jal, 
        ALUOpNOP, MovEnNOP, MovzNOP, MemReadNOP, MemWriteNOP, MemWriteNOP, RegWriteNOP, WriteHiNOP, WriteLoNOP, HiOrLoNOP, HiLoRegNOP, Add64NOP, HiLoSelectNOP, HiRsSelNOP, MEMopNOP, 
        regWrite_jalNOP, RegDstNOP, regAddr_jalNOP);
    
    ID_EX ID_EX_1(Clk, Read1_ID_in, Read1_ID_out, Read2_ID_in, Read2_ID_out, ALUOpNOP, ALUOp_ID_out, MovEnNOP, MovEn_ID_out, MovzNOP, Movz_ID_out, MemReadNOP, 
        MemRead_ID_out, MemWriteNOP, MemWrite_ID_out, MemWriteNOP, MemToReg_ID_out, RegWriteNOP, RegWrite_ID_out, WriteHiNOP, WriteHi_ID_out, WriteLoNOP, WriteLo_ID_out, 
        HiOrLoNOP, HiOrLo_ID_out, HiLoRegNOP, HiLoReg_ID_out, Add64NOP, Add64_ID_out, HiLoSelectNOP, HiLoSelect_ID_out, HiRsSelNOP, HiRsSel_ID_out, MEMopNOP, 
        MEMop_ID_out, regWrite_jalNOP, regWrite_jal_ID_out, Instruction_IF_out[25:21], rs_ID_out, Instruction_IF_out[20:16], rt_ID_out, 
        Instruction_IF_out[15:11], rd_ID_out, RegDstNOP, RegDst_ID_out, regAddr_jal, regAddr_jal_ID_out, PC_ID_in, PC_ID_out);
    
    Execution Execution_1(Read1_ID_out, Read2_ID_out, ALUOp_ID_out, MovEn_ID_out, Movz_ID_out, rt_ID_out, rd_ID_out, ALU_EX_in, ALU_EX_hi_in, RegWrite_ID_out, 
        RegWrite_EX_in, RegDst_ID_out, regAddr_jal_ID_out, RtRd_EX_in);
    
    EX_MEM_Register EX_MEM_Register_1(Clk, MemRead_ID_out, MemRead_EX_out, MemWrite_ID_out, MemWrite_EX_out, MemToReg_ID_out, MemToReg_EX_out, 
        RegWrite_EX_in, RegWrite_EX_out, WriteHi_ID_out, WriteHi_EX_out, WriteLo_ID_out, WriteLo_EX_out, HiOrLo_ID_out, HiOrLo_EX_out, HiLoReg_ID_out, HiLoReg_EX_out, 
        Add64_ID_out, Add64_EX_out, HiLoSelect_ID_out, HiLoSelect_EX_out, HiRsSel_ID_out, HiRsSel_EX_out, MEMop_ID_out, MEMop_EX_out, regWrite_jal_ID_out, 
        regWrite_jal_EX_out, ALU_EX_in, ALU_EX_out, ALU_EX_hi_in, ALU_hi_EX_out, RtRd_EX_in, RtRd_EX_out, Read1_ID_out, Read1_EX_out, Read2_ID_out, Read2_EX_out,
        PC_ID_out, PC_EX_out);
    
    Memory Memory_1(Clk, Read1_EX_out, Read2_EX_out, MemRead_EX_out, MemWrite_EX_out, MemToReg_EX_out, WriteHi_EX_out, WriteLo_EX_out, HiOrLo_EX_out, 
    HiLoReg_EX_out, Add64_EX_out, HiLoSelect_EX_out, HiRsSel_EX_out, MEMop_EX_out, ALU_EX_out, ALU_hi_EX_out, DEF_HiLo_MUX);
    
    Mem_WB Mem_WB_1(Clk, regWrite_jal_EX_out, regWrite_jal_WB_out, RegWrite_EX_out, RegWrite_WB_out, PC_EX_out, PC_WB_out, DEF_HiLo_MUX, WriteData, 
    RtRd_EX_out, RegDst_WB_out);
    
    WriteBack WriteBack_1(RegDst_WB_out, PC_WB_out, regWrite_jal_WB_out, WriteRegister_in);
    
    HazardDetection HazardDetection_1(Clk, Instruction_IF_out[25:21], Instruction_IF_out[20:16], rt_ID_out, MemRead_ID_out, PCWrite, IF_ID_Write, nop);
    
  //  ForwardingUnit ForwardingUnit_1(Clk, ID_EX_Rs, ID_EX_Rt, EX_Mem_RegWrite, EX_Mem_RegRd, Mem_WB_RegWrite, Mem_WB_RegRd, RsForwardingMux, RtForwardingMux);
    
    
endmodule
