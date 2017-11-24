module InstrMem(chipSel, clk, addr, dat, write);

	input chipSel;
	input clk;
	input [7:0] addr;
	inout [31:0] dat;
	input write;

	integer i;

	reg [31:0] IM [0:255];

	wire x;
	reg [31:0] outDat = 32'b0;


	assign x=(~write & chipSel);
	assign dat= x ? outDat : 32'bz;


	always @ (posedge clk) begin
		if(chipSel) begin
			if(write) begin
				IM[addr] <= dat;
			end
			else begin
				outDat <= IM[addr];
			end
		end
	end

	//INITIALIZE INSTRUCTIONS
	initial begin
        
        for(i = 0; i < 2**8-1; i = i+1) begin
            IM[i] = 32'd0;
        end
/*        //FRC R0 to 9
        IM[0][31:28] = 4'd8;
        IM[0][23:19] = 5'd0;
        IM[0][15:0] = 16'd9;

        //FRC R1 to 9
        IM[1][31:28] = 4'd8;
        IM[1][23:19] = 5'd1;
        IM[1][15:0] = 16'd9;


        //FRC R10 to 0
        IM[2][31:28] = 4'd8;
        IM[2][23:19] = 5'd10;
        IM[2][15:0] = 16'd0;


        //STORE FROM R0 TO @R10 = M0 
        IM[3][31:28] = 4'd4;
        IM[3][27] = 1'd1; //write
        IM[3][23:19] = 5'd0; //R0
        IM[3][18:14] = 5'd10; //[R10]
        IM[3][13:6] = 8'd0; //offset = 0


        // R0-R1->R2
        IM[4][31:28] = 4'd1;
        IM[4][27:24] = 4'd1;
        IM[4][23:19] = 5'd0;
        IM[4][18:14] = 5'd1;
        IM[4][13:9] = 5'd2;


        //BNZ to location IM[7] (SNZ)
        IM[5][31:28] = 4'd2;
        IM[5][27:25] = 3'd5; //opcode
        IM[5][24] = 1'd1; //Direct Address
        IM[5][18:11] = 8'd7; //Address 7

        //BSA TO IM[100]
        IM[6][31:28] = 4'd2;
        IM[6][27:25] = 3'd1;
        IM[6][24] = 1'd1; //Direct Address
        IM[6][18:11] = 8'd100; //Address 100


        //FRC R10 to 0
        IM[100][31:28] = 4'd8;
        IM[100][23:19] = 5'd10;
        IM[100][15:0] = 16'd0;

        //STORE FROM R2 TO @R10 = M0 
        IM[101][31:28] = 4'd4;
        IM[101][27] = 1'd1; //write
        IM[101][23:19] = 5'd2; //R2
        IM[101][18:14] = 5'd10; //[R10]
        IM[101][13:6] = 8'd0; //offset = 0


        //RET
        IM[102][31:28] = 4'd2;
        IM[102][27:25] = 3'd2;


        //LOAD FROM @R10 = M0 TO R3
        IM[7][31:28] = 4'd4;
        IM[7][27] = 1'd0; //read
        IM[7][23:19] = 5'd3; //R3
        IM[7][18:14] = 5'd10; //[R10]
        IM[7][13:6] = 8'd0; //offset = 0

        // R3-R10->R4
        IM[8][31:28] = 4'd1;
        IM[8][27:24] = 4'd1;
        IM[8][23:19] = 5'd3;
        IM[8][18:14] = 5'd10;
        IM[8][13:9] = 5'd4;

        //HLT
        IM[9][31:28] = 4'd2;
        IM[9][27:25] = 3'd3;*/


        //FIBONACCI
        //0)FRC R31 to n
        //1)FRC R10 to 0
		//2)FRC R11 to 1
        //3)FRC R0 to 0
        //4)FRC R1 to 1
		//5)CMP R31, 0 //Loop
		//6)BIZ Instr (12)//exit
		//7)ADD R0, R1    -> R2
		//8)ADD R1, R10   -> R0
		//9)ADD R2, R10   -> R1
		//10)SUB R31, R11 -> R31
		//11)BNZ Instr (7) //B loop
		//12)ADD R0, R10  -> R2


        //0)FRC R31 to n=6
        IM[0][31:28] = 4'd8;
        IM[0][23:19] = 5'd31;
        IM[0][15:0] = 16'd6;


        //1)FRC R10 to 0
        IM[1][31:28] = 4'd8;
        IM[1][23:19] = 5'd10;
        IM[1][15:0] = 16'd0;


		//2)FRC R11 to 1
        IM[2][31:28] = 4'd8;
        IM[2][23:19] = 5'd11;
        IM[2][15:0] = 16'd1;

        //3)FRC R0 to 0
        IM[3][31:28] = 4'd8;
        IM[3][23:19] = 5'd0;
        IM[3][15:0] = 16'd0;

        //4)FRC R1 to 1
        IM[4][31:28] = 4'd8;
        IM[4][23:19] = 5'd1;
        IM[4][15:0] = 16'd1;


		//5)CMP R31, R10 -> R2 //Loop
        IM[5][31:28] = 4'd1; //alu
        IM[5][27:24] = 4'd14; //cmp
        IM[5][23:19] = 5'd31; //R31
        IM[5][18:14] = 5'd10; //0
        IM[5][13:9] = 5'd2; //R2


		//6)BIZ Instr (12) //exit
        IM[6][31:28] = 4'd2;
        IM[6][27:25] = 3'd4; // BIZ opcode
        IM[6][24] = 1'd1; //Direct Address
        IM[6][18:11] = 8'd12; //Address 12


		//7)ADD R0, R1    -> R2
		IM[7][31:28] = 4'd1; //alu
        IM[7][27:24] = 4'd0; //add
        IM[7][23:19] = 5'd0; //R0
        IM[7][18:14] = 5'd1; //R1
        IM[7][13:9] = 5'd2; //R2


		//8)ADD R1, R10   -> R0
		IM[8][31:28] = 4'd1; //alu
        IM[8][27:24] = 4'd0; //add
        IM[8][23:19] = 5'd1; //R1
        IM[8][18:14] = 5'd10; //R10
        IM[8][13:9] = 5'd0; //R0

		//9)ADD R2, R10   -> R1
		IM[9][31:28] = 4'd1; //alu
        IM[9][27:24] = 4'd0; //add
        IM[9][23:19] = 5'd2; //R2
        IM[9][18:14] = 5'd10; //R10
        IM[9][13:9] = 5'd1; //R1

		//10)SUB R31, R11 -> R31
		IM[10][31:28] = 4'd1; //alu
        IM[10][27:24] = 4'd1; //SUB
        IM[10][23:19] = 5'd31; //R31
        IM[10][18:14] = 5'd11; //R11
        IM[10][13:9] = 5'd31; //R31

		//11)BNZ Instr (7) //B loop
        IM[11][31:28] = 4'd2;
        IM[11][27:25] = 3'd5; // BNZ opcode
        IM[11][24] = 1'd1; //Direct Address
        IM[11][18:11] = 8'd7; //Address 7

		//12)ADD R0, R10  -> R2
		IM[12][31:28] = 4'd1; //alu
        IM[12][27:24] = 4'd0; //add
        IM[12][23:19] = 5'd0; //R0
        IM[12][18:14] = 5'd10; //R10
        IM[12][13:9] = 5'd2; //R2

        //HLT
        IM[13][31:28] = 4'd2;
        IM[13][27:25] = 3'd3;


       end
endmodule