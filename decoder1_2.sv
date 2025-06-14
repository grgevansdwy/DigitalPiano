`timescale 1ns/1ns
module decoder1_2(in, enable, out);
	input logic in, enable;
	output logic [1:0] out;
	logic notin;
	
	not #50 n0(notin, in);
	and #50 a0(out[0], notin, enable);
	and #50 a1(out[1], in, enable);
	
endmodule

module decoder1_2_tb();
	logic in, enable;
	logic [1:0] out;
	
	decoder1_2 dut(.*);
	
		integer j;
	initial begin
		for(j=0; j<4; j++) begin
			{enable, in} = j;
			#10;
		end
	end
endmodule
	
	
	