`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2016 07:24:07 PM
// Design Name: 
// Module Name: Datapath_tb
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


module Datapath_tb( );
    reg Clk, Reset;
    wire [31:0] PC_Counter;
    wire [31:0] Reg_Write; 
    wire RegWrite_or;
    //wire [31:0] IM_out, ReadReg1, ReadReg2, ALU_out, Mux_Mem, Mux_regData_HiLo;
    
    Datapath Datapath_1(
    .Clk(Clk), 
    .Reset(Reset), 
    .PC_Counter(PC_Counter), 
    .Reg_Write(Reg_Write),
    .RegWrite_or(RegWrite_or)
    );
    
    
	initial begin
        Clk <= 1'b1;
        forever #10 Clk <= ~Clk;
    end    
    
    initial begin 
        Reset <= 1;
        #18;
        Reset <= 0;
        #1;
        Reset <= 1;
        #18;
        //Reset <= 0;
        
        Reset <= 0;
        #2700;
        Reset <= 1;
    end
    
endmodule
