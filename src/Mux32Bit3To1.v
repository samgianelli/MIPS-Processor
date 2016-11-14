`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2016 12:10:12 PM
// Design Name: 
// Module Name: Mux32Bit3To1
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


module Mux32Bit3To1(out, inA, inB, inC, sel);
    input [31:0] inA, inB, inC;
    input [1:0] sel;
    output reg [31:0] out;
    
    always@(inA, inB, inC, sel) begin
        case(sel)
            2'b00: out <= inA;
            2'b01: out <= inB;
            2'b10: out <= inC;
        endcase
    end
endmodule
