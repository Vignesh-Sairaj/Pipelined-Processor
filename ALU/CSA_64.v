module CSA_64(x, y, z, s, c);
  input [63:0] x, y, z;
  output [63:0] s, c;

  assign s = x^y^z;
  assign c = {x[62:0]&y[62:0] | z[62:0]&y[62:0] | z[62:0]&x[62:0], 1'b0};

endmodule
