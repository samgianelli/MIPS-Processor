`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - ALU32Bit_tb.v
// Description - Test the 'ALU32Bit.v' module.
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit_tb(); 

	reg [3:0] ALUControl;   // control bits for ALU operation
	reg [31:0] A, B;	        // inputs

	wire [31:0] ALUResult;	// answer
	wire Zero;	        // Zero=1 if ALUResult == 0

    ALU32Bit u0(
        .ALUControl(ALUControl), 
        .A(A), 
        .B(B), 
        .ALUResult(ALUResult), 
        .Zero(Zero)
    );

	initial begin
	
    /* Please fill in the implementation here... */
	A <= 'd10;
	B <= 'd7;
	ALUControl <= 4'b0010;
	
	#20;
	
	A <= 'd10;
    B <= 'd7;
    ALUControl <= 4'b0110;

	#20;
	
	A <= 'h00000001;
    B <= 'h00000003;
    ALUControl <= 4'b0000;

    #20;
    
	A <= 'h00000001;
    B <= 'h00000004;
    ALUControl <= 4'b0001;

    #20;

	A <= 'd10;
    B <= 'd7;
    ALUControl <= 4'b0111;

	#20;

	A <= 'd5;
    B <= 'd7;
    ALUControl <= 4'b0111;

	#20;
	
	A <= 'd0;
	B <= 'd0;
	ALUControl <= 4'b0000;
	
	#20;
		
	end

endmodule

