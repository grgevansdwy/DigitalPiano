`timescale 1ps/1ps
module mux4_1(sel, i, out);
	input logic [1:0] sel; input logic [3:0] i;
	output logic out;
	logic a, b;
	
	
	mux2_1 mux1 (.out(a), .i0(i[0]), .i1(i[1]), .sel(sel[0]));
	mux2_1 mux2 (.out(b), .i0(i[2]), .i1(i[3]), .sel(sel[0]));
	mux2_1 mux3	(.out, .i0(a), .i1(b), .sel(sel[1]));
	
endmodule

module mux8_1(sel, i, out);
	input logic [2:0] sel;
	input logic [7:0] i;
	output logic out;
	logic a, b;
	
	mux4_1 mux0 (.out(a), .i(i[3:0]), .sel(sel[1:0]));
	mux4_1 mux1 (.out(b), .i(i[7:4]), .sel(sel[1:0]));
	mux2_1 mux2	(.out, .i0(a), .i1(b), .sel(sel[2]));
endmodule

module mux4_1_tb();
	logic [1:0] sel;
	logic [3:0]i; 
	logic out;

	mux4_1 dut(.*);
	
	integer j;
	initial begin
		for(j=0; j<64; j++) begin
			{sel, i} = j;
			#10;
		end
	end

endmodule
