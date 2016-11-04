`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/23/2016 12:15:24 AM
// Design Name: 
// Module Name: BranchLogic
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


module BranchLogic(rs, zero, branch_cntrl, branch_out);
    input [31:0] rs;
    input [1:0] branch_cntrl;
    input zero;
    output reg branch_out;
    
    always@(rs, branch_cntrl, zero) begin
        case(branch_cntrl)
        
            2'b00: begin    // BGEZ
                branch_out <= ~rs[31];
            end
            
            2'b01: begin    // BLTZ
                branch_out <= rs[31];
            end
            
            2'b10: begin    // BGTZ
                branch_out <= ~rs[31] & ~zero;//($signed(rs) > 32'h00000000);    //I DONT KNOW    was: ~(rs[31] | zero)
            end
            
            2'b11: begin    // BLEZ
                branch_out <= rs[31] | zero;
            end
            
            default: begin
                branch_out <= 0;
            end
            
        endcase
    end
endmodule
