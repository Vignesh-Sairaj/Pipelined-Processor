`include "CLA8.v"


`ifndef _expCmp_
`define _expCmp_
module expCmp(Ea, Eb, aGrb, diff);

	input [7:0] Ea, Eb;

	output reg aGrb;
	output reg [7:0] diff;

	wire [7:0] diff_int, diff_comp;
	wire cOut, cOut_comp;

	CLA8 A(Ea, ~Eb, 1'b1, diff_int, cOut);
	CLA8 B(~diff_int, 8'b0, 1'b1, diff_comp, cOut_comp);


	always @(*) begin
		if (cOut) begin //A>=B
			diff = diff_int;
			aGrb = 1'b1;
		end
		else begin//B>A
			diff = diff_comp;
			aGrb = 1'b0;
		end
	end

endmodule
`endif