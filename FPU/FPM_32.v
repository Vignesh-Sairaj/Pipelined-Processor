`include "pipe_wtree_24.v"
`include "CLA_8.v"

module FPM_32(x, y, finalReg, clk);
  input clk;
  input [31:0] x, y;
  output reg [31:0] finalReg;	//Final result
 
  wire [47:0] mWire,resm;
  wire [22:0]fresm;	
  wire [23:0] xm,ym;    //M part of x and y
  wire [7:0] xe,ye,rese,reste,trese,ttrese;    //E part of x,y,res and temp res
  wire [31:0]final;	
  reg [47:0] resmReg;	
  wire a;


  wire cOut,tcOut,cOutt;	//Cout and Temp cout of CLA8

 assign xm={1'b1,x[22:0]};
 assign ym={1'b1,y[22:0]};
	
 assign xe=x[30:23];
 assign ye=y[30:23];

  
  CLA_8 CL1(xe, ye, 1'b0, reste, tcOut);
  CLA_8 CL2(reste,8'd129,1'b0, trese,cOut);
  pipe_wtree_24 WT(xm, ym, resm, clk);


  assign fresm = {resmReg[47] ? resmReg[46] : resmReg[45], resmReg[47] ? resmReg[45:24] : resmReg[44:23]};	
  assign a=resmReg[47];	
  assign ttrese={7'b0,a};
  CLA_8 CL3(trese,ttrese,1'b0,rese,cOutt);	

 



assign final={x[31]^y[31],rese,fresm};




always @(posedge clk) begin

	resmReg <= resm;
    finalReg <= final;

  end

endmodule
