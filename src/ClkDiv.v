`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/17/2016 02:51:19 PM
// Design Name: 
// Module Name: ClkDiv
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


module ClkDiv(Clk_in, Reset, Clk_out);
    input Clk_in, Reset;
    output reg Clk_out;
    
    reg [27:0] Div_val;
    reg [27:0] Div_cnt;
    reg Clk_int;
    
    initial begin
        Div_val <= 'd100000000;   //1310720;
        Clk_int <= 0;
        Div_cnt <= 0;
        Clk_out <= Clk_in;
    end
    
    always@(posedge Clk_in) begin
        if (Reset == 1) begin
            Clk_int <= 0;
            Div_cnt <= 0;
            Clk_out <= 1;
        end
        
        else begin
            if (Div_cnt >= Div_val) begin
                Clk_out <= ~Clk_int;
                Clk_int <= ~Clk_int;
                Div_cnt <= 0;
            end
            else begin
                Clk_out <= Clk_int;
                Clk_int <= Clk_int;
                Div_cnt <= Div_cnt + 1;
            end
        end
    end
        
endmodule
