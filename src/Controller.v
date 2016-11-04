`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2016 01:19:08 PM
// Design Name: 
// Module Name: Controller
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


module Controller(Instruction, ALUOp, ALUSrc, RegDst, Jump, Branch, MemRead, MemWrite, MemToReg, RegWrite, WriteHi, WriteLo, HiOrLo, HiLoReg, MovEn, Movz, SignExtension, Add64, HiLoSelect, RsRtMux, HiRsSel, SignExtendImmediate, MEMop, BRANCHop, regAddr_jal, regWrite_jal, JumpType, Branch_sel, zero_sel);
    input [31:0] Instruction;
    output reg [4:0] ALUOp;
    output reg [3:0] MEMop;
    output reg [1:0] BRANCHop;
    output reg ALUSrc, RegDst, Jump, Branch, MemRead, MemWrite, MemToReg, RegWrite, WriteHi, WriteLo, HiOrLo, HiLoReg, MovEn, Movz, SignExtension, Add64, HiLoSelect, RsRtMux, HiRsSel, SignExtendImmediate, regAddr_jal, regWrite_jal, JumpType, Branch_sel, zero_sel;
    
    initial begin
        ALUOp <= 4'b0000;
        ALUSrc <= 0; RegDst <= 0; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; 
        MemToReg <= 0; RegWrite <= 0; WriteHi <= 0; WriteLo <= 0; HiOrLo <= 0; HiLoReg <= 0; SignExtendImmediate <= 0;
        MovEn <= 0; Movz <= 0; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 0; RsRtMux <= 0; HiRsSel <= 0; zero_sel <= 0;
    end
    
    always@(Instruction) begin
        case(Instruction[31:26])    
            6'b000000: begin    //R-Type
			    case(Instruction[5:0])
					6'b100000: begin //add
						ALUOp <= 5'b00010;
						ALUSrc <= 0; RegDst <= 1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1; RsRtMux <= 0; SignExtendImmediate <= 0;
						WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx;  HiRsSel <= 0;
						MEMop <= 4'bxxxx;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'bx; zero_sel <= 1'bx;
					end
					6'b100001: begin //addu 
						ALUOp <= 5'b00010;
						ALUSrc <= 0; RegDst <= 1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1; RsRtMux <= 0; SignExtendImmediate <= 0;
					    WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
					    MEMop <= 4'bxxxx;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'bx; zero_sel <= 1'bx;
					end
					6'b100100: begin //and
                        ALUOp <= 5'b00000;
                        ALUSrc <= 0; RegDst <= 1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1;  RsRtMux <= 0; SignExtendImmediate <= 0;
                        WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx;  HiRsSel <= 0;
                        MEMop <= 4'bxxxx;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'bx; zero_sel <= 1'bx;
                    end
					6'b001000: begin //jr  //TODO
                        ALUOp <= 5'bxxxxx;
                        ALUSrc <= 1'bx; RegDst <= 1'bx; Jump <= 1; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 0;  RsRtMux <= 0; SignExtendImmediate <= 0;
                        WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
                        MEMop <= 4'bxxxx;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b1; Branch_sel <= 1'bx; zero_sel <= 1'bx;
                    end
					6'b010000: begin //mfhi
                        ALUOp <= 5'bxxxxx;
                        ALUSrc <= 1'bx; RegDst <= 1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 1'bx; RegWrite <= 1;  RsRtMux <= 0; SignExtendImmediate <= 0;
                        WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1; HiLoReg <= 1; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
                        MEMop <= 4'bxxxx;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'bx; zero_sel <= 1'bx;
                    end
					6'b010010: begin //mflo
                        ALUOp <= 5'bxxxxx;
                        ALUSrc <= 1'bx; RegDst <= 1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 1'bx; RegWrite <= 1; RsRtMux <= 0;SignExtendImmediate <= 0;
                        WriteHi <= 0; WriteLo <= 0; HiOrLo <= 0; HiLoReg <= 1; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
                        MEMop <= 4'bxxxx;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'bx; zero_sel <= 1'bx;
                    end
					6'b010001: begin //mthi
                        ALUOp <= 5'b00010;
                        ALUSrc <= 0; RegDst <= 0; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 0;  RsRtMux <= 0;SignExtendImmediate <= 0;
                        WriteHi <= 1; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 0; HiRsSel <= 1;
                        MEMop <= 4'bxxxx;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'bx; zero_sel <= 1'bx;
                    end
                    6'b010011: begin //mtlo
                        ALUOp <= 5'b00010;
                        ALUSrc <= 0; RegDst <= 0; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 0;  RsRtMux <= 0;SignExtendImmediate <= 0;
                        WriteHi <= 0; WriteLo <= 1; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 0;  HiRsSel <= 0;
                        MEMop <= 4'bxxxx;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'bx; zero_sel <= 1'bx;
                    end
					6'b011000: begin //mult
                        ALUOp <= 5'b01010;    //CHANGED A LOT IN HERE
                        ALUSrc <= 0; RegDst <= 1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 0;  RsRtMux <= 0;SignExtendImmediate <= 0;
                        WriteHi <= 1; WriteLo <= 1; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'b0;    HiRsSel <= 0;// set HiLoSelect from x to 0, writeHi WriteLo
                        MEMop <= 4'bxxxx;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'bx; zero_sel <= 1'bx;
                    end
                    6'b011001: begin //multu
                        ALUOp <= 5'b01011;
                        ALUSrc <= 0; RegDst <= 1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 0;  RsRtMux <= 0;SignExtendImmediate <= 0;
                        WriteHi <= 1; WriteLo <= 1; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'b0; HiRsSel <= 0;
                        MEMop <= 4'bxxxx;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'bx; zero_sel <= 1'bx;
                    end
					6'b100111: begin //nor
                        ALUOp <= 5'b00100;
                        ALUSrc <= 0; RegDst <= 1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1;  RsRtMux <= 0;SignExtendImmediate <= 0;
                        WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
                        MEMop <= 4'bxxxx;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'bx; zero_sel <= 1'bx;
                    end
                    6'b100101: begin //or
                        ALUOp <= 5'b00001;
                        ALUSrc <= 0; RegDst <= 1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1;  RsRtMux <= 0;SignExtendImmediate <= 0;
                        WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
                        MEMop <= 4'bxxxx;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'bx; zero_sel <= 1'bx;
                    end
                    
					6'b100010: begin //sub
						ALUOp <= 5'b00110;
						ALUSrc <= 0; RegDst <= 1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1;  RsRtMux <= 0;SignExtendImmediate <= 0;
					    WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
					    MEMop <= 4'bxxxx;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'bx; zero_sel <= 1'bx;
					end
					6'b100110: begin //xor
						ALUOp <= 5'b00011;
						ALUSrc <= 0; RegDst <= 1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1;  RsRtMux <= 0;SignExtendImmediate <= 0;
					    WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
					    MEMop <= 4'bxxxx;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'bx; zero_sel <= 1'bx;
					end                
					6'b000000: begin //sll FIX
						ALUOp <= 5'b01000;
						ALUSrc <= 0; RegDst <= 1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1;  RsRtMux <= 1;SignExtendImmediate <= 0;
					    WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
					    MEMop <= 4'bxxxx;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'bx; zero_sel <= 1'bx;
					end 
					6'b000100: begin //sllv FIX
                        ALUOp <= 5'b01000;
                        ALUSrc <= 0; RegDst <= 1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1;  RsRtMux <= 0;SignExtendImmediate <= 0;
                        WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
                        MEMop <= 4'bxxxx;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'bx; zero_sel <= 1'bx;
                    end
					6'b101010: begin //slt
                        ALUOp <= 5'b00111;
                        ALUSrc <= 0; RegDst <= 1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1;  RsRtMux <= 0;SignExtendImmediate <= 0;
                        WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
                        MEMop <= 4'bxxxx;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'bx; zero_sel <= 1'bx;
                    end
					6'b101011: begin //sltu
                        ALUOp <= 5'b00111;
                        ALUSrc <= 0; RegDst <= 1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1;  RsRtMux <= 0;SignExtendImmediate <= 0;
                        WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
                        MEMop <= 4'bxxxx;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'bx; zero_sel <= 1'bx;
                    end 
					6'b000011: begin //sra Fix, make new ALU control signal to append 1s or 0s
    					ALUOp <= 5'b00101;
                        ALUSrc <= 0; RegDst <= 1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1;  RsRtMux <= 1;SignExtendImmediate <= 0;
                        WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
                        MEMop <= 4'bxxxx;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'bx; zero_sel <= 1'bx;
                    end
                    6'b000111: begin //srav TODO
                        ALUOp <= 5'b00101;
                        ALUSrc <= 0; RegDst <= 1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1; RsRtMux <= 0;SignExtendImmediate <= 0;
                        WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
                        MEMop <= 4'bxxxx;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'bx; zero_sel <= 1'bx;
                    end
					6'b001011: begin //movn
                        ALUOp <= 5'b01001;
                        ALUSrc <= 1; RegDst <= 1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 0;  RsRtMux <= 0;SignExtendImmediate <= 0;
                        WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 1; Movz <= 0; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
                        MEMop <= 4'bxxxx;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'bx; zero_sel <= 1'bx;
                    end
                    6'b001010: begin //movz
                        ALUOp <= 5'b00111;
                        ALUSrc <= 0; RegDst <= 1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 0; RsRtMux <= 0;SignExtendImmediate <= 0;
                        WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 1; Movz <= 1; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
                        MEMop <= 4'bxxxx;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'bx; zero_sel <= 1'bx;
                    end                    

					6'b000010: begin //rotr  and srl FIX
					    if (Instruction[21] == 1'b0) begin //If 5'b00000 then srl
					        ALUOp <= 5'b01001;
                            ALUSrc <= 0; RegDst <= 1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1;  RsRtMux <= 1;SignExtendImmediate <= 0;
                            WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
                            MEMop <= 4'bxxxx;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'bx; zero_sel <= 1'bx;
                        end
                        else begin
                            ALUOp <= 5'b01100;
                            ALUSrc <= 0; RegDst <= 1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1; RsRtMux <= 1;SignExtendImmediate <= 0;
                            WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
                            MEMop <= 4'bxxxx;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'bx; zero_sel <= 1'bx;
                        end
                    end     
                    6'b000110: begin //rotrv and srlv FIX
                        if (Instruction[6] == 1'b0) begin   //srlv  
                            ALUOp <= 5'b01001;
                            ALUSrc <= 0; RegDst <= 1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1;  RsRtMux <= 0;SignExtendImmediate <= 0;
                            WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
                            MEMop <= 4'bxxxx;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'bx; zero_sel <= 1'bx;
                        end
                        else begin
                            ALUOp <= 5'b01100;
                            ALUSrc <= 0; RegDst <= 1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1; RsRtMux <= 0;SignExtendImmediate <= 0;
                            WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
                            MEMop <= 4'bxxxx;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'bx; zero_sel <= 1'bx;
                        end
                    end
				endcase
            end
            6'b011100: begin    //R-Type multiplications
                if (Instruction[5:0] == 6'b000000) begin //madd
                    ALUOp <= 5'b01010;
                    ALUSrc <= 0; RegDst <= 1'bx; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 0;  RsRtMux <= 0;SignExtendImmediate <= 0;
                    WriteHi <= 1; WriteLo <= 1; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 1; HiLoSelect <= 1; HiRsSel <= 0;
                    MEMop <= 4'bxxxx;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'bx; zero_sel <= 1'bx;
                end
                else if (Instruction[5:0] == 6'b000010) begin //mul
                    ALUOp <= 5'b01010;
                    ALUSrc <= 0; RegDst <= 1'b1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 1'b0; RegWrite <= 1;  RsRtMux <= 0;SignExtendImmediate <= 0;
                    WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0;  MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
                    MEMop <= 4'bxxxx;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'bx; zero_sel <= 1'bx;
                end
                else begin  //msub
                    ALUOp <= 5'b01010;
                    ALUSrc <= 0; RegDst <= 1'bx; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 0;  RsRtMux <= 0;SignExtendImmediate <= 0;
                    WriteHi <= 1; WriteLo <= 1; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1; HiRsSel <= 0;
                    MEMop <= 4'bxxxx;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'bx; zero_sel <= 1'bx;
                end
            end
            6'b011111: begin    //R-Type seh and seb
                if (Instruction[10:6] == 5'b11000) begin   //seh
                    ALUOp <= 5'b01110;
                    ALUSrc <= 0; RegDst <= 1'b1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1;  RsRtMux <= 0;SignExtendImmediate <= 0;
                    WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 1; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
                    MEMop <= 4'bxxxx;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'bx; zero_sel <= 1'bx;
                end
                else begin   //seb
                    ALUOp <= 5'b01101;
                    ALUSrc <= 0; RegDst <= 1'b1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1;  RsRtMux <= 0;SignExtendImmediate <= 0;
                    WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 1; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
                    MEMop <= 4'bxxxx;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'bx; zero_sel <= 1'bx;
                end
            end
            
            //Immediate   //ADJUSTING ALL RegDst to 1!!!!
            6'b001000: begin    //addi
                ALUOp <= 5'b00010;
                ALUSrc <= 1; RegDst <= 0; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1;  RsRtMux <= 0;SignExtendImmediate <= 0;
                WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
                MEMop <= 4'bxxxx;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'bx; zero_sel <= 1'bx;
            end
            6'b001001: begin    //addiu
                ALUOp <= 5'b00010;
                ALUSrc <= 1; RegDst <= 0; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1;  RsRtMux <= 0;SignExtendImmediate <= 0;
                WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
                MEMop <= 4'bxxxx;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'bx; zero_sel <= 1'bx;
            end
            6'b001100: begin    //andi
                ALUOp <= 5'b00000;
                ALUSrc <= 1; RegDst <= 0; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1;  RsRtMux <= 0;SignExtendImmediate <= 1;
                WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx;   HiRsSel <= 0; 
                MEMop <= 4'bxxxx;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'bx; zero_sel <= 1'bx;
            end
            6'b001101: begin    //ori
                ALUOp <= 5'b00001;
                ALUSrc <= 1; RegDst <= 0; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1;  RsRtMux <= 0;SignExtendImmediate <= 1;
                WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx;  HiRsSel <= 0;   
                MEMop <= 4'bxxxx;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'bx; zero_sel <= 1'bx;
            end
            6'b001110: begin    //xori
                ALUOp <= 5'b00011;
                ALUSrc <= 1; RegDst <= 0; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1;  RsRtMux <= 0;SignExtendImmediate <= 1;
                WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0;  MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
                MEMop <= 4'bxxxx;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'bx; zero_sel <= 1'bx;
            end            
            6'b001010: begin    //slti
                ALUOp <= 5'b00111;
                ALUSrc <= 1; RegDst <= 0; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1;  RsRtMux <= 0;SignExtendImmediate <= 0;
                WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0;  MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
                MEMop <= 4'bxxxx;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'bx; zero_sel <= 1'bx;
            end                     
            6'b001011: begin    //sltiu
                ALUOp <= 5'b00111;
                ALUSrc <= 1; RegDst <= 0; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1;  RsRtMux <= 0;SignExtendImmediate <= 0;
                WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0;MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0;  HiLoSelect <= 1'bx;  HiRsSel <= 0; 
                MEMop <= 4'bxxxx;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'bx; zero_sel <= 1'bx;
            end 
            
            // MEMORY Instructions
            6'b100011: begin    //lw
                ALUOp <= 5'b00010;
                ALUSrc <= 1; RegDst <= 0; Jump <= 0; Branch <= 0; MemRead <= 1; MemWrite <= 0; MemToReg <= 1; RegWrite <= 1;  RsRtMux <= 0; SignExtendImmediate <= 0;
                WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 1'bx; Add64 <= 1'bx;  HiLoSelect <= 1'bx;  HiRsSel <= 1'bx;  
                MEMop <= 4'b0011;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'bx; zero_sel <= 1'bx;
            end 
            6'b101011: begin    //sw
                ALUOp <= 5'b00010;
                ALUSrc <= 1; RegDst <= 0; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 1; MemToReg <= 1'bx; RegWrite <= 0;  RsRtMux <= 0; SignExtendImmediate <= 0;
                WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 1'bx; Add64 <= 1'bx;  HiLoSelect <= 1'bx;  HiRsSel <= 1'bx;
                MEMop <= 4'b1100;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'bx; zero_sel <= 1'bx;
            end 
            6'b101000: begin    //sb
                ALUOp <= 5'b00010;
                ALUSrc <= 1; RegDst <= 0; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 1; MemToReg <= 1'bx; RegWrite <= 0;  RsRtMux <= 0; SignExtendImmediate <= 0;
                WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 1'bx; Add64 <= 1'bx;  HiLoSelect <= 1'bx;  HiRsSel <= 1'bx;
                MEMop <= 4'b0100;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'bx; zero_sel <= 1'bx;
            end 
            6'b100001: begin    //lh
                ALUOp <= 5'b00010;
                ALUSrc <= 1; RegDst <= 0; Jump <= 0; Branch <= 0; MemRead <= 1; MemWrite <= 0; MemToReg <= 1; RegWrite <= 1;  RsRtMux <= 0; SignExtendImmediate <= 0;
                WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 1'bx; Add64 <= 1'bx;  HiLoSelect <= 1'bx;  HiRsSel <= 1'bx;
                MEMop <= 4'b0010;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'bx; zero_sel <= 1'bx;
            end 
            6'b100000: begin    //lb
                ALUOp <= 5'b00010;
                ALUSrc <= 1; RegDst <= 0; Jump <= 0; Branch <= 0; MemRead <= 1; MemWrite <= 0; MemToReg <= 1; RegWrite <= 1;  RsRtMux <= 0; SignExtendImmediate <= 0;
                WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 1'bx; Add64 <= 1'bx;  HiLoSelect <= 1'bx;  HiRsSel <= 1'bx;
                MEMop <= 4'b0001;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'bx; zero_sel <= 1'bx;
            end 
            6'b101001: begin    //sh
                ALUOp <= 5'b00010;
                ALUSrc <= 1; RegDst <= 0; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 1; MemToReg <= 1'bx; RegWrite <= 0;  RsRtMux <= 0; SignExtendImmediate <= 0;
                WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 1'bx; Add64 <= 1'bx;  HiLoSelect <= 1'bx;  HiRsSel <= 1'bx;  
                MEMop <= 4'b1000;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'bx; zero_sel <= 1'bx;
            end 
            6'b001111: begin    //lui
                ALUOp <= 5'b10000;
                ALUSrc <= 1; RegDst <= 0; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1;  RsRtMux <= 0; SignExtendImmediate <= 0;
                WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 1'bx; Add64 <= 1'bx;  HiLoSelect <= 1'bx;  HiRsSel <= 1'bx;
                MEMop <= 4'bxxxx;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'bx; zero_sel <= 1'bx;
            end 
            
            // BRANCH Instructions
            6'b000100: begin    //beq
                ALUOp <= 5'b00110;
                ALUSrc <= 0; RegDst <= 0; Jump <= 0; Branch <= 1; MemRead <= 0; MemWrite <= 0; MemToReg <= 1'bx; RegWrite <= 0;  RsRtMux <= 0; SignExtendImmediate <= 0;
                WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 1'bx; Add64 <= 1'bx;  HiLoSelect <= 1'bx;  HiRsSel <= 1'bx;
                MEMop <= 4'bxxxx;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'b0; zero_sel <= 0;
            end 
            6'b000101: begin    //bne
                ALUOp <= 5'b00110;
                ALUSrc <= 0; RegDst <= 0; Jump <= 0; Branch <= 1; MemRead <= 0; MemWrite <= 0; MemToReg <= 1'bx; RegWrite <= 0;  RsRtMux <= 0; SignExtendImmediate <= 0;
                WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 1'bx; Add64 <= 1'bx;  HiLoSelect <= 1'bx;  HiRsSel <= 1'bx;
                MEMop <= 4'bxxxx;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'b0;  zero_sel <= 1;
            end
            6'b000001: begin
                case(Instruction[20:16])
                    5'b00001: begin    //bgez
                        ALUOp <= 5'b01111;
                        ALUSrc <= 0; RegDst <= 0; Jump <= 0; Branch <= 1; MemRead <= 0; MemWrite <= 0; MemToReg <= 1'bx; RegWrite <= 0;  RsRtMux <= 0; SignExtendImmediate <= 0;
                        WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 1'bx; Add64 <= 1'bx;  HiLoSelect <= 1'bx;  HiRsSel <= 1'bx; 
                        MEMop <= 4'bxxxx;  BRANCHop <= 2'b00; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'b1; zero_sel <= 1'bx;
                    end 
                    5'b00000: begin    //bltz
                        ALUOp <= 5'b01111;
                        ALUSrc <= 0; RegDst <= 0; Jump <= 0; Branch <= 1; MemRead <= 0; MemWrite <= 0; MemToReg <= 1'bx; RegWrite <= 0;  RsRtMux <= 0; SignExtendImmediate <= 0;
                        WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 1'bx; Add64 <= 1'bx;  HiLoSelect <= 1'bx;  HiRsSel <= 1'bx;
                        MEMop <= 4'bxxxx;  BRANCHop <= 2'b01; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'b1; zero_sel <= 1'bx;
                    end 
                endcase
            end
            6'b000111: begin    //bgtz
                ALUOp <= 5'b01111;
                ALUSrc <= 0; RegDst <= 0; Jump <= 0; Branch <= 1; MemRead <= 0; MemWrite <= 0; MemToReg <= 1'bx; RegWrite <= 0;  RsRtMux <= 0; SignExtendImmediate <= 0;
                WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 1'bx; Add64 <= 1'bx;  HiLoSelect <= 1'bx;  HiRsSel <= 1'bx;
                MEMop <= 4'bxxxx;  BRANCHop <= 2'b10; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'b1; zero_sel <= 1'bx;
            end 
            6'b000110: begin    //blez
                ALUOp <= 5'b01111;
                ALUSrc <= 0; RegDst <= 0; Jump <= 0; Branch <= 1; MemRead <= 0; MemWrite <= 0; MemToReg <= 1'bx; RegWrite <= 0;  RsRtMux <= 0; SignExtendImmediate <= 0;
                WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 1'bx; Add64 <= 1'bx;  HiLoSelect <= 1'bx;  HiRsSel <= 1'bx;
                MEMop <= 4'bxxxx;  BRANCHop <= 2'b11; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'b1; zero_sel <= 1'bx;
            end 
            
            //JUMP Instructions
            6'b000010: begin    //j
                ALUOp <= 5'bxxxxx;
                ALUSrc <= 1'bx; RegDst <= 1'bx; Jump <= 1; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 0;  RsRtMux <= 0; SignExtendImmediate <= 0;
                WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 1'bx; Add64 <= 1'bx;  HiLoSelect <= 1'bx;  HiRsSel <= 1'bx;
                MEMop <= 4'bxxxx;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b0; regWrite_jal <= 1'b0; JumpType <= 1'b0; Branch_sel <= 1'bx; zero_sel <= 1'bx;
            end 
            6'b000011: begin    //jal
                ALUOp <= 5'bxxxxx;
                ALUSrc <= 1'bx; RegDst <= 1'bx; Jump <= 1; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1;  RsRtMux <= 0; SignExtendImmediate <= 0;
                WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 1'bx; Add64 <= 1'bx;  HiLoSelect <= 1'bx;  HiRsSel <= 1'bx;
                MEMop <= 4'bxxxx;  BRANCHop <= 2'bxx; regAddr_jal <= 1'b1; regWrite_jal <= 1'b1; JumpType <= 1'b0; Branch_sel <= 1'bx; zero_sel <= 1'bx;
            end 

            default: begin
            ALUOp <= 5'bxxxx;
            ALUSrc <= 1'bx; RegDst <= 1'bx; Jump <= 1'bx; Branch <= 1'bx; MemRead <= 1'bx; MemWrite <= 1'bx; MemToReg <= 1'bx; RegWrite <= 1'bx;  RsRtMux <= 1'bx;SignExtendImmediate <= 1'bx;
            WriteHi <= 1'bx; WriteLo <= 1'bx; HiOrLo <= 1'bx; HiLoReg <= 1'bx; MovEn <= 1'bx; Movz <= 1'bx; SignExtension <= 1'bx; Add64 <= 1'bx; HiLoSelect <= 1'bx; HiRsSel <= 1'bx;
            MEMop <= 4'bxxxx;  BRANCHop <= 2'bxx; regAddr_jal <= 1'bx; regWrite_jal <= 1'bx; JumpType <= 1'bx; Branch_sel <= 1'bx; zero_sel <= 1'bx;
            end

        endcase
    end
endmodule
