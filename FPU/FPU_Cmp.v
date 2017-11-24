`include "CLA8.v"
`include "CLA24.v"

module FPU_Cmp(A,B,C);

	input [31:0] A,B;
	output reg [31:0]C;
	
	wire [7:0]exA,exB,exres,exB2comp;
	wire siA,siB,sires;
	wire [23:0]maA,maB,mares,maB2comp;
	wire cex,cma,zres,zres1;

	wire [1:0]exg,sig,mag;

	assign exA = A[30:23];
	assign exB = B[30:23];

	assign maA = {1'b0,A[22:0]};
	assign maB = {1'b0,B[22:0]};

	assign exB2comp = (~exB) + 8'd1;
	assign maB2comp = (~maB) + 24'd1;


	assign siA = A[31];
	assign siB = B[31];



	assign sig = {siA,siB};


	CLA8 C1(exA,exB2comp,1'b0,exres,cex);
	CLA24 C2(maA,maB2comp,1'b0,mares,cma);

	assign zres = ~|(exres[7:0]);
	assign zres1 = ~|(mares[23:0]);

	always @ (*) begin

		if(sig == 2'd2)
			C = 32'd1;
		else if(sig == 2'd1)
			C = 32'd2;
		else begin
				

				


				if(cex == 1'b0 & sig == 2'd0)
					C=32'd1;
				else if (cex == 1'b0 & sig ==2'd3)
					C=32'd2;
				else if (zres == 1'b0 & sig == 2'd0)
					C=32'd2;
				else if (zres == 1'b0 & sig == 2'd3)
					C=32'd1;
				else begin
						

						


						if(cma == 1'b0 & sig == 2'd0)
							C=32'd1;
						else if (cma == 1'b0 & sig ==2'd3)
							C=32'd2;
						else if (zres1 == 1'b0 & sig == 2'd0)
							C=32'd2;
						else if (zres1 == 1'b0 & sig == 2'd3)
							C=32'd1;
						else
							C=32'd0;
					end
				end
			end
endmodule
