`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2016 10:30:44 PM
// Design Name: 
// Module Name: IF_ID
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


module IF_ID(Clk, Instruction_in, Instruction_out, PC_in, PC_out);
    input Clk;
    input [31:0] Instruction_in, PC_in;
    output reg [31:0] Instruction_out, PC_out;
    always@(posedge Clk) begin
            Instruction_out <= Instruction_in;
            PC_out <= PC_in;
    end
endmodule
