`timescale 1ps/1ps
module fullAdder(in, cin, sum, cout);
	input logic [1:0] in;
	input logic cin;
	output logic sum, cout;
	logic h0sum, h0cout, h1cout;
	
	halfAdder h0(.in(in[1:0]), .cout(h0cout), .sum(h0sum));
	halfAdder h1(.in({cin, h0sum}), .cout(h1cout), .sum);
	or #50 o0(cout, h0cout, h1cout);
	
endmodule

module fullAdder_tb();
	logic [1:0]in;
	logic cin, sum, cout;
	
	fullAdder dut(.*);
	integer i;
	
	initial begin
		for (i = 0; i < 8; i++) begin
			{cin, in} = i;
			#10;
		end
	end
endmodule
	