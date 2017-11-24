`include "mem.v"

module mem_tb;
	// Inputs
	reg chipSel;
	reg clk;
	reg [7:0] addr;
	reg [31:0] tdat;
	reg write;

	wire [31:0]dat;
	
mem m1(chipSel,clk,addr,dat,write);

assign dat = (write & chipSel)? tdat : 32'bz;

integer i=0;

initial begin
	$monitor("\n\nTime: %3d ClkCycle: %d\nInput:\n\n  Addr = %d\n  TData = %3d, Write = %b\n\nOuput:\n\n  Data = %3d", $time, i, addr, tdat, write, dat);
	// Initialize Inputs	// Initialize Inputs
	chipSel = 1'b1;
	clk = 0;
	tdat = 0;
	addr = 0;
	write = 0;
	// Wait 100 ns for global reset to finish

	// Add stimulus here

	#2 tdat = 32'd15;
	#1 write = 1'b1;
	#1 addr = 8'd1;

	#1;
	//clk posedge - time - 5

	#5;

	//clk negedge - time - 10
	#2 addr = 8'd2;
	#1 tdat = 32'd14;
	#2;
	//clk posedge - time - 15

	#1 write = 1'b0;
	#8 addr = 8'd1;

	#1; //posedge clk - time - 25 

	#9 addr = 8'd1;

	#1; //posedge clk - time - 35 

	#9 addr = 8'd2;

	#1; //posedge clk - time - 45

	#9 addr = 8'd34;

	#1; //posedge clk - time - 55

	#10 $finish;
end
always begin
	#5 clk = ~clk;
end

always @(posedge clk) begin
	i = i + 1;
end
endmodule
