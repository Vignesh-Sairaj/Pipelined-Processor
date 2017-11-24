`include "cache.v"

module cache_tb;
	// Inputs
	reg chipSel;
	reg clk;
	reg [7:0] addr;
	reg [31:0] tdat;
	reg write;

	wire [31:0]dat;
	wire miss;
	
cache m1(chipSel,clk,addr,dat,write, miss);

assign dat = (write & chipSel)? tdat : 32'bz;

integer i=0;

initial begin
	$monitor("\n\nTime: %3d ClkCycle: %3d\nInput:\n\n  Addr = %d\n  TData = %3d, Write = %b\n\nOuput:\n\n  Data = %3d, miss = %b", $time, i, addr, tdat, write, dat, miss);

	chipSel = 1'b1;
	clk = 0;
	tdat = 0;
	addr = 0;
	write = 0;
	// Wait 100 ns for global reset to finish
	#100;
	// Add stimulus here

	#2 tdat = 32'd15;
	#1 write = 1'b1;
	#1 addr = 8'd1;

	#1;
	//clk posedge

	#5;

	//clk negedge
	#2 addr = 8'd2;
	#1 tdat = 32'd14;
	#2;
	//clk posedge

	#1 write = 1'b0;
	#8 addr = 8'd1;

	#1; //posedge clk

	#9 addr = 8'd1;

	#1; //posedge clk

	#9 addr = 8'd2;

	#1; //posedge clk

	#9 addr = 8'd34;

	#1; //posedge clk

	#10 $finish;
end
always begin
	#5 clk = ~clk;
end

always @(posedge clk) begin
	i = i + 1;
end
endmodule
