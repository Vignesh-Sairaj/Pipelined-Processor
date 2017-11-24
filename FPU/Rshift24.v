`include "Lshift24.v"

`ifndef _Rshift24_
`define _Rshift24_
module Rshift24(A, shr, OUT);

	input [23:0] A;
	input [4:0] shr;

	output [23:0] OUT;

	wire [23:0] Arev, OUTrev;

	assign Arev[23] = A[0];
	assign Arev[22] = A[1];
	assign Arev[21] = A[2];
	assign Arev[20] = A[3];
	assign Arev[19] = A[4];
	assign Arev[18] = A[5];
	assign Arev[17] = A[6];
	assign Arev[16] = A[7];
	assign Arev[15] = A[8];
	assign Arev[14] = A[9];
	assign Arev[13] = A[10];
	assign Arev[12] = A[11];
	assign Arev[11] = A[12];
	assign Arev[10] = A[13];
	assign Arev[9] = A[14];
	assign Arev[8] = A[15];
	assign Arev[7] = A[16];
	assign Arev[6] = A[17];
	assign Arev[5] = A[18];
	assign Arev[4] = A[19];
	assign Arev[3] = A[20];
	assign Arev[2] = A[21];
	assign Arev[1] = A[22];
	assign Arev[0] = A[23];

	Lshift24 L(Arev, shr, OUTrev);

	assign OUT[23] = OUTrev[0];
	assign OUT[22] = OUTrev[1];
	assign OUT[21] = OUTrev[2];
	assign OUT[20] = OUTrev[3];
	assign OUT[19] = OUTrev[4];
	assign OUT[18] = OUTrev[5];
	assign OUT[17] = OUTrev[6];
	assign OUT[16] = OUTrev[7];
	assign OUT[15] = OUTrev[8];
	assign OUT[14] = OUTrev[9];
	assign OUT[13] = OUTrev[10];
	assign OUT[12] = OUTrev[11];
	assign OUT[11] = OUTrev[12];
	assign OUT[10] = OUTrev[13];
	assign OUT[9] = OUTrev[14];
	assign OUT[8] = OUTrev[15];
	assign OUT[7] = OUTrev[16];
	assign OUT[6] = OUTrev[17];
	assign OUT[5] = OUTrev[18];
	assign OUT[4] = OUTrev[19];
	assign OUT[3] = OUTrev[20];
	assign OUT[2] = OUTrev[21];
	assign OUT[1] = OUTrev[22];
	assign OUT[0] = OUTrev[23];

endmodule
`endif