`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - DataMemory_tb.v
// Description - Test the 'DataMemory.v' module.
////////////////////////////////////////////////////////////////////////////////

module DataMemory_tb(); 

    reg     [31:0]  Address;
    reg     [31:0]  WriteData;
    reg             Clk;
    reg             MemWrite;
    reg             MemRead;

    wire [31:0] ReadData;

    DataMemory u0(
        .Address(Address), 
        .WriteData(WriteData), 
        .Clk(Clk), 
        .MemWrite(MemWrite), 
        .MemRead(MemRead), 
        .ReadData(ReadData)
    ); 

	initial begin
		Clk <= 1'b0;
		forever #10 Clk <= ~Clk;
	end

	initial begin
	
    /* Please fill in the implementation here... */
    #40;
    @(posedge Clk);
    #5;
    
    MemRead <= 'b1;
    Address <= 'b0000000000;
    
    #40;
    @(posedge Clk);
    #5;
    
    MemRead <= 'b0;
	Address <= 'b0000000001;
	WriteData <= 32'd32;
	
    #40;
    @(posedge Clk);
    #5;
    
    MemWrite <= 'b1;

    @(posedge Clk);
    #5;
    
    MemWrite <= 'b0;
    MemRead <= 'b1;
    
    #40;
    @(posedge Clk);
    #5;
    
    #50;
    MemRead <= 'b0;
    
	end

endmodule

