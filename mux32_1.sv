module mux32_1(sel, i, out);
	input logic [4:0] sel;
	input logic [31:0] i;
	output logic out;
	logic a, b;
	
	mux16_1 mux1(.sel(sel[3:0]), .i(i[15:0]), .out(a));
	mux16_1 mux2(.sel(sel[3:0]), .i(i[31:16]), .out(b));
	mux2_1 mux3(.sel(sel[4]), .i0(a), .i1(b), .out);
	
	
endmodule
	
module mux32_1_tb();
	logic [4:0] sel;
	logic [31:0] i;
	logic out;
	
	mux32_1 dut(.*);
	
	integer j;
	initial begin
		for(j=0; j<1048576; j++) begin
			{sel, i} = j;
			#10;
		end
	end

endmodule
