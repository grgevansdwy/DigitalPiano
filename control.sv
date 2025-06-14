module control(instruction, Reg2Loc, Uncondbranch, Branch, MemtoReg, ALUOp, MemRead, 
MemWrite, ALUSrc, RegWrite, immIn, link, BReg, branch0, setFlag);
	input logic [31:0] instruction;
	output logic Reg2Loc, Uncondbranch, Branch, MemtoReg, MemRead, MemWrite, ALUSrc, RegWrite, link, BReg, branch0, setFlag;
	output logic [31:0] immIn;
	output logic [2:0] ALUOp;
				
	always_comb begin	
		{Reg2Loc, Uncondbranch, Branch, MemtoReg, MemRead, MemWrite, ALUSrc, RegWrite, link, BReg, branch0, setFlag} = 10'd0;
		ALUOp = 3'b000;
		
		casez(instruction[31:21])
		11'b1001000100?:			begin					//ADDI
											ALUSrc = 1;
											RegWrite = 1;
											MemtoReg = 0;
											ALUOp = 3'b010;
											MemRead = 0;
											MemWrite = 0;
											immIn = {{20{1'b0}}, instruction[21:10]};
											Uncondbranch = 0;
											Branch = 0;
											link = 0;
										end
										
		11'b000101?????:			begin					//B Imm (same as Branch Uncond?)
											ALUSrc = 1;
											Uncondbranch = 1;
											immIn = {{6{instruction[25]}}, instruction[25:0]};
											RegWrite = 0;
											MemWrite = 0;
											link = 0;
										end
		
		11'b11111000010:			begin					//LDUR 
											ALUSrc = 1;
											MemRead = 1;
											Branch = 0;
											Uncondbranch = 0;
											MemtoReg = 1;
											ALUOp = 3'b010;
											RegWrite = 1;
											MemWrite = 0;
											immIn = {{23{instruction[20]}}, instruction[20:12]};
											link = 0;
										end
										
		11'b11111000000:			begin					//STUR
											ALUOp = 3'b010;
											RegWrite = 0;
											ALUSrc = 1;
											Branch = 0;
											Uncondbranch = 0;
											MemWrite = 1;
											immIn = {{23{instruction[20]}}, instruction[20:12]};
											Reg2Loc = 1;
											link = 0;
										end
							
		11'b10101011000: 			begin					//ADDS
											ALUOp = 3'b010;
											Reg2Loc = 0;
											ALUSrc = 0;
											Uncondbranch = 0;
											Branch = 0;
											RegWrite = 1;
											MemWrite = 0;
											MemRead = 0;
											link = 0;
											setFlag = 1;
										end
										
		11'b11101011000: 			begin					//SUBS
											ALUOp = 3'b011;
											Reg2Loc = 0;
											ALUSrc = 0;
											Uncondbranch = 0;
											Branch = 0;
											RegWrite = 1;
											MemWrite = 0;
											MemRead = 0;
											link = 0;
											setFlag = 1;
										end
										
		11'b10110100???:			begin 				//CBZ Ask TA
											Branch = 0;
											branch0 = 1;
											Uncondbranch = 0;
											RegWrite = 0;
											MemWrite = 0;
											MemRead = 0;
											ALUSrc = 0;
											Reg2Loc = 1;
											ALUOp = 3'b000;
											link = 0;
											immIn = {{13{instruction[23]}}, instruction[23:5]};
										end
										
		11'b01010100???:			begin					//B.cond
											Branch = 1;
											RegWrite = 0;
											MemWrite = 0;
											MemRead = 0;
											immIn = {{13{instruction[23]}}, instruction[23:5]};
											link = 0;
											Uncondbranch = 0;
										end
										
		11'b100101?????:			begin					//BL
											Uncondbranch = 1;
											RegWrite = 1;
											MemWrite = 0;
											MemRead = 0;
											link = 1;
											immIn = {{6{instruction[25]}}, instruction[25:0]};
										end
										
		11'b11010110000:			begin					//BR
											BReg = 1;
											ALUOp = 3'b000;
											Reg2Loc = 1;
											Uncondbranch = 1;
										end
										
											
											
								
		endcase
	end
endmodule

module control_tb();
	logic [31:0] instruction;
	logic Reg2Loc, Uncondbranch, Branch, MemtoReg, MemRead, MemWrite, ALUSrc, RegWrite, link, BReg;
	logic [31:0] immIn;
	logic [2:0] ALUOp;
	
	control dut(.*);

	initial begin
		// ADDI: opcode 1001000100x
		instruction = 32'b10010001000000000000010000100010; // opcode = 10010001000
		#10;

		// B (unconditional): opcode 000101xxxxx
		instruction = 32'b00010100000000000000000000000000;
		#10;

		// LDUR: opcode 11111000010
		instruction = 32'b11111000010000000000000000100000;
		#10;

		// STUR: opcode 11111000000
		instruction = 32'b11111000000000000000000000100000;
		#10;

		// ADDS: opcode 10101011000
		instruction = 32'b10101011000000000000000000100000;
		#10;

		// SUBS: opcode 11101011000
		instruction = 32'b11101011000000000000000000100000;
		#10;

		// CBZ: opcode 10110100xxx
		instruction = 32'b10110100000000000000000000000000;
		#10;

		// B.cond: opcode 01010100xxx
		instruction = 32'b01010100000000000000000000000000;
		#10;

		// BL: opcode 100101xxxxx
		instruction = 32'b10010100000000000000000000000000;
		#10;

		$display("Test completed.");
		$stop;
	end
endmodule
	
											
										
											
										
											
											
											
											
										
										