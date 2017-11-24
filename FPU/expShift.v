`include "CLA8.v"

`ifndef _expShift_
`define _expShift_
module expShift(LRbar, numBits, Ecs, Ec);
	input LRbar;
	input [4:0] numBits;
	input [7:0] Ecs;

	output [7:0] Ec;

	reg [7:0] numBits_eff;
	reg cIn;

	wire cOut;

	CLA8 A(Ecs, numBits_eff, cIn, Ec, cOut);

	always @(*) begin
		if (~LRbar) begin //right shift, add exp
			numBits_eff = {3'b0, numBits};
			cIn = 1'b0;
		end
		else begin //left Shift, subtract exp
			numBits_eff = ~{3'b0, numBits};
			cIn = 1'b1;
		end
	end
endmodule
`endif