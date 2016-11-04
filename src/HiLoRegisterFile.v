`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2016 12:15:48 AM
// Design Name: 
// Module Name: HiLoRegisterFile
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


module HiLoRegisterFile(Clk, write_lo, write_hi, ld_lo, ld_hi, Hi, Lo);  // do we want read_en?
    input Clk;
    input [31:0] write_lo, write_hi;
    input ld_lo, ld_hi;
    output reg [31:0] Hi, Lo;
    
    initial begin
        Hi <= 32'h00000000;
        Lo <= 32'h00000000;
    end
    
    always@(posedge Clk) begin
        if (ld_hi == 1)
            Hi <= write_hi;
        if (ld_lo == 1)
            Lo <= write_lo;
    end
    
    
endmodule
