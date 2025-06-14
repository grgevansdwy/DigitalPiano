`timescale 1ps/1ps
module mux2_1 (out, i0, i1, sel);
	output logic out;
	input logic i0, i1, sel;
	logic a, b, notsel;
	
	not #50 n0(notsel, sel);
	and #50 a0(a, i1, sel); 
	and #50 a1(b, i0, notsel);
	or #50 o0(out, a, b);


	
endmodule

module mux2_1Extd #(parameter B = 64)(out, i0, i1, sel);
	output logic [B-1:0] out;
	input logic [B-1:0] i0, i1;
	input logic sel;
	
	genvar i;
	generate
		for (i = 0; i<B; i++) begin: eachmux
			mux2_1 muxs(.out(out[i]), .i0(i0[i]), .i1(i1[i]), .sel);
		end
	endgenerate
endmodule

module mux2_164bit(out, i0, i1, sel);
	output logic [63:0] out;
	input logic [63:0] i0, i1;
	input logic sel;
	
	genvar i;
	generate
		for (i = 0; i<64; i++) begin: eachmux
			mux2_1 muxs(.out(out[i]), .i0(i0[i]), .i1(i1[i]), .sel);
		end
	endgenerate
endmodule

module mux4_164bit(out, i, sel);
	output logic [63:0] out;
	input logic [3:0][63:0] i;
	input logic [1:0] sel;
	logic [63:0] a, b;

	mux2_164bit m0(.out(a), .i0(i[0]), .i1(i[1]), .sel(sel[0]));
	mux2_164bit m1(.out(b), .i0(i[2]), .i1(i[3]), .sel(sel[0]));
	mux2_164bit m2(.out, .i0(a), .i1(b), .sel(sel[1]));


endmodule

module mux2_1_testbench();
	logic out, i0, i1, sel;
	
	mux2_1 dut(.out, .i0, .i1, .sel);
	
	initial begin
		sel=0; i0=0; i1=0; #10;
		sel=0; i0=0; i1=1; #10;
		sel=0; i0=1; i1=0; #10;
		sel=0; i0=1; i1=1; #10;
		sel=1; i0=0; i1=0; #10;
		sel=1; i0=0; i1=1; #10;
		sel=1; i0=1; i1=0; #10;
		sel=1; i0=1; i1=1; #10;
		end
	endmodule
	
		