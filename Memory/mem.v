module mem(chipSel, clk, addr, dat, write);

	input chipSel;
	input clk;
	input [7:0] addr;
	inout [31:0] dat;
	input write;

	reg [31:0] DM [0:255];

	wire x;
	reg [31:0] outDat = 32'b0;

	assign x=(~write & chipSel);

	assign dat= x ? outDat : 32'bz;


	always @ (posedge clk) begin
		if(chipSel) begin
			if(write) begin
				DM[addr] <= dat;
			end
			else begin
				outDat <= DM[addr];
			end
		end
	end
endmodule
