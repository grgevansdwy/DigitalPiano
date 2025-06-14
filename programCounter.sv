`timescale 1ps/1ps
module programCounter(clk, in, out, reset);
	input logic clk, reset;
	input logic [63:0] in;
	output logic [63:0] out;
	
	register64 register(.q(out), .d(in), .clk, .reset, .enable(1'b1));
	
endmodule

module PCBranch(BrAddr26, address, BrTaken, clk, reset, PCLink, BReg, BRegAddr);
	input logic [31:0] BrAddr26;
	input logic clk, BrTaken, reset, BReg;
	input logic [63:0] BRegAddr;
	output logic [63:0] address, PCLink;
	logic [63:0] PCout;
	logic [63:0] brAddr64, branchOut, addfour, branching;
	logic [63:0] PCin, mux1out;
	
	
	
	programCounter PC(.clk, .in(PCin), .out(PCout), .reset);
	
	
	//multiply by 4 and sign extend to 64 bit for B, B.LT, BLink
	assign brAddr64 = {{30{BrAddr26[25]}}, BrAddr26, 2'b0};
	assign PCLink = addfour;
	
	chip64 adder(.inA(PCout), .inB(64'd4), .out(addfour), .cntrl(3'b010));
	
	chip64 adder1(.inA(PCout), .inB(brAddr64), .out(branching), .cntrl(3'b010));

	//Selecting between PC+4 and PC branching
	//select signal is BrTaken, input to module
	mux2_164bit sel1(.out(mux1out), .i0(addfour), .i1(branching), .sel(BrTaken));

	//Select between output from previous mux (PC+4 or branching) and BReg.
	//Select signal is BReg, directly from control unit.
	mux2_164bit sel2(.out(PCin), .i0(mux1out), .i1(BRegAddr), .sel(BReg));
	
	assign address = PCout;
endmodule

module PCBranch_tb();
	logic [31:0] BrAddr26;
	logic clk, BrTaken, reset;
	logic [63:0] address;
	parameter CLOCK_PERIOD = 1000;
	PCBranch dut(.*);
	
	initial begin
		clk = 0;
		forever #(CLOCK_PERIOD/2) clk = ~clk;
	end
	
	initial begin
		BrTaken <= 0; BrAddr26 <= 31'd5; reset <= 1; @(posedge clk);
		reset <= 0; @(posedge clk);
		repeat(3) 																		 @(posedge clk);
								BrTaken <= 1;											 @(posedge clk);
																						 @(posedge clk);
								BrTaken <= 0;											 @(posedge clk);
																						 @(posedge clk);
		$stop;
	end
endmodule
