`include "ALU.v"

module ALU_tb;

    reg [31:0] A, B;
    reg [3:0] Sel;


    wire [31:0] Out_1, Out_0;
    wire cFlag, zFlag, vFlag;
    
    reg [31:0] B2comp;

    ALU U1(A, B, Sel, Out_1, Out_0, cFlag, zFlag, vFlag);
    
    initial begin
        
        A = 32'd1; B = 32'd2;
        Sel = 4'd0;
        
        #2 $display("\n\nA = %d, B = %d:\n\tA + B = %d\n\tCarry? : %b\tZero? : %b \n\tValid? : %b\t", A, B, Out_0, cFlag, zFlag, vFlag);
        
        
        
        A = 32'd2; B = 32'd3;
        Sel = 4'd1; B2comp = (~B) + 1;
        
        #2 $display("\n\nA = %d, B = %d, B2comp = %d:\n\tA - B = %d\n\tCarry? : %b\tZero? : %b \n\tValid? : %b\t", A, B, B2comp, Out_0, cFlag, zFlag, vFlag);
        
        
        A = 32'd1; B=32'd2;
        Sel = 4'd2;
        
        #2 $display("\n\nA = %d, B = %d:\n\tA * B = %d\n\tCarry? : %b\tZero? : %b \n\tValid? : %b\t", A, B, Out_0, cFlag, zFlag, vFlag);
        
        
        
        A = 32'd1;
        Sel = 4'd3;
        
        #2 $display("\n\nA = %b:\n\tA << 1 = %b\n\tCarry? : %b\tZero? : %b \n\tValid? : %b\t", A, Out_0, cFlag, zFlag, vFlag);
        
        
        
        A = 32'd1;
        Sel = 4'd4;
        
        #2 $display("\n\nA = %b\n\tA >> 1 = %b\n\tCarry? : %b\tZero? : %b \n\tValid? : %b\t", A, Out_0, cFlag, zFlag, vFlag);
        
        
        
        A = 32'd1; 
        Sel = 4'd5;
        
        #2 $display("\n\nA = %b\n\tA << RoL = %b\n\tCarry? : %b\tZero? : %b \n\tValid? : %b\t", A, Out_0, cFlag, zFlag, vFlag);
        
        
        
        A = 32'd1; 
        Sel = 4'd6;
        
        #2 $display("\n\nA = %b\n\tA >> RoR = %b\n\tCarry? : %b\tZero? : %b \n\tValid? : %b\t", A, Out_0, cFlag, zFlag, vFlag);
        
        
        
        A = 16'd1; B = 16'd2;
        Sel = 4'd7;
        
        #2 $display("\n\nA = %b, B = %b:\n\tA & B = %b\n\tCarry? : %b\tZero? : %b \n\tValid? : %b\t", A, B, Out_0, cFlag, zFlag, vFlag);
        
        
        
        A = 32'd1; B = 32'd2;
        Sel = 4'd8;
        
        #2 $display("\n\nA = %b, B = %b:\n\tA | B = %b\n\tCarry? : %b\tZero? : %b \n\tValid? : %b\t", A, B, Out_0, cFlag, zFlag, vFlag);


        
        A = 32'd1; B = 32'd2;
        Sel = 4'd9;
        
        #2 $display("\n\nA = %b, B = %b:\n\tA ~| B = %b\n\tCarry? : %b\tZero? : %b \n\tValid? : %b\t", A, B, Out_0, cFlag, zFlag, vFlag);



        A = 32'd1; B = 32'd2;
        Sel = 4'd10;
        
        #2 $display("\n\nA = %b, B = %b:\n\tA ~& B = %b\n\tCarry? : %b\tZero? : %b \n\tValid? : %b\t", A, B, Out_0, cFlag, zFlag, vFlag);



        A = 32'd1; B = 32'd2;
        Sel = 4'd11;

        #2 $display("\n\nA = %b, B = %b:\n\tA ^ B = %b\n\tCarry? : %b\tZero? : %b \n\tValid? : %b\t", A, B, Out_0, cFlag, zFlag, vFlag);



        A = 32'd1; B = 32'd2;
        Sel = 4'd12;
        
        #2 $display("\n\nA = %b, B = %b:\n\tA ~^ B = %b\n\tCarry? : %b\tZero? : %b \n\tValid? : %b\t", A, B, Out_0, cFlag, zFlag, vFlag);



        A = 32'd1; 
        Sel = 4'd13;
        
        #2 $display("\n\nA = %b:\n\t~A = %b\n\tCarry? : %b\tZero? : %b \n\tValid? : %b\t", A, Out_0, cFlag, zFlag, vFlag);



        A = 32'd5; B = 32'd5;
        Sel = 4'd14;
        
        #2 $display("\n\nA = %b, B = %b:\n\tA == B = %b\n\tCarry? : %b\tZero? : %b \n\tValid? : %b\t", A, B, Out_0, cFlag, zFlag, vFlag);



        A = 32'd1; B = 32'd2;
        Sel = 4'd15;
        
        #2 $display("\n\nA = %b:\n\t -A = %b\n\tCarry? : %b\tZero? : %b \n\tValid? : %b\t", A, Out_0, cFlag, zFlag, vFlag);



        $finish;
    
    end

endmodule
