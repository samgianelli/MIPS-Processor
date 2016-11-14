`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2016 03:59:21 PM
// Design Name: 
// Module Name: Mem_WB
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


module Mem_WB(Clk, regWrite_jal_in, regWrite_jal_out, regWrite_in, regWrite_out, PCPlusFour_in, PCPlusFour_out, RegData_in, RegData_out, RegDst_in, RegDst_out);
    input Clk, regWrite_jal_in, regWrite_in, PCPlusFour_in;
    output reg regWrite_jal_out, regWrite_out, PCPlusFour_out;
    input [31:0] RegData_in;
    output reg [31:0] RegData_out;
    input [4:0] RegDst_in;
    output reg [4:0] RegDst_out;
    
    always@(posedge Clk) begin
        regWrite_jal_out <= regWrite_jal_in;
        regWrite_out <= regWrite_in;
        PCPlusFour_out <= PCPlusFour_in;
        RegData_out <= RegData_in;
        RegDst_out <= RegDst_in;
    end 



endmodule
