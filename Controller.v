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


module Controller(Instruction, ALUOp, ALUSrc, RegDst, Jump, Branch, MemRead, MemWrite, MemToReg, RegWrite, WriteHi, WriteLo, HiOrLo, HiLoReg, MovEn, Movz, SignExtension, Add64, HiLoSelect, RsRtMux, HiRsSel, SignExtendImmediate);
    input [31:0] Instruction;
    output reg [3:0] ALUOp;
    output reg ALUSrc, RegDst, Jump, Branch, MemRead, MemWrite, MemToReg, RegWrite, WriteHi, WriteLo, HiOrLo, HiLoReg, MovEn, Movz, SignExtension, Add64, HiLoSelect, RsRtMux, HiRsSel, SignExtendImmediate;
    
    initial begin
        ALUOp <= 4'b0000;
        ALUSrc <= 0; RegDst <= 0; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; 
        MemToReg <= 0; RegWrite <= 0; WriteHi <= 0; WriteLo <= 0; HiOrLo <= 0; HiLoReg <= 0; SignExtendImmediate <= 0;
        MovEn <= 0; Movz <= 0; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 0; RsRtMux <= 0; HiRsSel <= 0;
    end
    
    always@(Instruction) begin
        case(Instruction[31:26])    
            6'b000000: begin    //R-Type
			    case(Instruction[5:0])
					6'b100000: begin //add
						ALUOp <= 4'b0010;
						ALUSrc <= 0; RegDst <= 1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1; RsRtMux <= 0; SignExtendImmediate <= 0;
						WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx;  HiRsSel <= 0;
					end
					6'b100001: begin //addu 
						ALUOp <= 4'b0010;
						ALUSrc <= 0; RegDst <= 1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1; RsRtMux <= 0; SignExtendImmediate <= 0;
					    WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
					end
					6'b100100: begin //and
                        ALUOp <= 4'b0000;
                        ALUSrc <= 0; RegDst <= 1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1;  RsRtMux <= 0; SignExtendImmediate <= 0;
                        WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx;  HiRsSel <= 0;
                    end
					6'b001000: begin //jr  //TODO
                        ALUOp <= 4'b0000;
                        ALUSrc <= 0; RegDst <= 1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1;  RsRtMux <= 0;SignExtendImmediate <= 0;
                        WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
                    end
					6'b010000: begin //mfhi
                        ALUOp <= 4'bxxxx;
                        ALUSrc <= 1'bx; RegDst <= 1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 1'bx; RegWrite <= 1;  RsRtMux <= 0; SignExtendImmediate <= 0;
                        WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1; HiLoReg <= 1; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
                    end
					6'b010010: begin //mflo
                        ALUOp <= 4'bxxxx;
                        ALUSrc <= 1'bx; RegDst <= 1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 1'bx; RegWrite <= 1; RsRtMux <= 0;SignExtendImmediate <= 0;
                        WriteHi <= 0; WriteLo <= 0; HiOrLo <= 0; HiLoReg <= 1; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
                    end
					6'b010001: begin //mthi
                        ALUOp <= 4'b0010;
                        ALUSrc <= 0; RegDst <= 0; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 0;  RsRtMux <= 0;SignExtendImmediate <= 0;
                        WriteHi <= 1; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 0; HiRsSel <= 1;
                    end
                    6'b010011: begin //mtlo
                        ALUOp <= 4'b0010;
                        ALUSrc <= 0; RegDst <= 0; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 0;  RsRtMux <= 0;SignExtendImmediate <= 0;
                        WriteHi <= 0; WriteLo <= 1; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 0;  HiRsSel <= 0;
                    end
					6'b011000: begin //mult
                        ALUOp <= 4'b1010;    //CHANGED A LOT IN HERE
                        ALUSrc <= 0; RegDst <= 1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 0;  RsRtMux <= 0;SignExtendImmediate <= 0;
                        WriteHi <= 1; WriteLo <= 1; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'b0;    HiRsSel <= 0;// set HiLoSelect from x to 0, writeHi WriteLo
                    end
                    6'b011001: begin //multu
                        ALUOp <= 4'b1011;
                        ALUSrc <= 0; RegDst <= 1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 0;  RsRtMux <= 0;SignExtendImmediate <= 0;
                        WriteHi <= 1; WriteLo <= 1; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'b0; HiRsSel <= 0;
                    end
					6'b100111: begin //nor
                        ALUOp <= 4'b0100;
                        ALUSrc <= 0; RegDst <= 1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1;  RsRtMux <= 0;SignExtendImmediate <= 0;
                        WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
                    end
                    6'b100101: begin //or
                        ALUOp <= 4'b0001;
                        ALUSrc <= 0; RegDst <= 1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1;  RsRtMux <= 0;SignExtendImmediate <= 0;
                        WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
                    end
                    
					6'b100010: begin //sub
						ALUOp <= 4'b0110;
						ALUSrc <= 0; RegDst <= 1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1;  RsRtMux <= 0;SignExtendImmediate <= 0;
					    WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
					end
					6'b100110: begin //xor
						ALUOp <= 4'b0011;
						ALUSrc <= 0; RegDst <= 1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1;  RsRtMux <= 0;SignExtendImmediate <= 0;
					    WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
					end                
					6'b000000: begin //sll FIX
						ALUOp <= 4'b1000;
						ALUSrc <= 0; RegDst <= 1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1;  RsRtMux <= 1;SignExtendImmediate <= 0;
					    WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
					end 
					6'b000100: begin //sllv FIX
                        ALUOp <= 4'b1000;
                        ALUSrc <= 0; RegDst <= 1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1;  RsRtMux <= 0;SignExtendImmediate <= 0;
                        WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
                    end
					6'b101010: begin //slt
                        ALUOp <= 4'b0111;
                        ALUSrc <= 0; RegDst <= 1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1;  RsRtMux <= 0;SignExtendImmediate <= 0;
                        WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
                    end
					6'b101011: begin //sltu
                        ALUOp <= 4'b0111;
                        ALUSrc <= 0; RegDst <= 1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1;  RsRtMux <= 0;SignExtendImmediate <= 0;
                        WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
                    end 
					6'b000011: begin //sra Fix, make new ALU control signal to append 1s or 0s
    					ALUOp <= 4'b0101;
                        ALUSrc <= 0; RegDst <= 1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1;  RsRtMux <= 1;SignExtendImmediate <= 0;
                        WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
                    end
                    6'b000111: begin //srav TODO
                        ALUOp <= 4'b0101;
                        ALUSrc <= 0; RegDst <= 1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1; RsRtMux <= 0;SignExtendImmediate <= 0;
                        WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
                    end
					6'b001011: begin //movn
                        ALUOp <= 4'b1001;
                        ALUSrc <= 1; RegDst <= 1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 0;  RsRtMux <= 0;SignExtendImmediate <= 0;
                        WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 1; Movz <= 0; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
                    end
                    6'b001010: begin //movz
                        ALUOp <= 4'b0111;
                        ALUSrc <= 0; RegDst <= 1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 0; RsRtMux <= 0;SignExtendImmediate <= 0;
                        WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 1; Movz <= 1; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
                    end                    

					6'b000010: begin //rotr  and srl FIX
					    if (Instruction[21] == 1'b0) begin //If 5'b00000 then srl
					        ALUOp <= 4'b1001;
                            ALUSrc <= 0; RegDst <= 1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1;  RsRtMux <= 1;SignExtendImmediate <= 0;
                            WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
                        end
                        else begin
                            ALUOp <= 4'b1100;
                            ALUSrc <= 0; RegDst <= 1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1; RsRtMux <= 1;SignExtendImmediate <= 0;
                            WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
                        end
                    end     
                    6'b000110: begin //rotrv and srlv FIX
                        if (Instruction[6] == 1'b0) begin   //srlv  
                            ALUOp <= 4'b1001;
                            ALUSrc <= 0; RegDst <= 1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1;  RsRtMux <= 0;SignExtendImmediate <= 0;
                            WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
                        end
                        else begin
                            ALUOp <= 4'b1100;
                            ALUSrc <= 0; RegDst <= 1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1; RsRtMux <= 0;SignExtendImmediate <= 0;
                            WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
                        end
                    end
				endcase
            end
            6'b011100: begin    //R-Type multiplications
                if (Instruction[5:0] == 6'b000000) begin //madd
                    ALUOp <= 4'b1010;
                    ALUSrc <= 0; RegDst <= 1'bx; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 0;  RsRtMux <= 0;SignExtendImmediate <= 0;
                    WriteHi <= 1; WriteLo <= 1; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 1; HiLoSelect <= 1; HiRsSel <= 0;
                end
                else if (Instruction[5:0] == 6'b000010) begin //mul
                    ALUOp <= 4'b1010;
                    ALUSrc <= 0; RegDst <= 1'b1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 1'b0; RegWrite <= 1;  RsRtMux <= 0;SignExtendImmediate <= 0;
                    WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0;  MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
                end
                else begin  //msub
                    ALUOp <= 4'b1010;
                    ALUSrc <= 0; RegDst <= 1'bx; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 0;  RsRtMux <= 0;SignExtendImmediate <= 0;
                    WriteHi <= 1; WriteLo <= 1; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1; HiRsSel <= 0;
                end
            end
            6'b011111: begin    //R-Type seh and seb
                if (Instruction[10:6] == 5'b11000) begin   //seh
                    ALUOp <= 4'b1110;
                    ALUSrc <= 0; RegDst <= 1'b1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1;  RsRtMux <= 0;SignExtendImmediate <= 0;
                    WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 1; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
                end
                else begin   //seb
                    ALUOp <= 4'b1101;
                    ALUSrc <= 0; RegDst <= 1'b1; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1;  RsRtMux <= 0;SignExtendImmediate <= 0;
                    WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 1; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
                end
            end
            
            //Immediate   //ADJUSTING ALL RegDst to 1!!!!
            6'b001000: begin    //addi
                ALUOp <= 4'b0010;
                ALUSrc <= 1; RegDst <= 0; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1;  RsRtMux <= 0;SignExtendImmediate <= 0;
                WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
            end
            6'b001001: begin    //addiu
                ALUOp <= 4'b0010;
                ALUSrc <= 1; RegDst <= 0; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1;  RsRtMux <= 0;SignExtendImmediate <= 0;
                WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;    
            end
            6'b001100: begin    //andi
                ALUOp <= 4'b1111;
                ALUSrc <= 1; RegDst <= 0; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1;  RsRtMux <= 0;SignExtendImmediate <= 1;
                WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx;   HiRsSel <= 0;       
            end
            6'b001101: begin    //ori
                ALUOp <= 4'b0001;
                ALUSrc <= 1; RegDst <= 0; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1;  RsRtMux <= 0;SignExtendImmediate <= 1;
                WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0; MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx;  HiRsSel <= 0;    
            end
            6'b001110: begin    //xori
                ALUOp <= 4'b0011;
                ALUSrc <= 1; RegDst <= 0; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1;  RsRtMux <= 0;SignExtendImmediate <= 1;
                WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0;  MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
            end            
            6'b001010: begin    //slti
                ALUOp <= 4'b0111;
                ALUSrc <= 1; RegDst <= 0; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1;  RsRtMux <= 0;SignExtendImmediate <= 0;
                WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0;  MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0; HiLoSelect <= 1'bx; HiRsSel <= 0;
            end                     
            6'b001011: begin    //sltiu
                ALUOp <= 4'b0111;
                ALUSrc <= 1; RegDst <= 0; Jump <= 0; Branch <= 0; MemRead <= 0; MemWrite <= 0; MemToReg <= 0; RegWrite <= 1;  RsRtMux <= 0;SignExtendImmediate <= 0;
                WriteHi <= 0; WriteLo <= 0; HiOrLo <= 1'bx; HiLoReg <= 0;MovEn <= 0; Movz <= 1'bx; SignExtension <= 0; Add64 <= 0;  HiLoSelect <= 1'bx;  HiRsSel <= 0;         
            end 
            default: begin
            ALUOp <= 4'bxxxx;
            ALUSrc <= 1'bx; RegDst <= 1'bx; Jump <= 1'bx; Branch <= 1'bx; MemRead <= 1'bx; MemWrite <= 1'bx; MemToReg <= 1'bx; RegWrite <= 1'bx;  RsRtMux <= 1'bx;SignExtendImmediate <= 1'bx;
            WriteHi <= 1'bx; WriteLo <= 1'bx; HiOrLo <= 1'bx; HiLoReg <= 1'bx; MovEn <= 1'bx; Movz <= 1'bx; SignExtension <= 1'bx; Add64 <= 1'bx; HiLoSelect <= 1'bx; HiRsSel <= 1'bx;
            end
        endcase
        if (Instruction[31:27] == 5'b00001) begin   // J-Type
        end
        
    end

endmodule
