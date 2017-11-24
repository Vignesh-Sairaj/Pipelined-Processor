`include "FPU.v"

module FPU_tb;

    reg [31:0] A, B;
    reg [1:0] Sel;
	reg clk=1;

    wire [31:0] Out_0;

    



    FPU U1(A, B, Sel,  Out_0, clk);
    


  always begin
    #1 clk = ~clk;
  end	


    initial begin
        
        A = 32'b01000001101110000000000000000000; B = 32'b01000001101110000000000000000000;
        Sel = 2'd0;
        
        #12 $display("\n\nA = %b, B = %b:\n\tA + B = %b\n", A, B, Out_0);
        
        
        
        A = 32'b01000001101110000000000000000000; B = 32'b01000001101110000000000000000000;
        Sel = 2'd1; 
        
        #12 $display("\n\nA = %b, B = %b:\n\tA - B = %b\n", A, B, Out_0);
        
        
        A = 32'b01000001101110000000000000000000; B = 32'b01000001101110000000000000000000;
        Sel = 2'd2;
        
        #12 $display("\n\nA = %b, B = %b:\n\tA * B = %b\n", A, B, Out_0);
        
        
        
        A = 32'b01000001101110000000000000000000; B = 32'b01000001101110000000000000000001;
        Sel = 2'd3;
        
        #12 $display("\n\nA = %b, B = %b:\n\tA CMP B = %b\n", A, B, Out_0);
        
       

        $finish;
    
    end

endmodule
