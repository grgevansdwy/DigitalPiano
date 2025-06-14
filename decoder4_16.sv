module decoder4_16(in, out, enable);
	input logic [3:0] in; input logic enable;
	output logic [15:0] out;
	logic a, b, c, d;
	
	decoder2_4 dec0(.in(in[1:0]), .out(out[3:0]), .enable(a));
	decoder2_4 dec1(.in(in[1:0]), .out(out[7:4]), .enable(b));
	decoder2_4 dec2(.in(in[1:0]), .out(out[11:8]), .enable(c));
	decoder2_4 dec3(.in(in[1:0]), .out(out[15:12]), .enable(d));
	decoder2_4 dec4(.in(in[3:2]), .out({d, c, b, a}), .enable);
endmodule

module decoder4_16_tb();
	logic [3:0] in; logic [15:0] out; logic enable;
	
	decoder4_16 dut(.*);
	
	integer j;
	initial begin
		for(j=0; j<32; j++) begin
			{enable, in} = j;
			#10;
		end
	end
endmodule

