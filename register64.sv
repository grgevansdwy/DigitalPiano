module register64 #(parameter WIDTH=64) (q, d, clk, reset, enable);
	output logic [WIDTH-1:0] q;
	input logic  [WIDTH-1:0] d;
	input logic 				 clk, reset;
	input logic enable;
	logic a;
	
	initial assert(WIDTH>0);
	
	genvar i;
	
	generate
		for(i=0; i<WIDTH; i++) begin : eachDff
			D_FFEn dff (.q(q[i]), .d(d[i]), .clk, .enable, .reset);
		end
	endgenerate
endmodule

module register64_tb();
	logic [63:0] q, d;
	logic clk;
	logic enable;
	
	register64 dut(.*);
	
		parameter T = 20;
	initial begin
	clk <= 0;
		forever #(T/2) clk <= ~clk;
	end
	
		initial begin
																				@(posedge clk);
						d <= 64'h00000000000000A0; enable <= 0;	@(posedge clk);
																				@(posedge clk);
						d <= 64'h00000000000000AB;						@(posedge clk);  // one 1
						d <= 64'h0000000000000CAB; enable <= 1;	@(posedge clk);
						d <= 64'h0000000000008CAB; 					@(posedge clk);  // transition to S1
																				@(posedge clk);
						d <= 0;												@(posedge clk);
																				@(posedge clk);  // three 1's 


		$stop; // End the simulation
	end
endmodule
