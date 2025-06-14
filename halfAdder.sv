`timescale 1ps/1ps
module halfAdder(in, sum, cout);
	input logic [1:0] in;
	output logic sum, cout;
	
	xor #50 x0(sum, in[1], in[0]);
	and #50 a0(cout, in[1], in[0]);
endmodule
	
module halfAdder_tb();
	logic [1:0] in;
	logic sum, cout;
	
	halfAdder dut(.*);
	
	initial begin
		in = 2'b00; #10;
		in = 2'b01; #10;
		in = 2'b10; #10;
		in = 2'b11; #10;
	end
endmodule

		
	