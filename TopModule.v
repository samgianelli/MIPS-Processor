`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/17/2016 02:37:26 PM
// Design Name: 
// Module Name: TopModule
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


module TopModule(Clk, Reset, out7, en_out);
    input Clk, Reset;
    output wire [6:0] out7;
    output wire [7:0] en_out;
    
    wire [31:0] wire_PC, wire_regW, Write_out, wire_writeData;
    wire wire_regWrite;
    wire Clk_out;
    
    ClkDiv ClkDiv_1(Clk, Reset, Clk_out);
    Datapath Datapath_1(Clk_out, Reset, wire_PC, wire_writeData, wire_regWrite);
    
    Mux32Bit2To1 Mux32Bit2To1_NoDisplay(Write_out, 32'h00000000, wire_writeData, wire_regWrite);
    Two4DigitDisplay Two4DigitDisplay_1(Clk, Clk_out, wire_PC, Write_out, out7, en_out);
    
endmodule
