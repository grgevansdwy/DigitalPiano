module transpose(in, out);
	input logic [31:0][63:0] in;
	output logic [63:0][31:0] out;
	
	genvar i,j;
	generate
		for (i = 0; i < 32; i = i + 1) begin: loop3
			for (j = 0; j < 64; j = j + 1) begin: loop4
					assign out[j][i]=in[i][j];
			end
		end
	endgenerate
endmodule
