module bigmux(in, out, sel);
	input logic [63:0][31:0] in;
	input logic [4:0] sel;
	output logic [63:0]out;
	
	genvar i;
	
	generate
		for(i=0; i<64; i++) begin : eachMux
			mux32_1 mux(.i(in[i]), .sel, .out(out[i]));
		end
	endgenerate
endmodule

module bigmux_tb();
	logic [63:0][31:0] in;
	logic [4:0] sel;
	logic [63:0] out;
	
	bigmux dut(.*);
	
	integer i;
	initial begin
		in = 0; #10;


		for (i = 0; i < 32; i++) begin
			in[i][i] = 1;
			#10;
		end
		
		for (i = 0; i < 32; i++) begin
			sel = i;
			#10;
		end
	end
endmodule

	
		
