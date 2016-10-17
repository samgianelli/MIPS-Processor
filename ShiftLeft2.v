`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2016 02:24:20 PM
// Design Name: 
// Module Name: ShiftLeft2
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


module ShiftLeft2(unshifted, shifted);
    input [31:0] unshifted;
    output reg [31:0] shifted ;
    
    always@(unshifted) begin
        shifted <= unshifted << 2;
    end

endmodule
