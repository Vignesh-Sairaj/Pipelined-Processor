module gen_PP_32(x, y, pp);

	input [31:0] x, y;
	output [2047:0] pp;

	wire [63:0] ppArr [31:0];

	assign ppArr[0] = {32'd0, y[0] ? x : 32'b0};
	assign ppArr[1] = {31'd0, y[1] ? x : 32'b0, 1'b0};
	assign ppArr[2] = {30'd0, y[2] ? x : 32'b0, 2'b0};
	assign ppArr[3] = {29'd0, y[3] ? x : 32'b0, 3'b0};
	assign ppArr[4] = {28'd0, y[4] ? x : 32'b0, 4'b0};
	assign ppArr[5] = {27'd0, y[5] ? x : 32'b0, 5'b0};
	assign ppArr[6] = {26'd0, y[6] ? x : 32'b0, 6'b0};
	assign ppArr[7] = {25'd0, y[7] ? x : 32'b0, 7'b0};
	assign ppArr[8] = {24'd0, y[8] ? x : 32'b0, 8'b0};
	assign ppArr[9] = {23'd0, y[9] ? x : 32'b0, 9'b0};
	assign ppArr[10] = {22'd0, y[10] ? x : 32'b0, 10'b0};
	assign ppArr[11] = {21'd0, y[11] ? x : 32'b0, 11'b0};
	assign ppArr[12] = {20'd0, y[12] ? x : 32'b0, 12'b0};
	assign ppArr[13] = {19'd0, y[13] ? x : 32'b0, 13'b0};
	assign ppArr[14] = {18'd0, y[14] ? x : 32'b0, 14'b0};
	assign ppArr[15] = {17'd0, y[15] ? x : 32'b0, 15'b0};
	assign ppArr[16] = {16'd0, y[16] ? x : 32'b0, 16'b0};
	assign ppArr[17] = {15'd0, y[17] ? x : 32'b0, 17'b0};
	assign ppArr[18] = {14'd0, y[18] ? x : 32'b0, 18'b0};
	assign ppArr[19] = {13'd0, y[19] ? x : 32'b0, 19'b0};
	assign ppArr[20] = {12'd0, y[20] ? x : 32'b0, 20'b0};
	assign ppArr[21] = {11'd0, y[21] ? x : 32'b0, 21'b0};
	assign ppArr[22] = {10'd0, y[22] ? x : 32'b0, 22'b0};
	assign ppArr[23] = {9'd0, y[23] ? x : 32'b0, 23'b0};
	assign ppArr[24] = {8'd0, y[24] ? x : 32'b0, 24'b0};
	assign ppArr[25] = {7'd0, y[25] ? x : 32'b0, 25'b0};
	assign ppArr[26] = {6'd0, y[26] ? x : 32'b0, 26'b0};
	assign ppArr[27] = {5'd0, y[27] ? x : 32'b0, 27'b0};
	assign ppArr[28] = {4'd0, y[28] ? x : 32'b0, 28'b0};
	assign ppArr[29] = {3'd0, y[29] ? x : 32'b0, 29'b0};
	assign ppArr[30] = {2'd0, y[30] ? x : 32'b0, 30'b0};
	assign ppArr[31] = {1'd0, y[31] ? x : 32'b0, 31'b0};


	assign pp = {ppArr[31], ppArr[30], ppArr[29], ppArr[28], ppArr[27], ppArr[26], ppArr[25], ppArr[24], ppArr[23], ppArr[22], ppArr[21], ppArr[20], ppArr[19], ppArr[18], ppArr[17], ppArr[16], ppArr[15], ppArr[14], ppArr[13], ppArr[12], ppArr[11], ppArr[10], ppArr[9], ppArr[8], ppArr[7], ppArr[6], ppArr[5], ppArr[4], ppArr[3], ppArr[2], ppArr[1], ppArr[0]};

endmodule
