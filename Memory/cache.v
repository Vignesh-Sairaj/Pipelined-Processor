module cache(chipSel, clk, addr, dat, write, miss);

	input chipSel;
	input clk;
	input [7:0] addr;
	inout [31:0] dat;
	input write;
	output reg miss;

	reg [34:0] DM [0:31]; //first 3-bits from MSB = tag

	wire x;
	wire internal_addr;
	reg [31:0] outDat = 32'b0;

	assign internal_addr = addr[4:0];

	assign x=(~write & chipSel);
	assign dat= x ? outDat: 32'bz;
	

	always @ (posedge clk) begin
		if(chipSel) begin
			if(write) begin
				DM[internal_addr] <= {addr[7:5], dat};
				miss <= 1'b0;
			end
			else if (DM[internal_addr][34:32] == addr[7:5]) begin
				outDat <= DM[internal_addr][31:0];
				miss <= 1'b0;
			end

			else begin
				outDat <= DM[internal_addr][31:0];
				miss <= 1'b1;
			end
		end
	end
endmodule