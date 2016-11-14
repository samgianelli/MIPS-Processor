`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2016 07:14:25 PM
// Design Name: 
// Module Name: Mux1Bit3To1
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


module Mux1Bit3To1(out, inA, inB, inC, sel);
    input inA, inB, inC;
    input [1:0] sel;
    output reg out;
    
    always@(inA, inB, inC, sel) begin
        case(sel)
            2'b00: out <= inA;
            2'b01: out <= inB;
            2'b10: out <= inC;
        endcase
    end
endmodule
