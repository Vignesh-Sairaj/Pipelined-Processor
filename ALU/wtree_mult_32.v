`include "wtree_32.v"
`include "gen_PP_32.v"
`include "CLA_64.v"

module wtree_mult_32(x, y, m);
  input [31:0] x, y;
  output [63:0] m;

  wire [2047:0] pp;
  wire [63:0] s, c;
  wire cOut;

  gen_PP_32 PP(x, y, pp);
  wtree_32 WT(pp, s, c);
  CLA_64 CL(s, c, 1'b0, m, cOut);

endmodule