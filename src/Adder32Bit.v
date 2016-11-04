`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/11/2016 11:53:18 PM
// Design Name: 
// Module Name: XNOR2
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

module Adder32Bit(A, B, out);
    input [31:0] A, B;
    output reg [31:0] out;
    
    always@(A, B) begin
        out <= A + B;
    end
    
endmodule