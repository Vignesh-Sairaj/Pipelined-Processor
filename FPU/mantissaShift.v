`include "Lshift24.v"

`ifndef _mantissaShift_
`define _mantissaShift_
module mantissaShift(LRbar, numBits, Mcps, Mcp);
	input LRbar;
	input [4:0] numBits;
	input [23:0] Mcps;

	output reg [23:0] Mcp;

	wire [23:0] out;
	Lshift24 S(Mcps, numBits, out);

	always @(*) begin
		if (~LRbar) begin // shR
			Mcp = {1'b1, Mcps[23:1]};
		end
		else begin
			Mcp = out;
		end
	end

endmodule
`endif