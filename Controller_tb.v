`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/11/2016 08:21:29 PM
// Design Name: 
// Module Name: Controller_tb
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


module Controller_tb( );
//Input
	reg [31:0] Instruction;
    reg Clk;

//Output
    wire [3:0] ALUOp;
    wire ALUSrc, RegDst, Jump, Branch, MemRead, MemWrite, MemToReg, RegWrite, WriteHi, WriteLo, HiOrLo, HiLoReg;

//module Controller(Instruction, ALUOp, ALUSrc, RegDst, Jump, Branch, MemRead, MemWrite, MemToReg, RegWrite, WriteHi, WriteLo, HiOrLo, HiLoReg);

    Controller u1(
        .Instruction(Instruction),  
        .ALUOp(ALUOp), 
        .ALUSrc(ALUSrc), 
        .RegDst(RegDst), 
        .Jump(Jump), 
        .Branch(Branch),
        .MemRead(MemRead), 
        .MemWrite(MemWrite), 
        .MemToReg(MemToReg),  
        .RegWrite(RegWrite), 
        .WriteHi(WriteHi), 
        .WriteLo(WriteLo), 
        .HiOrLo(HiOrLo), 
        .HiLoReg(HiLoReg)
    );

	initial begin
		Clk <= 1'b0;
		forever #10 Clk <= ~Clk;
	end

    initial begin
    
        Instruction = 32'b00000000000000000100000000100000; //->	main:	add	$t0, $0, $0
        #20;
        Instruction = 32'b00000000000000000100100000100000; //->		add	$t1, $0, $0
        #20;
        Instruction = 32'b00000001000010010101000000100010; //->		add	$t2, $t0, $t1
        #20;
        Instruction = 32'b01110001001010100100000000000010; // ->		mul	$t0, $t1, $t2
        #20;
        Instruction = 32'b00000001001010100100000000101010; // ->       slt  $t0, $t1, $t2
        #20;
        Instruction = 32'b00000000000000000100000000010000; // ->		mfhi	$t0
        #20;
        Instruction = 32'b00000001000000000000000000010011; // ->       mtlo    $t0
        #20;
        Instruction = 32'b11111111111111111111111111111111; // ->       test
        
    end

endmodule
