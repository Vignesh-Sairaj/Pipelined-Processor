
`ifndef _shiftCounter_
`define _shiftCounter_

module shiftCounter(cOut, Mcps, LRbar, numBits);

	input cOut;
	input [23:0] Mcps;

	output reg LRbar;
	output reg [4:0] numBits;

	reg [4:0] numBitsTemp;


	always @(*) begin
		if(cOut) begin
			LRbar = 1'b0;
			numBits = 1'b1;
		end

		else begin
			LRbar = 1'b1;

			if (Mcps[23]) begin
				numBitsTemp = 5'd0;
			end

			if (~|Mcps[23:23] & Mcps[22]) begin
				numBitsTemp = 5'd1;
			end

			if (~|Mcps[23:22] & Mcps[21]) begin
				numBitsTemp = 5'd2;
			end

			if (~|Mcps[23:21] & Mcps[20]) begin
				numBitsTemp = 5'd3;
			end

			if (~|Mcps[23:20] & Mcps[19]) begin
				numBitsTemp = 5'd4;
			end

			if (~|Mcps[23:19] & Mcps[18]) begin
				numBitsTemp = 5'd5;
			end

			if (~|Mcps[23:18] & Mcps[17]) begin
				numBitsTemp = 5'd6;
			end

			if (~|Mcps[23:17] & Mcps[16]) begin
				numBitsTemp = 5'd7;
			end

			if (~|Mcps[23:16] & Mcps[15]) begin
				numBitsTemp = 5'd8;
			end

			if (~|Mcps[23:15] & Mcps[14]) begin
				numBitsTemp = 5'd9;
			end

			if (~|Mcps[23:14] & Mcps[13]) begin
				numBitsTemp = 5'd10;
			end

			if (~|Mcps[23:13] & Mcps[12]) begin
				numBitsTemp = 5'd11;
			end

			if (~|Mcps[23:12] & Mcps[11]) begin
				numBitsTemp = 5'd12;
			end

			if (~|Mcps[23:11] & Mcps[10]) begin
				numBitsTemp = 5'd13;
			end

			if (~|Mcps[23:10] & Mcps[9]) begin
				numBitsTemp = 5'd14;
			end

			if (~|Mcps[23:9] & Mcps[8]) begin
				numBitsTemp = 5'd15;
			end

			if (~|Mcps[23:8] & Mcps[7]) begin
				numBitsTemp = 5'd16;
			end

			if (~|Mcps[23:7] & Mcps[6]) begin
				numBitsTemp = 5'd17;
			end

			if (~|Mcps[23:6] & Mcps[5]) begin
				numBitsTemp = 5'd18;
			end

			if (~|Mcps[23:5] & Mcps[4]) begin
				numBitsTemp = 5'd19;
			end

			if (~|Mcps[23:4] & Mcps[3]) begin
				numBitsTemp = 5'd20;
			end

			if (~|Mcps[23:3] & Mcps[2]) begin
				numBitsTemp = 5'd21;
			end

			if (~|Mcps[23:2] & Mcps[1]) begin
				numBitsTemp = 5'd22;
			end

			if (~|Mcps[23:1] & Mcps[0]) begin
				numBitsTemp = 5'd23;
			end

			// //Special Val
			// if (~|Mcps[23:0]) begin
			// 	numBitsTemp = 5'd24;
			// end

			if (~|Mcps[23:0]) begin
				numBitsTemp = 5'd0;
			end

			numBits = numBitsTemp;
		end
	end



endmodule
`endif