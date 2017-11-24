module CLA_add_32(c, p, s, cOut);

	input [31:0] p;
	input [32:0] c;

	output [31:0] s;
	output cOut;

	assign s = p^c[31:0];
	assign cOut = c[32];

endmodule
