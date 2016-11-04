`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/23/2016 01:06:25 AM
// Design Name: 
// Module Name: Mux1Bit2To1
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


module Mux1Bit2To1(out, inA, inB, sel);
    input inA, inB, sel;
    output reg out;
    
    always@(inA, inB, sel) begin
        case(sel)
            1'b0: out <= inA;
            1'b1: out <= inB;
        endcase
    end
    
    

endmodule
