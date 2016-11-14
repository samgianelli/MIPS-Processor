`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2016 05:32:20 PM
// Design Name: 
// Module Name: HazardDetection
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


module HazardDetection(Clk, IF_ID_RegRs, IF_ID_RegRt, ID_EX_RegRt, ID_EX_MemRead, PCWrite, IF_ID_Write, nop);
    input Clk, ID_EX_MemRead;
    input [4:0] IF_ID_RegRs, IF_ID_RegRt, ID_EX_RegRt;
    output reg PCWrite, IF_ID_Write, nop;
    
    always@(posedge Clk) begin
        if (ID_EX_MemRead & (ID_EX_RegRt == IF_ID_RegRs | ID_EX_RegRt == IF_ID_RegRt)) begin     
            PCWrite <= 1;
            nop <= 1;
            IF_ID_Write <= 0;
        end
        else begin
            PCWrite <= 0;
            nop <= 0;
            IF_ID_Write <= 1;        
        end
    end
    
endmodule
