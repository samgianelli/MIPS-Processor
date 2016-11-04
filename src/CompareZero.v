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

module CompareZero(in, out);
    input [31:0] in;
    output reg out;
    
    always@(in) begin
        if (in == 32'h00000000)
            out <= 1'b1;
        else
            out <= 1'b0;
    end
    
endmodule