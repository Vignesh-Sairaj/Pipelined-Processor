module gen_PP_24(x, y, pp);

	input [23:0] x, y;
	output [1151:0] pp;

	wire [47:0] ppArr [23:0];

	assign ppArr[0] = {24'd0, y[0] ? x : 24'b0};
	assign ppArr[1] = {23'd0, y[1] ? x : 24'b0, 1'b0};
	assign ppArr[2] = {22'd0, y[2] ? x : 24'b0, 2'b0};
	assign ppArr[3] = {21'd0, y[3] ? x : 24'b0, 3'b0};
	assign ppArr[4] = {20'd0, y[4] ? x : 24'b0, 4'b0};
	assign ppArr[5] = {19'd0, y[5] ? x : 24'b0, 5'b0};
	assign ppArr[6] = {18'd0, y[6] ? x : 24'b0, 6'b0};
	assign ppArr[7] = {17'd0, y[7] ? x : 24'b0, 7'b0};
	assign ppArr[8] = {16'd0, y[8] ? x : 24'b0, 8'b0};
	assign ppArr[9] = {15'd0, y[9] ? x : 24'b0, 9'b0};
	assign ppArr[10] = {14'd0, y[10] ? x : 24'b0, 10'b0};
	assign ppArr[11] = {13'd0, y[11] ? x : 24'b0, 11'b0};
	assign ppArr[12] = {12'd0, y[12] ? x : 24'b0, 12'b0};
	assign ppArr[13] = {11'd0, y[13] ? x : 24'b0, 13'b0};
	assign ppArr[14] = {10'd0, y[14] ? x : 24'b0, 14'b0};
	assign ppArr[15] = {9'd0, y[15] ? x : 24'b0, 15'b0};
	assign ppArr[16] = {8'd0, y[16] ? x : 24'b0, 16'b0};
	assign ppArr[17] = {7'd0, y[17] ? x : 24'b0, 17'b0};
	assign ppArr[18] = {6'd0, y[18] ? x : 24'b0, 18'b0};
	assign ppArr[19] = {5'd0, y[19] ? x : 24'b0, 19'b0};
	assign ppArr[20] = {4'd0, y[20] ? x : 24'b0, 20'b0};
	assign ppArr[21] = {3'd0, y[21] ? x : 24'b0, 21'b0};
	assign ppArr[22] = {2'd0, y[22] ? x : 24'b0, 22'b0};
	assign ppArr[23] = {1'd0, y[23] ? x : 24'b0, 23'b0};



	assign pp = { ppArr[23], ppArr[22], ppArr[21], ppArr[20], ppArr[19], ppArr[18], ppArr[17], ppArr[16], ppArr[15], ppArr[14], ppArr[13], ppArr[12], ppArr[11], ppArr[10], ppArr[9], ppArr[8], ppArr[7], ppArr[6], ppArr[5], ppArr[4], ppArr[3], ppArr[2], ppArr[1], ppArr[0]};

endmodule
