module CLA32(x, y, cIn, s, cOut);

	input [31:0] x, y;
	input cIn;

	output [31:0] s;
	output cOut;

	wire [31:0] g, p;
	wire [32:0] c;

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
	assign c[9] = g[8] | &p[8:8]&g[7] | &p[8:7]&g[6] | &p[8:6]&g[5] | &p[8:5]&g[4] | &p[8:4]&g[3] | &p[8:3]&g[2] | &p[8:2]&g[1] | &p[8:1]&g[0] | &p[8:0]&c[0];
	assign c[10] = g[9] | &p[9:9]&g[8] | &p[9:8]&g[7] | &p[9:7]&g[6] | &p[9:6]&g[5] | &p[9:5]&g[4] | &p[9:4]&g[3] | &p[9:3]&g[2] | &p[9:2]&g[1] | &p[9:1]&g[0] | &p[9:0]&c[0];
	assign c[11] = g[10] | &p[10:10]&g[9] | &p[10:9]&g[8] | &p[10:8]&g[7] | &p[10:7]&g[6] | &p[10:6]&g[5] | &p[10:5]&g[4] | &p[10:4]&g[3] | &p[10:3]&g[2] | &p[10:2]&g[1] | &p[10:1]&g[0] | &p[10:0]&c[0];
	assign c[12] = g[11] | &p[11:11]&g[10] | &p[11:10]&g[9] | &p[11:9]&g[8] | &p[11:8]&g[7] | &p[11:7]&g[6] | &p[11:6]&g[5] | &p[11:5]&g[4] | &p[11:4]&g[3] | &p[11:3]&g[2] | &p[11:2]&g[1] | &p[11:1]&g[0] | &p[11:0]&c[0];
	assign c[13] = g[12] | &p[12:12]&g[11] | &p[12:11]&g[10] | &p[12:10]&g[9] | &p[12:9]&g[8] | &p[12:8]&g[7] | &p[12:7]&g[6] | &p[12:6]&g[5] | &p[12:5]&g[4] | &p[12:4]&g[3] | &p[12:3]&g[2] | &p[12:2]&g[1] | &p[12:1]&g[0] | &p[12:0]&c[0];
	assign c[14] = g[13] | &p[13:13]&g[12] | &p[13:12]&g[11] | &p[13:11]&g[10] | &p[13:10]&g[9] | &p[13:9]&g[8] | &p[13:8]&g[7] | &p[13:7]&g[6] | &p[13:6]&g[5] | &p[13:5]&g[4] | &p[13:4]&g[3] | &p[13:3]&g[2] | &p[13:2]&g[1] | &p[13:1]&g[0] | &p[13:0]&c[0];
	assign c[15] = g[14] | &p[14:14]&g[13] | &p[14:13]&g[12] | &p[14:12]&g[11] | &p[14:11]&g[10] | &p[14:10]&g[9] | &p[14:9]&g[8] | &p[14:8]&g[7] | &p[14:7]&g[6] | &p[14:6]&g[5] | &p[14:5]&g[4] | &p[14:4]&g[3] | &p[14:3]&g[2] | &p[14:2]&g[1] | &p[14:1]&g[0] | &p[14:0]&c[0];
	assign c[16] = g[15] | &p[15:15]&g[14] | &p[15:14]&g[13] | &p[15:13]&g[12] | &p[15:12]&g[11] | &p[15:11]&g[10] | &p[15:10]&g[9] | &p[15:9]&g[8] | &p[15:8]&g[7] | &p[15:7]&g[6] | &p[15:6]&g[5] | &p[15:5]&g[4] | &p[15:4]&g[3] | &p[15:3]&g[2] | &p[15:2]&g[1] | &p[15:1]&g[0] | &p[15:0]&c[0];
	assign c[17] = g[16] | &p[16:16]&g[15] | &p[16:15]&g[14] | &p[16:14]&g[13] | &p[16:13]&g[12] | &p[16:12]&g[11] | &p[16:11]&g[10] | &p[16:10]&g[9] | &p[16:9]&g[8] | &p[16:8]&g[7] | &p[16:7]&g[6] | &p[16:6]&g[5] | &p[16:5]&g[4] | &p[16:4]&g[3] | &p[16:3]&g[2] | &p[16:2]&g[1] | &p[16:1]&g[0] | &p[16:0]&c[0];
	assign c[18] = g[17] | &p[17:17]&g[16] | &p[17:16]&g[15] | &p[17:15]&g[14] | &p[17:14]&g[13] | &p[17:13]&g[12] | &p[17:12]&g[11] | &p[17:11]&g[10] | &p[17:10]&g[9] | &p[17:9]&g[8] | &p[17:8]&g[7] | &p[17:7]&g[6] | &p[17:6]&g[5] | &p[17:5]&g[4] | &p[17:4]&g[3] | &p[17:3]&g[2] | &p[17:2]&g[1] | &p[17:1]&g[0] | &p[17:0]&c[0];
	assign c[19] = g[18] | &p[18:18]&g[17] | &p[18:17]&g[16] | &p[18:16]&g[15] | &p[18:15]&g[14] | &p[18:14]&g[13] | &p[18:13]&g[12] | &p[18:12]&g[11] | &p[18:11]&g[10] | &p[18:10]&g[9] | &p[18:9]&g[8] | &p[18:8]&g[7] | &p[18:7]&g[6] | &p[18:6]&g[5] | &p[18:5]&g[4] | &p[18:4]&g[3] | &p[18:3]&g[2] | &p[18:2]&g[1] | &p[18:1]&g[0] | &p[18:0]&c[0];
	assign c[20] = g[19] | &p[19:19]&g[18] | &p[19:18]&g[17] | &p[19:17]&g[16] | &p[19:16]&g[15] | &p[19:15]&g[14] | &p[19:14]&g[13] | &p[19:13]&g[12] | &p[19:12]&g[11] | &p[19:11]&g[10] | &p[19:10]&g[9] | &p[19:9]&g[8] | &p[19:8]&g[7] | &p[19:7]&g[6] | &p[19:6]&g[5] | &p[19:5]&g[4] | &p[19:4]&g[3] | &p[19:3]&g[2] | &p[19:2]&g[1] | &p[19:1]&g[0] | &p[19:0]&c[0];
	assign c[21] = g[20] | &p[20:20]&g[19] | &p[20:19]&g[18] | &p[20:18]&g[17] | &p[20:17]&g[16] | &p[20:16]&g[15] | &p[20:15]&g[14] | &p[20:14]&g[13] | &p[20:13]&g[12] | &p[20:12]&g[11] | &p[20:11]&g[10] | &p[20:10]&g[9] | &p[20:9]&g[8] | &p[20:8]&g[7] | &p[20:7]&g[6] | &p[20:6]&g[5] | &p[20:5]&g[4] | &p[20:4]&g[3] | &p[20:3]&g[2] | &p[20:2]&g[1] | &p[20:1]&g[0] | &p[20:0]&c[0];
	assign c[22] = g[21] | &p[21:21]&g[20] | &p[21:20]&g[19] | &p[21:19]&g[18] | &p[21:18]&g[17] | &p[21:17]&g[16] | &p[21:16]&g[15] | &p[21:15]&g[14] | &p[21:14]&g[13] | &p[21:13]&g[12] | &p[21:12]&g[11] | &p[21:11]&g[10] | &p[21:10]&g[9] | &p[21:9]&g[8] | &p[21:8]&g[7] | &p[21:7]&g[6] | &p[21:6]&g[5] | &p[21:5]&g[4] | &p[21:4]&g[3] | &p[21:3]&g[2] | &p[21:2]&g[1] | &p[21:1]&g[0] | &p[21:0]&c[0];
	assign c[23] = g[22] | &p[22:22]&g[21] | &p[22:21]&g[20] | &p[22:20]&g[19] | &p[22:19]&g[18] | &p[22:18]&g[17] | &p[22:17]&g[16] | &p[22:16]&g[15] | &p[22:15]&g[14] | &p[22:14]&g[13] | &p[22:13]&g[12] | &p[22:12]&g[11] | &p[22:11]&g[10] | &p[22:10]&g[9] | &p[22:9]&g[8] | &p[22:8]&g[7] | &p[22:7]&g[6] | &p[22:6]&g[5] | &p[22:5]&g[4] | &p[22:4]&g[3] | &p[22:3]&g[2] | &p[22:2]&g[1] | &p[22:1]&g[0] | &p[22:0]&c[0];
	assign c[24] = g[23] | &p[23:23]&g[22] | &p[23:22]&g[21] | &p[23:21]&g[20] | &p[23:20]&g[19] | &p[23:19]&g[18] | &p[23:18]&g[17] | &p[23:17]&g[16] | &p[23:16]&g[15] | &p[23:15]&g[14] | &p[23:14]&g[13] | &p[23:13]&g[12] | &p[23:12]&g[11] | &p[23:11]&g[10] | &p[23:10]&g[9] | &p[23:9]&g[8] | &p[23:8]&g[7] | &p[23:7]&g[6] | &p[23:6]&g[5] | &p[23:5]&g[4] | &p[23:4]&g[3] | &p[23:3]&g[2] | &p[23:2]&g[1] | &p[23:1]&g[0] | &p[23:0]&c[0];
	assign c[25] = g[24] | &p[24:24]&g[23] | &p[24:23]&g[22] | &p[24:22]&g[21] | &p[24:21]&g[20] | &p[24:20]&g[19] | &p[24:19]&g[18] | &p[24:18]&g[17] | &p[24:17]&g[16] | &p[24:16]&g[15] | &p[24:15]&g[14] | &p[24:14]&g[13] | &p[24:13]&g[12] | &p[24:12]&g[11] | &p[24:11]&g[10] | &p[24:10]&g[9] | &p[24:9]&g[8] | &p[24:8]&g[7] | &p[24:7]&g[6] | &p[24:6]&g[5] | &p[24:5]&g[4] | &p[24:4]&g[3] | &p[24:3]&g[2] | &p[24:2]&g[1] | &p[24:1]&g[0] | &p[24:0]&c[0];
	assign c[26] = g[25] | &p[25:25]&g[24] | &p[25:24]&g[23] | &p[25:23]&g[22] | &p[25:22]&g[21] | &p[25:21]&g[20] | &p[25:20]&g[19] | &p[25:19]&g[18] | &p[25:18]&g[17] | &p[25:17]&g[16] | &p[25:16]&g[15] | &p[25:15]&g[14] | &p[25:14]&g[13] | &p[25:13]&g[12] | &p[25:12]&g[11] | &p[25:11]&g[10] | &p[25:10]&g[9] | &p[25:9]&g[8] | &p[25:8]&g[7] | &p[25:7]&g[6] | &p[25:6]&g[5] | &p[25:5]&g[4] | &p[25:4]&g[3] | &p[25:3]&g[2] | &p[25:2]&g[1] | &p[25:1]&g[0] | &p[25:0]&c[0];
	assign c[27] = g[26] | &p[26:26]&g[25] | &p[26:25]&g[24] | &p[26:24]&g[23] | &p[26:23]&g[22] | &p[26:22]&g[21] | &p[26:21]&g[20] | &p[26:20]&g[19] | &p[26:19]&g[18] | &p[26:18]&g[17] | &p[26:17]&g[16] | &p[26:16]&g[15] | &p[26:15]&g[14] | &p[26:14]&g[13] | &p[26:13]&g[12] | &p[26:12]&g[11] | &p[26:11]&g[10] | &p[26:10]&g[9] | &p[26:9]&g[8] | &p[26:8]&g[7] | &p[26:7]&g[6] | &p[26:6]&g[5] | &p[26:5]&g[4] | &p[26:4]&g[3] | &p[26:3]&g[2] | &p[26:2]&g[1] | &p[26:1]&g[0] | &p[26:0]&c[0];
	assign c[28] = g[27] | &p[27:27]&g[26] | &p[27:26]&g[25] | &p[27:25]&g[24] | &p[27:24]&g[23] | &p[27:23]&g[22] | &p[27:22]&g[21] | &p[27:21]&g[20] | &p[27:20]&g[19] | &p[27:19]&g[18] | &p[27:18]&g[17] | &p[27:17]&g[16] | &p[27:16]&g[15] | &p[27:15]&g[14] | &p[27:14]&g[13] | &p[27:13]&g[12] | &p[27:12]&g[11] | &p[27:11]&g[10] | &p[27:10]&g[9] | &p[27:9]&g[8] | &p[27:8]&g[7] | &p[27:7]&g[6] | &p[27:6]&g[5] | &p[27:5]&g[4] | &p[27:4]&g[3] | &p[27:3]&g[2] | &p[27:2]&g[1] | &p[27:1]&g[0] | &p[27:0]&c[0];
	assign c[29] = g[28] | &p[28:28]&g[27] | &p[28:27]&g[26] | &p[28:26]&g[25] | &p[28:25]&g[24] | &p[28:24]&g[23] | &p[28:23]&g[22] | &p[28:22]&g[21] | &p[28:21]&g[20] | &p[28:20]&g[19] | &p[28:19]&g[18] | &p[28:18]&g[17] | &p[28:17]&g[16] | &p[28:16]&g[15] | &p[28:15]&g[14] | &p[28:14]&g[13] | &p[28:13]&g[12] | &p[28:12]&g[11] | &p[28:11]&g[10] | &p[28:10]&g[9] | &p[28:9]&g[8] | &p[28:8]&g[7] | &p[28:7]&g[6] | &p[28:6]&g[5] | &p[28:5]&g[4] | &p[28:4]&g[3] | &p[28:3]&g[2] | &p[28:2]&g[1] | &p[28:1]&g[0] | &p[28:0]&c[0];
	assign c[30] = g[29] | &p[29:29]&g[28] | &p[29:28]&g[27] | &p[29:27]&g[26] | &p[29:26]&g[25] | &p[29:25]&g[24] | &p[29:24]&g[23] | &p[29:23]&g[22] | &p[29:22]&g[21] | &p[29:21]&g[20] | &p[29:20]&g[19] | &p[29:19]&g[18] | &p[29:18]&g[17] | &p[29:17]&g[16] | &p[29:16]&g[15] | &p[29:15]&g[14] | &p[29:14]&g[13] | &p[29:13]&g[12] | &p[29:12]&g[11] | &p[29:11]&g[10] | &p[29:10]&g[9] | &p[29:9]&g[8] | &p[29:8]&g[7] | &p[29:7]&g[6] | &p[29:6]&g[5] | &p[29:5]&g[4] | &p[29:4]&g[3] | &p[29:3]&g[2] | &p[29:2]&g[1] | &p[29:1]&g[0] | &p[29:0]&c[0];
	assign c[31] = g[30] | &p[30:30]&g[29] | &p[30:29]&g[28] | &p[30:28]&g[27] | &p[30:27]&g[26] | &p[30:26]&g[25] | &p[30:25]&g[24] | &p[30:24]&g[23] | &p[30:23]&g[22] | &p[30:22]&g[21] | &p[30:21]&g[20] | &p[30:20]&g[19] | &p[30:19]&g[18] | &p[30:18]&g[17] | &p[30:17]&g[16] | &p[30:16]&g[15] | &p[30:15]&g[14] | &p[30:14]&g[13] | &p[30:13]&g[12] | &p[30:12]&g[11] | &p[30:11]&g[10] | &p[30:10]&g[9] | &p[30:9]&g[8] | &p[30:8]&g[7] | &p[30:7]&g[6] | &p[30:6]&g[5] | &p[30:5]&g[4] | &p[30:4]&g[3] | &p[30:3]&g[2] | &p[30:2]&g[1] | &p[30:1]&g[0] | &p[30:0]&c[0];
	assign c[32] = g[31] | &p[31:31]&g[30] | &p[31:30]&g[29] | &p[31:29]&g[28] | &p[31:28]&g[27] | &p[31:27]&g[26] | &p[31:26]&g[25] | &p[31:25]&g[24] | &p[31:24]&g[23] | &p[31:23]&g[22] | &p[31:22]&g[21] | &p[31:21]&g[20] | &p[31:20]&g[19] | &p[31:19]&g[18] | &p[31:18]&g[17] | &p[31:17]&g[16] | &p[31:16]&g[15] | &p[31:15]&g[14] | &p[31:14]&g[13] | &p[31:13]&g[12] | &p[31:12]&g[11] | &p[31:11]&g[10] | &p[31:10]&g[9] | &p[31:9]&g[8] | &p[31:8]&g[7] | &p[31:7]&g[6] | &p[31:6]&g[5] | &p[31:5]&g[4] | &p[31:4]&g[3] | &p[31:3]&g[2] | &p[31:2]&g[1] | &p[31:1]&g[0] | &p[31:0]&c[0];

	assign s = p^c[31:0];

	assign cOut = c[32];

endmodule