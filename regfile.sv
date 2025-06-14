module regfile(ReadRegister1, ReadRegister2, WriteRegister, WriteData, ReadData1, ReadData2, RegWrite, clk);
	input logic [4:0] ReadRegister1, ReadRegister2, WriteRegister;
	input logic [63:0] WriteData;
	input logic RegWrite, clk;
	output logic [63:0] ReadData1, ReadData2;
	logic [31:0][63:0] regout;
	logic [63:0][31:0] muxin;
	logic [31:0]selectReg;
	
	genvar i;
	
	generate
		for(i=0; i<31; i++) begin : eachRegister
			register64 register (.q(regout[i]), .d(WriteData), .clk, .enable(selectReg[i]), .reset(1'b0));
		end
	endgenerate
	
	assign regout[31] = 0;
	transpose bits(.in(regout), .out(muxin));
	decoder5_32 decode(.in(WriteRegister), .enable(RegWrite), .out(selectReg));
	bigmux mux1(.in(muxin), .sel(ReadRegister1), .out(ReadData1));
	bigmux mux2(.in(muxin), .sel(ReadRegister2), .out(ReadData2));
endmodule
