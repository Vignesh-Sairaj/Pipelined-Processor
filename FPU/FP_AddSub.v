`include "addSubSign24.v"
`include "shiftCounter.v"
`include "mantissaShift.v"
`include "expShift.v"
`include "expCmp.v"

`include "Lshift24.v"
`include "Rshift24.v"

`ifndef _FP_AddSub_
`define _FP_AddSub_

module FP_AddSub(ch, A, B, C, clk);
	input [31:0] A, B;
	input ch, clk;
	output [31:0] C;

	wire [22:0] Ma, Mb;
	wire [7:0] Ea, Eb;
	wire Sa, Sb;

	//Stage 1
	reg ch1, Sa1, Sb1;
	reg [7:0] Ea1, Eb1;
	reg [23:0] Map1, Mbp1;
	reg aGrb1; 
	reg [4:0] diff1;

	wire aGrb;
	wire [7:0] diff;

	//Stage 2
	reg ch2, Sa2, Sb2;
	reg [7:0] Ecs2;
	reg [23:0] Maps2, Mbps2;

	wire [23:0] Map_rs, Mbp_rs;


	//Stage 3
	reg [7:0] Ecs3;
	reg Sc3, cOut3;
	reg [23:0] Mcps3;

	wire Sc, cOut;
	wire [23:0] Mcps;

	//Stage 4
	wire LRbar;
	wire [4:0] numBits;

	reg LRbar4, Sc4;
	reg [4:0] numBits4;
	reg [7:0] Ecs4;
	reg [23:0] Mcps4;

	//Stage 5
	wire [23:0] Mcp;
	wire [7:0] Ec;

	reg Sc5;
	reg [7:0] Ec5;
	reg [22:0] Mc5;


	//Stage 0
	assign Sa = A[31], Sb = B[31];
	assign Ea = A[30:23], Eb = B[30:23];
	assign Ma = A[22:0], Mb = B[22:0];

	//Stage 1
	expCmp CMP(Ea, Eb, aGrb, diff);

	//Stage 2
	Rshift24 SRA(Map1, diff1, Map_rs);
	Rshift24 SRB(Mbp1, diff1, Mbp_rs);

	//Stage 3
	addSubSign24 ADDSUB(ch2, Sa2, Sb2, Maps2, Mbps2, Sc, cOut, Mcps);

	//Stage 4
	shiftCounter SCOUNT(cOut3, Mcps3, LRbar, numBits);

	//Stage 5
	mantissaShift MS(LRbar4, numBits4, Mcps4, Mcp);
	expShift ES(LRbar4, numBits4, Ecs4, Ec);

	assign C = {Sc5, Ec5, Mc5};

	always @(posedge clk) begin
		//Stage 1
		ch1 <= ch;
		Sa1 <= Sa; Sb1 <= Sb;
		Ea1 <= Ea; Eb1 <= Eb;
		Map1 <= {1'b1, Ma}; Mbp1 <= {1'b1, Mb};
		aGrb1 <= aGrb;
		diff1 <= ~|diff[7:5] ? diff[4:0] : 5'd24;

		//Stage 2
		ch2 <= ch1;
		Sa2 <= Sa1; Sb2 <= Sb1;
		Ecs2 <= aGrb1 ? Ea1 : Eb1;
		Maps2 <= aGrb1 ? Map1 : Map_rs;
		Mbps2 <= aGrb1 ? Mbp_rs : Mbp1;

		//Stage 3
		Ecs3 <= Ecs2;
		Sc3 <= Sc;
		cOut3 <= cOut;
		Mcps3 <= Mcps;

		//Stage 4
		Ecs4 <= Ecs3;
		Sc4 <= Sc3;
		Mcps4 <= Mcps3;
		LRbar4 <= LRbar;
		numBits4 <= numBits;

		//Stage 5
		Sc5 <= Sc4;
		Ec5 <= Ec;
		Mc5 <= Mcp[22:0];
	end
endmodule

`endif