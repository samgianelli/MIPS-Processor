`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2016 05:40:07 PM
// Design Name: 
// Module Name: Or2
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


module Or2(A, B, out);
    input A, B;
    output reg out;
    
    always@(A, B) begin
        out <= A | B;
    end
    
endmodule
