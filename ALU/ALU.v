`include "Lrotate32.v"
`include "Rrotate32.v"
`include "Lshift32.v"
`include "Rshift32.v"
`include "wtree_mult_32.v"
`include "CLA32.v"


module ALU(A, B, Sel, Out_1, Out_0, cFlag, zFlag, vFlag);

   input [31:0] A, B;
   input [3:0]  Sel;
   
   output reg [31:0] Out_1, Out_0;
   output reg cFlag, zFlag, vFlag;
   
   reg [31:0] B2comp, A2comp;
   
   reg cFlag_N;

   reg [31:0] A_eff,B_eff;
   reg [4:0] B_5bit;
   
   wire [31:0] add_eff,res_shl,res_shr,res_rol,res_ror,res_sub;
   wire [63:0] mul_eff; 
   wire c_eff,zres; 

   CLA32 A1(A_eff,B_eff,1'b0,add_eff,c_eff);
   wtree_mult_32 A2(A_eff,B_eff,mul_eff);
   Lrotate32 A3(A_eff,B_5bit,res_rol);
   Rrotate32 A4(A_eff,B_5bit,res_ror);  
   Lshift32 A5(A_eff,B_5bit,res_shl);
   Rshift32 A6(A_eff,B_5bit,res_shr);

   assign res_sub = add_eff;
   assign zres = ~|(res_sub[31:0]);

    

   always @ (*) begin
   
        vFlag = 0;
        cFlag = 0;
        zFlag = 0;
        Out_1 = 32'd0;


        B2comp = (~B) + 32'd1;
        A2comp = (~A) + 32'd1;

        A_eff = A;
        B_eff = B;

        case(Sel)
    
            4'd0: begin //ADD
                Out_0 = add_eff;
                cFlag = c_eff;
                
            end
            
            4'd1: begin //SUB           
                B_eff = B2comp;
                Out_0 = add_eff;
                cFlag = ~c_eff;
            end
            
            4'd2: begin //MUL
                Out_0 = mul_eff[31:0];
                Out_1 = mul_eff[63:32];
                cFlag = |(Out_1[31:0]); //For 16bit processors only
            end
            
            4'd3: begin //ShL
                B_5bit = B[4:0];
                Out_0 = res_shl;    
            end
            
            4'd4: begin //ShR
                B_5bit = B[4:0];
                Out_0 = res_shr;
            end
            

            4'd5: begin //RoL
                B_5bit = B[4:0];
                Out_0 = res_rol;
            end
            
            4'd6: begin //RoR
                B_5bit = B[4:0];
                Out_0 = res_ror;
            end
            
            4'd7: begin //AND 
                Out_0 = A & B;
            end

            
            4'd8: begin //OR
                Out_0 = A | B;
            end

            //New

            4'd9: begin //NOR (|)
                Out_0 = A ~| B;
            end

            4'd10: begin //NAND (~)
                Out_0 = A ~& B;
            end

            4'd11: begin //XOR
                Out_0 = A ^ B;
            end

            4'd12: begin //XNOR
                Out_0 = A ~^ B;
            end

            4'd13: begin //NOT
                Out_0 = ~ A;
            end

            4'd14: begin //CMP
                B_eff = B2comp;

                
                if (c_eff == 1'b0) begin 
                    Out_0 = 32'd1;
                end
                if (c_eff == 1'b1 & zres==0) begin 
                    Out_0 = 32'd2;
                end
                if (c_eff == 1'b1 & zres==1) begin 
                    Out_0 = 32'd0;
                end
            end

            4'd15: begin //NEG
                Out_0 = A2comp;
            end

            

            default: $display("Error in ALU-Sel...");
        endcase
        vFlag = ~cFlag;
        zFlag = ~|(Out_0[31:0]);
   end
   
endmodule
