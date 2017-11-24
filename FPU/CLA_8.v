module CLA_8(x, y, cIn, s, cOut);

	input [7:0] x, y;
	input cIn;

	output [7:0] s;
    output cOut;
	

	wire [7:0] g, p;
	wire [8:0] c;

	assign g = x&y;
	assign p = x^y;

	assign c[0] = cIn;

	assign c[1] = g[0] | &p[0:0]&c[0];
	assign c[2] = g[1] | &p[1:1]&g[0] | &p[1:0]&c[0];
	assign c[3] = g[2] | &p[2:2]&g[1] | &p[2:1]&g[0] | &p[2:0]&c[0];
	assign c[4] = g[3] | &p[3:3]&g[2] | &p[3:2]&g[1] | &p[3:1]&g[0] | &p[3:0]&c[0];
	assign c[5] = g[4] | &p[4:4]&g[3] | &p[4:3]&g[2] | &p[4:2]&g[1] | &p[4:1]&g[0] | &p[4:0]&c[0];
	assign c[6] = g[5] | &p[5:5]&g[4] | &p[5:4]&g[3] | &p[5:3]&g[2] | &p[5:2]&g[1] | &p[5:1]&g[0] | &p[5:0]&c[0];
	assign c[7] = g[6] | &p[6:6]&g[5] | &p[6:5]&g[4] | &p[6:4]&g[3] | &p[6:3]&g[2] | &p[6:2]&g[1] | &p[6:1]&g[0] | &p[6:0]&c[0];
	assign c[8] = g[7] | &p[7:7]&g[6] | &p[7:6]&g[5] | &p[7:5]&g[4] | &p[7:4]&g[3] | &p[7:3]&g[2] | &p[7:2]&g[1] | &p[7:1]&g[0] | &p[7:0]&c[0];




	assign s = p^c[7:0];

	assign cOut = c[8];

	

endmodule
