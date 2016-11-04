`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/23/2016 12:34:21 AM
// Design Name: 
// Module Name: BranchLogic_tb
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


module BranchLogic_tb();

    reg [31:0] rs;
    reg [1:0] branch_cntrl;
    reg zero;
    wire branch_out;  
    //wire [31:0] IM_out, ReadReg1, ReadReg2, ALU_out, Mux_Mem, Mux_regData_HiLo;
    
    BranchLogic BranchLogic_1(
    .rs(rs),
    .branch_cntrl(branch_cntrl),
    .zero(zero),
    .branch_out(branch_out)
    );
    
    initial begin
        
        rs <= 32'h00000001;
        zero <= 0;
        branch_cntrl <= 2'b00;       
        #10;
        branch_cntrl <= 2'b01;
        #10;       
        branch_cntrl <= 2'b10;
        #10;                
        branch_cntrl <= 2'b11;
        #10;
        
        rs <= 32'hffffffff;
        zero <= 0;
        branch_cntrl <= 2'b00;       
        #10;
        branch_cntrl <= 2'b01;
        #10;       
        branch_cntrl <= 2'b10;
        #10;                
        branch_cntrl <= 2'b11;
        #10;
        
        rs <= 32'h00000020;
        zero <= 0;
        branch_cntrl <= 2'b00;       
        #10;
        branch_cntrl <= 2'b01;
        #10;       
        branch_cntrl <= 2'b10;
        #10;                
        branch_cntrl <= 2'b11;
        #10;
        
        rs <= 32'hf0000000;
        zero <= 0;
        branch_cntrl <= 2'b00;       
        #10;
        branch_cntrl <= 2'b01;
        #10;       
        branch_cntrl <= 2'b10;
        #10;                
        branch_cntrl <= 2'b11;
        #10;
        
    end    
    
endmodule
