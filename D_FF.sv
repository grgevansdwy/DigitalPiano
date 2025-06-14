module D_FF (q, d, reset, clk);
	output reg q;
	input logic d, reset, clk;
	
	always_ff@(posedge clk)
	if (reset)
		q <= 0;
	else
		q <= d;
endmodule

module D_FFEn (q, d, reset, clk, enable);
	output logic q;
	input logic d, reset, clk, enable;
	logic a;
	
	mux2_1 select(.out(a), .i0(q), .i1(d), .sel(enable));
	D_FF flipflop(.q, .d(a), .reset, .clk);
endmodule

module D_FFEn_tb();
	logic d, q, reset, clk, enable;
	
	D_FFEn dut(.*);
	
	parameter T = 20;
	initial begin
	clk <= 0;
		forever #(T/2) clk <= ~clk;
	end	
	
	initial begin
		reset <= 1;								@(posedge clk);
		reset <= 0; d <= 0; enable <= 0;	@(posedge clk);
													@(posedge clk);
						d <= 1;					@(posedge clk);  // one 1
						d <= 0; enable <= 1;	@(posedge clk);
						d <= 1;					@(posedge clk);  // transition to S1
													@(posedge clk);
						d <= 0;					@(posedge clk);
						d <= 1;					@(posedge clk);  // three 1's 
													@(posedge clk);// four 1's (outputs two 1's)

		$stop; // End the simulation
	end
endmodule
