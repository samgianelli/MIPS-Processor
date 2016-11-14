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


module InstructionFetch(Clk, Reset, PC_in, Instruction, PC_out, PCWrite);
    input Clk, Reset, PCWrite;
    input [31:0] PC_in;
    output [31:0] Instruction, PC_out;
    
    wire [31:0] PC_Plus4, Address, PCResult;
    
    Mux32Bit2To1 Mux32Bit2To1_PC(Address, PC_Plus4, PC_in, Address);
    ProgramCounter ProgramCounter_1(Address, PCResult, Reset, Clk, PCWrite);
    PCAdder PCAdder_1(PCResult, PC_Plus4);
    InstructionMemory InstructionMemory_1(PCResult, Instruction);


endmodule
