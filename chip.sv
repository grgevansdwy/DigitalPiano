`timescale 1ps/1ps
module chip(inA, inB, cntrl, out, cout, cin);
	input logic inA, inB, cin;
	input logic [2:0] cntrl;
	output logic out, cout;
	logic b, addorsub, bitor, bitand, bitxor;
	logic bor;
	
	fullAdder fA(.in({inA, inB}), .sum(addorsub), .cin, .cout);
	and #50 bA(bitand, inA, inB);
	xor #50 bX(bitxor, inA, inB);
	not #50 binor(bor, inB);
	or #50 bO(bitor, inA, bor);
	
	
	mux8_1 opsel(.i({1'b0, bitxor, bitor, bitand, addorsub, addorsub, 1'b0, inB}), .sel(cntrl), .out);
endmodule

module chip_tb();
	logic inA, inB, out, cout, cin;
	logic [2:0] cntrl;
	
	chip dut(.*);
	integer j;
	assign cin = cntrl[0];
	
	initial begin
		for (j=0; j<32; j++) begin
			{cntrl, inA, inB} = j;
			#10;
		end
	end
endmodule

module chip64(inA, inB, cntrl, out, cout1, cout0);
	input logic [63:0] inA, inB;
	input logic [2:0] cntrl;
	output logic [63:0] out;
	output logic cout0, cout1;
	logic [62:0] connect;
	logic [63:0] b;
	
	genvar i;
	generate
		for(i=0; i<64; i++) begin : eachb
			xor bin(b[i], cntrl[0], inB[i]);
		end
	endgenerate
	
	chip c0(.inA(inA[0]), .inB(b[0]), .cntrl, .out(out[0]), .cin(cntrl[0]), .cout(connect[0]));
	
	generate
		for(i=1; i<63; i++) begin : eachChip
			chip chips(.inA(inA[i]), .inB(b[i]), .cntrl, .out(out[i]), .cin(connect[i-1]), .cout(connect[i]));
		end
	endgenerate
	
	chip c63(.inA(inA[63]), .inB(b[63]), .cntrl, .out(out[63]), .cin(connect[62]), .cout(cout1));
	assign cout0 = connect[62];
endmodule

module chip64_tb();
	logic [63:0] inA, inB, out; 
	logic cout;
	logic [2:0] cntrl;
	
	integer i;
	
	chip64 dut(.*);
	initial begin
		for(i=0; i<8; i++) begin
			inA = 62583; inB = 69384;
			cntrl = i;
			#10;
		end
		
		for(i=0; i<8; i++) begin
			inA = 75029; inB = 64939;
			cntrl = i;
			#10;
		end
		
		for(i=0; i<8; i++) begin
			inA = 54921; inB = 66492;
			cntrl = i;
			#10;
		end
		
		for(i=0; i<8; i++) begin
			inA = -12394; inB = 45321;
			cntrl = i;
			#10;
		end
		
		for(i=0; i<8; i++) begin
			inA = 23810; inB = -48231;
			cntrl = i;
			#10;
		end
		
		for(i=0; i<8; i++) begin
			inA = -12381; inB = -85943;
			cntrl = i;
			#10;
		end
	end
endmodule
	
		
