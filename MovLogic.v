`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2016 12:04:29 AM
// Design Name: 
// Module Name: MovLogic
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


module MovLogic(rt, en, movz, mux_out);
    input rt [31:0], en, movz;
    output mux_out;
    wire compare_out, xnor_out;
    
    CompareZero CompareZero_1(rt, compare_out);
    XNOR2 XNOR2_1(compare_out, movz, xnor_out);
    AND2 AND2_1(xnor_out, en, mux_out);
        
endmodule
