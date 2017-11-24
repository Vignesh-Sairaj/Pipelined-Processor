module mmu(chipSel, clk, addr, dat, write, ready);

	input chipSel;
	input clk;
	input [7:0] addr;
	inout [31:0] dat;
	input write;
	output reg ready;

	reg [31:0] DM [0:255];

	wire x;
	reg [31:0] outDat = 32'b0;

	assign x=(~write & chipSel & ready);
	assign dat = x ? outDat : 32'bz;


	reg memChipSel = 0;
	reg [7:0] memAddr;
	reg [31:0] memTdat;
	reg memWrite;

	wire [31:0]memDat;
	
	mem m(memChipSel,clk,memAddr,memDat,memWrite);
	assign memDat = (memWrite & memChipSel)? memTdat : 32'bz;


	reg caChipSel = 0;
	reg [7:0] caAddr;
	reg [31:0] caTdat;
	reg caWrite;
	wire caMiss;

	wire [31:0]caDat;
	
	cache c(caChipSel,clk,caAddr,caDat,caWrite,caMiss);
	assign caDat = (caWrite & caChipSel)? caTdat : 32'bz;


	reg [1:0] rCycle=2'b0, wCycle=2'b0;


	always @ (posedge clk) begin

		if(rCycle == 2'd0 && wCycle == 2'd0) begin
			if(chipSel) begin
				if(write) begin
					memChipSel <= chipSel;
					memAddr <= addr;
					memTdat <= dat;
					memWrite <= write;

					caChipSel<=chipSel;
					caAddr <= addr;
					caTdat <= dat;
					caWrite <= write;

					ready <= 1'b1;
				end
				else begin
					memChipSel <= 1'b0;

					caChipSel <=chipSel;
					caAddr <= addr;
					caWrite <= write;

					ready <= 1'b0;
					rCycle <= 2'd1;
				end
			end

			else begin
				memChipSel <= 1'b0;
				caChipSel <= 1'b0;
			end
		end

		else if(rCycle == 1) begin
			if(!caMiss) begin

				memChipSel <= 1'b0;
				caChipSel <= 1'b0;

				outDat <= caDat;

				ready <= 1'b1;
				rCycle <= 2'd0;
			end
			else begin
				caChipSel <= 1'b0;

				memChipSel <= caChipSel;
				memAddr <= caAddr;
				memWrite <= caWrite;

				ready <= 1'b0;
				rCycle <= 2'd2;
			end
		end

		else if(rCycle == 2) begin
			memChipSel <= 1'b0;

			outDat <= memDat;


			caChipSel<=memChipSel;
			caAddr <= memAddr;
			caTdat <= memDat;
			caWrite <= memWrite;


			ready <= 1'b1;
			rCycle <= 2'd0;
		end


	end
endmodule
