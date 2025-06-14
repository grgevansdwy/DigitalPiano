`timescale 1ns/10ps
module datapath(clk, Reg2Loc, ALUOp, ALUSrc, RegWrite,
			 instruction, zero, overflow, carry_out, negative, result, WriteData, immIn, WriteRegister, ReadData2);
	input logic Reg2Loc, ALUSrc, RegWrite, clk;
	input logic [2:0] ALUOp;
	input logic [4:0] WriteRegister;
	input logic [31:0] instruction, immIn;
	input logic [63:0] WriteData;
	output logic zero, overflow, carry_out, negative;
	output logic [63:0] result, ReadData2;
	logic [4:0] ReadRegister2;
	logic [63:0] ReadData1, B, immInExtd;
	
	//sign extension from 32 to 64 bit for ADD, SUB, LDUR, STUR
	assign immInExtd = {{32{immIn[31]}}, immIn};
	
	mux2_15bit regMux(.out(ReadRegister2), .i0(instruction[20:16]), .i1(instruction[4:0]), .sel(Reg2Loc));
	mux2_164bit aluMux(.out(B), .i0(ReadData2), .i1(immInExtd), .sel(ALUSrc));
	
	regfile register(.ReadRegister1(instruction[9:5]), .ReadRegister2, .WriteRegister, .WriteData, .ReadData1, .ReadData2, .RegWrite, .clk);
	alu arithmetic(.A(ReadData1), .B, .cntrl(ALUOp), .zero, .overflow, .negative, .carry_out, .result);
endmodule

	
module mux2_15bit(out, i0, i1, sel);
	input logic[4:0] i0, i1;
	input logic sel;
	output logic [4:0] out;
	
	genvar i;
	generate
		for(i = 0; i < 5; i++) begin : genMux
			mux2_1 muxes(.out(out[i]), .i0(i0[i]), .i1(i1[i]), .sel);
		end
	endgenerate
endmodule

module datapath_tb();
	logic clk, Reg2Loc, ALUSrc, RegWrite, zero, overflow, carry_out, negative;
	logic [2:0] ALUOp;
	logic [4:0] WriteRegister;
	logic [31:0] instruction, immIn;
	logic [63:0] WriteData, result;
	
	datapath dut(.*);
	parameter clock_period = 5000;
	
	localparam ALU_PASSB = 3'b000;
	localparam ALU_ADD   = 3'b010;
	localparam ALU_SUB   = 3'b011;
	localparam ALU_AND   = 3'b100;
	localparam ALU_OR    = 3'b101;
	localparam ALU_XOR   = 3'b110;
	
	initial begin
		clk = 0;
		forever #(clock_period/2) clk = ~clk;
	end
	
	integer i;
	
	initial begin
		Reg2Loc <= 0;
		ALUSrc <= 0;
		RegWrite <= 0;
		ALUOp <= ALU_ADD;
		immIn <= 32'd0;
		instruction <= 32'd0;
		@(posedge clk);

		// Initialize registers 0–31 with values equal to their index
		for (i=0; i<31; i++) begin
			RegWrite <= 0;
			WriteRegister <= i;
			WriteData <= i;
			@(posedge clk);
			
			RegWrite <= 1;
			@(posedge clk);
		end
		
		
		
		//ADDI
		instruction <= 32'd0; ALUSrc <= 1; RegWrite <= 1; ALUOp <= ALU_ADD; @(posedge clk);
		instruction[20:16] <= 5'b00001; immIn[21:10] <= 12'd4; instruction[9:5] <= 5'b00010; @(posedge clk);
		instruction[9:5] <= 5'b00011; @(posedge clk);
		
		
		//ADDS
		$display("testing addition at", $time, "ps");
		Reg2Loc <= 0; ALUSrc <= 0; RegWrite = 1; @(posedge clk);
		
		
		//SUBS
		$display("testing subtraction at ", $time, "ps");
		ALUOp <= 3'b011; @(posedge clk);
		
		//test zero flag
		$display("testing Zero flag", $time, "ps");
		instruction[9:5] <= 5'd0; instruction[20:16] <= 5'd31; @(posedge clk);
		
		//tesitng negative flags
		instruction[20:16] <= 5'd5; @(posedge clk);
		
		$stop;
	end
endmodule

	
	


	