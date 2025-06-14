module bigregister(in, out, clk, enable);
	input logic [31:0][63:0] in;
	input logic clk; 
	input logic [31:0]enable;
	output logic [31:0][63:0] out;
	
	genvar i;
	
	generate
		for(i=0; i<31; i++) begin : eachRegister
			register64 register (.q(in[i]), .d(out[i]), .clk, .enable(enable[i]));
		end
	endgenerate
	
	assign out[31] = 0;
endmodule
	