`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2016 05:50:30 PM
// Design Name: 
// Module Name: ForwardingUnit
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


module ForwardingUnit(Clk, ID_EX_Rs, ID_EX_Rt, EX_Mem_RegWrite, EX_Mem_RegRd, Mem_WB_RegWrite, Mem_WB_RegRd, RsForwardingMux, RtForwardingMux);
    input [4:0] ID_EX_Rs, ID_EX_Rt, EX_Mem_RegRd, Mem_WB_RegRd;
    input Clk, EX_Mem_RegWrite, Mem_WB_RegWrite; 
    output reg [1:0] RsForwardingMux, RtForwardingMux;
    
    //For the muxes, 00 is what came from the pipe, 01 is from the EM_Mem stage, and 10 is from the Mem_WB stage.

    always@(posedge Clk) begin
        //Rs
        if (EX_Mem_RegWrite & EX_Mem_RegRd != 0 & EX_Mem_RegRd == ID_EX_Rs)  
            RsForwardingMux <= 2'b01;
        
        else if (Mem_WB_RegWrite & Mem_WB_RegRd != 0 & Mem_WB_RegRd == ID_EX_Rs & ~(EX_Mem_RegWrite & EX_Mem_RegRd != 0 & EX_Mem_RegRd != ID_EX_Rs)) 
            RsForwardingMux <= 2'b10;
        
        else 
            RsForwardingMux <= 2'b00;
        
        //Rt
        if (EX_Mem_RegWrite & EX_Mem_RegRd != 0 & EX_Mem_RegRd == ID_EX_Rt)  
            RtForwardingMux <= 2'b01;
            
        else if (Mem_WB_RegWrite & Mem_WB_RegRd != 0 & Mem_WB_RegRd == ID_EX_Rt & ~(EX_Mem_RegWrite & EX_Mem_RegRd != 0 & EX_Mem_RegRd != ID_EX_Rt))
            RtForwardingMux <= 2'b10;
        
        else
            RtForwardingMux <= 2'b00;
        
    end


endmodule
