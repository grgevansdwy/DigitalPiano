module decoder2_4(in, enable, out);
	input logic [1:0] in; input logic enable;
	output logic [3:0] out;
	logic w0, w1;
	
	
	decoder1_2 d0(.in(in[1]), .enable, .out({w1, w0}));
	decoder1_2 d1(.in(in[0]), .enable(w1), .out(out[3:2]));
	decoder1_2 d2(.in(in[0]), .enable(w0), .out(out[1:0]));
	
endmodule

module decoder2_4_tb();
	logic [1:0] in; logic enable; logic [3:0] out;
	
	decoder2_4 dut(.*);
	
	integer j;
	initial begin
		for(j=0; j<8; j++) begin
			{enable, in} = j;
			#10;
		end
	end
endmodule