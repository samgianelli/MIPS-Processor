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
	wire [31:0] HiResult;
	wire Zero;	        // Zero=1 if ALUResult == 0

    ALU32Bit u0(
        .ALUControl(ALUControl), 
        .A(A), 
        .B(B), 
        .ALUResult(ALUResult),
        .HiResult(HiResult), 
        .Zero(Zero)
    );

	initial begin
	
    /* Please fill in the implementation here... */
		// MAKE ALL A = 5 (~0101), B = 3 (~0011) TO TEST LOGICAL OPERATIONS AND ARITHMETIC STUFF
	A <= 'd5;
	B <= 'd3;
	ALUControl <= 4'b0000;  //AND
	
	#20;

	ALUControl <= 4'b0001;  //OR
	
	#20;
	
	ALUControl <= 4'b0010;  //ADD
    
    #20;
  
	ALUControl <= 4'b0011;  //XOR
    
    #20;
    
	ALUControl <= 4'b0100;  //NOR
    
    #20;
    A <= -32'd5;
    B <= 'd3;
	ALUControl <= 4'b0101;  //SRA
    
    #20;
    A <= 'd5;
    B <= 'd3;
 	ALUControl <= 4'b0110;  //SUB
    
    #20;
    
	ALUControl <= 4'b0111;  //SLT
    
    #20;
    
	ALUControl <= 4'b1000;  //SLL
    
    #20;
    
	ALUControl <= 4'b1001;  //SRL
    
    #20;
    A <= 32'hffffffff;
    B <= 32'hffffffff;
  	ALUControl <= 4'b1010;  //MUL
    
    #20;
    
	//ALUControl <= 4'b1011;  
    
    //#20;
    A <= 'd5;
    B <= 'd3;
	ALUControl <= 4'b1100;  //ROT Right
    
    #20;
    A <= 32'b00000000000000001011101100000000;
    B <= 32'b00000000000000001011101100000000;
	ALUControl <= 4'b1101;  //SEB
    
    #20;
    
	ALUControl <= 4'b1110;  //SEH
    
    #20;
    
	//ALUControl <= 4'b1111;
    
    //#20;
    
	end

endmodule

