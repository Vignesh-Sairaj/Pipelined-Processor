`include "FPU_Cmp.v"
`include "FPM_32.v"
`include "FP_AddSub.v"

module FPU(A, B, Sel,Out_0, clk);

	input [31:0] A, B;
	input [1:0]  Sel;
	input clk;
	   
	output reg [31:0] Out_0;

	reg [31:0] A_eff,B_eff;

	wire [31:0]res_addsub,res_mul,res_cmp;
	reg ch_eff;
	

	FP_AddSub F1(ch_eff,A_eff,B_eff,res_addsub,clk);
	FPM_32 F2(A_eff, B_eff,res_mul, clk);
	FPU_Cmp F3(A_eff, B_eff, res_cmp);

    always @ (*) begin
	
		A_eff = A;
		B_eff = B;

        case(Sel)
    
            4'd0: begin //ADD
				ch_eff = 1'b0;
                Out_0 = res_addsub;
				
                
            end
            
            4'd1: begin //SUB           
				ch_eff = 1'b1;
                Out_0 = res_addsub;
            end
            
            4'd2: begin //MUL
				Out_0 = res_mul;
            end
            
            4'd3: begin //CMP
                Out_0 = res_cmp;	
            end
		endcase
	end


endmodule
