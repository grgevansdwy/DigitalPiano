module mux16_1(sel, i, out);
	input logic [3:0] sel;
	input logic [15:0] i;
	output logic out;
	logic a, b, c, d;
	
	mux4_1 mux1(.sel(sel[1:0]), .i(i[3:0]), .out(a));
	mux4_1 mux2(.sel(sel[1:0]), .i(i[7:4]), .out(b));
	mux4_1 mux3(.sel(sel[1:0]), .i(i[11:8]), .out(c));
	mux4_1 mux4(.sel(sel[1:0]), .i(i[15:12]), .out(d));
	mux4_1 mux5(.sel(sel[3:2]), .i({d, c, b, a}), .out);
	
endmodule
	
module mux16_1_tb();
	logic [3:0] sel;
	logic [15:0] i;
	logic out;
	
	mux16_1 dut(.*);
	
	integer j;
	initial begin
		for(j=0; j<1048576; j++) begin
			{sel, i} = j;
			#10;
		end
	end

endmodule
