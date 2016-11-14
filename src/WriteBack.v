`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2016 01:54:06 PM
// Design Name: 
// Module Name: WriteBack
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


module WriteBack(RegData_in, PCPlusFour, regWrite_jal, RegData_out);
    input [31:0] RegData_in, PCPlusFour;
    input regWrite_jal;
    output [31:0] RegData_out;
    
    Mux32Bit2To1 Mux32Bit2To1_1xJal(RegData_out, RegData_in, PCPlusFour, regWrite_jal);


endmodule
