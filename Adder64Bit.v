`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2016 12:01:14 AM
// Design Name: 
// Module Name: Adder64Bit
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


module Adder64Bit(A, B, add64, out);
    input [63:0] A, B;
    input add64;
    output reg [63:0] out;
    
    always@(A, B, add64) begin
        if (add64 == 1'b1)
            out <= A + B;
        else 
            out <= A - B;
    end
    
endmodule
