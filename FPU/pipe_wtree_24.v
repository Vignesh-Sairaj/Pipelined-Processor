`include "wtree_24.v"
`include "gen_PP_24.v"
`include "CLA_48.v"

module pipe_wtree_24(x, y, mReg, clk);
  input clk;
  input [23:0] x, y;
  output reg [47:0] mReg;

  wire [47:0] mWire;

  wire [1151:0] ppWire;
  reg [1151:0] ppReg;

  wire [47:0] sWire, cWire;
  reg [47:0] sReg, cReg;

  wire cOut;

  gen_PP_24 PP(x, y, ppWire);
  wtree_24 WT(ppReg, sWire, cWire);
  CLA_48 CL(sReg, cReg, 1'b0, mWire, cOut);

  always @(posedge clk) begin
    ppReg <= ppWire;
    sReg <= sWire;
    cReg <= cWire;
    mReg <= mWire;
  end

endmodule
