module CSA_48(x, y, z, s, c);
  input [47:0] x, y, z;
  output [47:0] s, c;

  assign s = x^y^z;
  assign c = {x[46:0]&y[46:0] | z[46:0]&y[46:0] | z[46:0]&x[46:0], 1'b0};

endmodule
