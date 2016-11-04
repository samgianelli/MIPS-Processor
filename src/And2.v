`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2016 03:03:05 PM
// Design Name: 
// Module Name: And2
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


module And2(A, B, out);
    input A, B;
    output reg out;    //NOTE MAY NEED TO BE INITIALIZED AS "output reg out;"
    
    always @(A, B) begin
        out <= A & B;
    end

endmodule
