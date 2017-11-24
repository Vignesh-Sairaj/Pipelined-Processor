`include "CLA24.v"



`ifndef _addSubSign24_
`define _addSubSign24_
module addSubSign24(ch, Sa, Sb, Maps, Mbps, Sc, cOut, Mcps);

	input ch, Sa, Sb;
	input [23:0] Maps, Mbps;

	output reg [23:0] Mcps;
	output reg Sc, cOut;

	reg Sb_eff, add, cIn;
	reg [23:0] Maps_eff, Mbps_eff;


	wire cOut_int, cOut_comp;
	wire [23:0] Mcps_int, Mcps_comp;


	CLA24 A1(Maps_eff, Mbps_eff, cIn, Mcps_int, cOut_int);
	CLA24 A2(~Mcps_int, 24'b0, 1'b1, Mcps_comp, cOut_comp);

	always @(*) begin

		Sb_eff = ch ? ~Sb : Sb;
		add = Sa ~^ Sb_eff;

		if (add) begin

			cIn = 1'b0;
			Maps_eff = Maps;
			Mbps_eff = Mbps;

			if (~Sa & ~Sb_eff) begin //A+B
				Sc = 1'b0; //+ve
			end
			else begin// -(A+B)
				Sc = 1'b1; //-ve
			end

			Mcps = Mcps_int;
			cOut = cOut_int;
		end

		else begin //sub

			cIn = 1'b1;
			cOut = 1'b0;

			if(~Sa & Sb_eff) begin //A-B
				Maps_eff = Maps;
				Mbps_eff = ~Mbps;
			end
			else begin //B-A
				Maps_eff = Mbps;
				Mbps_eff = ~Maps;
			end

			if (cOut_int) begin
				Sc = 1'b0; //+ve
				Mcps = Mcps_int;
			end
			else begin
				Sc = 1'b1; //-ve
				Mcps = Mcps_comp;
			end
		end
	end
endmodule
`endif