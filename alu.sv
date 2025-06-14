`timescale 1ps/1ps
module alu(A, B, cntrl, result, negative, zero, overflow, carry_out);
	input logic [63:0] A, B;
	input logic [2:0] cntrl;
	output logic zero, overflow, negative, carry_out;
	output logic [63:0] result;
	logic carry_out0, carry_out0f, notcarryOut, carryOut;
	
	not #50 n0(notcarryOut, carryOut);
	not #50 n1(notcarryOut_0, carry_out0);
	mux2_1 mux0(.out(carry_out), .i0(carryOut), .i1(notcarryOut), .sel(cntrl[0]));
	mux2_1 mux1(.out(carry_out0f), .i0(carry_out0), .i1(notcarryOut_0), .sel(cntrl[0]));
	
	chip64 alu(.inA(A), .inB(B), .cntrl, .out(result), .cout1(carryOut), .cout0(carry_out0));
	zeroflag zf(.result, .flag(zero));
	assign negative = result[63];
	xor #50 ovrflwflag(overflow, carry_out, carry_out0f);
endmodule



		