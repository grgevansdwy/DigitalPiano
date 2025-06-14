module decoder5_32(in, out, enable);
	input logic [4:0] in; input logic enable;
	output logic [31:0] out;
	logic a, b;
	
	decoder4_16 dec1(.in(in[3:0]), .out(out[15:0]), .enable(a));
	decoder4_16 dec2(.in(in[3:0]), .out(out[31:16]), .enable(b));
	decoder1_2 dec3(.in(in[4]), .out({b, a}), .enable);
	
endmodule

module decoder5_32_tb();
	logic [4:0] in; logic enable; logic [31:0] out;
	
	decoder5_32 dut(.*);
	
	integer j;
	initial begin
		for(j=0; j<64; j++) begin
			{enable, in} = j;
			#10;
		end
	end
endmodule
