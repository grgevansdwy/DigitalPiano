module cntrlReg#(parameter W = 4)(clk, reset, in, out);
    input logic clk, reset;
    input logic [W-1:0] in;
    output logic [W-1:0] out;

    genvar i;

    generate  
        for (i = 0; i < W; i++) begin
            D_FF FlipFLops(.clk, .reset, .d(in[i]), .q(out[i]));
        end
    endgenerate
endmodule