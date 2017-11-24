`include "./ALU/ALU.v"
`include "./Memory/InstrMem.v"
`include "./Memory/DatMem.v"
`include "./FPU/FPU.v"


module PipelinedProcessor(fastClk);

    input fastClk; //6 times faster than clk
    reg [1:0] clkCounter = 2'b0; //used to count 3 fast clock cycles to switch clk
    reg clk=1'b0; //6 times slower than fastClk

    reg halt=1'b0;
    reg [3:0] seqCtr = 4'd0; //INIT TO 0
    reg [31:0] progCtr = 31'd0; //Only last 8 bits actually used

    //Instr Registers down the pipeline
    reg [31:0] instrReg;
    reg [31:0] exStageInstrReg;
    reg [31:0] memStageInstrReg;

    reg [31:0] ALU_result;
    reg [31:0] FPU_result;

    //Register file
    reg [31:0] Reg [0:31];


    //ALU
    reg [31:0] A, B;
    reg [3:0] Sel = 4'd0;
    wire [31:0] Out_1, Out_0;
    wire cFlag, zFlag, vFlag;

    //FPU
    reg [31:0] fA, fB;
    reg [1:0] fSel;
    wire [31:0] fOut_0;

    //Registers
    reg [31:0] Rdst;
    reg [4:0] Rdst_addr = 5'd0, Rsrc1_addr = 5'd0, Rsrc2_addr = 5'd0; //INIT TO 0
    wire [31:0] Rsrc1, Rsrc2;

    //InstrMem
    reg imChipSel = 1'b1;
    reg imWrite = 1'b0; //INIT TO READ
    reg [31:0] imWrDat;
    reg [7:0] imDat_addr = 8'd0; //INIT TO 0
    wire [31:0] imDat;


    //DataMem
    reg dmChipSel = 1'b1;
    reg dmWrite = 1'b0; //INIT TO READ
    reg [31:0] dmWrDat;
    reg [7:0] dmDat_addr = 8'd0; //INIT TO 0
    wire [31:0] dmDat;

    //Dealing with Hazards

    //Branches take preccedence over stalls due to RAW

    //Control Hazards
    reg [4:0] invalidStages = 5'd0; //5-bits representing which of the 5 stages have been invalidated, shifted left every clk cycle
    reg branchTaken = 1'b0;
    reg [31:0] branchProgCtr = 32'd0; //Alternate PC
    reg [31:0] linkReg; // LR
    

    //RAW Dependancies
    reg [5:0] regInEx=6'd32, regInMem=6'd32, regInUse=6'd32; //32 stands for no register in use, values from 0-31 correspond to each register
    reg [1:0] stallCtr = 2'd0; //No of cycles left to stall (stalls IF and ID stages)

    //Instantiations
    ALU alu(A, B, Sel, Out_1, Out_0, cFlag, zFlag, vFlag);
    FPU fpu(fA, fB, fSel, fOut_0, fastClk);

    InstrMem IM(imChipSel, fastClk, imDat_addr, imDat, imWrite);
    DatMem   DM(dmChipSel, fastClk, dmDat_addr, dmDat, dmWrite);

/*    initial begin
        for(integer i=0; i < 32; i=i+1) begin
            RegInUse[i] = 2'd0;
        end
    end*/

    //Setting the protocol for the inout ports
    assign imDat = (imWrite & imChipSel)? imWrDat : 32'bz;
    assign dmDat = (dmWrite & dmChipSel)? dmWrDat : 32'bz;

    always @(posedge fastClk) begin
        clkCounter <= (clkCounter + 2'd1) % 2'd3; //Counts 3 fast clock cycles
        clk <= (clkCounter == 0)? ~clk : clk; //Switch every 3 fast clock cycles, 6 times slower
        //$display($time, ") clkCounter = %d\n", clkCounter);
    end


    //IF -- Instruction Fetch
    always @(posedge clk) begin

        if(~invalidStages[0]) begin                
            if (branchTaken) begin //for branches
                //Fetch Instruction by setting write to 0 and address to PC
                imWrite <= 1'b0;
                imDat_addr <= branchProgCtr[7:0];
                progCtr <= branchProgCtr+1;
            end
            else begin
                //Branch stalls take precedence over RAW stalls
                //no stall
                if (stallCtr == 0) begin
                    //Fetch Instruction by setting write to 0 and address to PC
                    imWrite <= 1'b0;
                    imDat_addr <= progCtr[7:0];
                    progCtr <= progCtr+1; 
                end
                //stall
                else begin
                    imWrite <= imWrite;
                    imDat_addr <= imDat_addr;
                    progCtr <= progCtr; 
                end
            end
        end
    end

    //ID -- Instruction Decode
    always @(posedge clk) begin
        if(~invalidStages[1]) begin
            if (stallCtr == 0) begin
                case(imDat[31:28]) //Typeof instruction

                    4'd1: begin //ALU instruction
                        //NOT or NEG, single source operand
                        if( imDat[27:24]==4'd13 || imDat[27:24]==4'd15 ) begin

                            if (regInEx == {1'b0, imDat[23:19]}) begin
                                stallCtr <= 2'd2;
                                regInEx <= 6'd32;

                            end
                            else if (regInMem == {1'b0, imDat[23:19]}) begin
                                stallCtr <= 2'd1;
                                regInEx <= 6'd32;
                            end
                            else begin
                                stallCtr <= 2'd0;
                                regInEx <= {1'b0, imDat[13:9]};
                            end
                        end
                        // All others
                        else begin
                            if (regInEx == {1'b0, imDat[23:19]} || regInEx == {1'b0, imDat[18:14]}) begin
                                stallCtr <= 2'd2;
                                regInEx <= 6'd32;
                            end
                            else if (regInMem == {1'b0, imDat[23:19]} || regInMem == {1'b0, imDat[18:14]}) begin
                                stallCtr <= 2'd1;
                                regInEx <= 6'd32;
                            end
                            else begin
                                stallCtr <= 2'd0;
                                regInEx <= {1'b0, imDat[13:9]};
                            end
                        end

                        regInMem <= regInEx;
                        //dest Register
                        regInUse <= {1'b0, imDat[13:9]};
                    end

                    4'd2: begin //CONTROL
                        //HLT and RET, no dependencies
                        if( imDat[27:25]==3'd2 || imDat[27:25]==3'd2 ) begin
                            regInMem <= regInEx;
                            //NO dest Register
                            regInEx <= 6'd32;
                            regInUse <= 6'd32;
                            stallCtr <= 2'd0;
                        end
                        //
                        else begin
                            stallCtr <= (regInEx == {1'b0, imDat[23:19]})? 2'd2 : ( (regInMem == {1'b0, imDat[23:19]})? 2'd1 : 2'd0 );
                            regInMem <= regInEx;
                            //NO dest Register
                            regInEx <= 6'd32;
                            regInUse <= 6'd32;
                        end
                    end

                    4'd4: begin  // MEM
                        if(~imDat[27]) begin //LOAD
                            //Only Data Reg can have RAW dependancy reg imDat[18:14]

                            if (regInEx == {1'b0, imDat[18:14]}) begin
                                stallCtr <= 2'd2;
                                regInEx <= 6'd32;

                            end
                            else if (regInMem == {1'b0, imDat[18:14]}) begin
                                stallCtr <= 2'd1;
                                regInEx <= 6'd32;
                            end
                            else begin
                                stallCtr <= 2'd0;
                                regInEx <= {1'b0, imDat[23:19]};
                            end

                            regInMem <= regInEx;
                            //dest Register
                            regInUse <= {1'b0, imDat[23:19]}; //Load to register
                        end
                        else begin //STORE
                            //Both data and address registers may have a RAW dependancy
                            if (regInEx == {1'b0, imDat[23:19]} || regInEx == {1'b0, imDat[18:14]}) begin
                                stallCtr <= 2'd2;
                            end
                            else if (regInMem == {1'b0, imDat[23:19]} || regInMem == {1'b0, imDat[18:14]}) begin
                                stallCtr <= 2'd1;
                            end
                            else begin
                                stallCtr <= 2'd0;
                            end
                            regInMem <= regInEx;
                            //NO dest Register
                            regInEx <= 6'd32;
                            regInUse <= 6'd32;
                        end
                    end

                    4'd8: begin // FORCE CONSTANT
                        stallCtr <= 2'd0;
                        regInMem <= regInEx;
                        //Dest Register
                        regInEx <= {1'b0, imDat[23:19]};
                        regInUse <= {1'b0, imDat[23:19]};
                    end
                    4'd15: begin //FPU

                        if (regInEx == {1'b0, imDat[23:19]} || regInEx == {1'b0, imDat[18:14]}) begin
                            stallCtr <= 2'd2;
                            regInEx <= 6'd32;
                        end
                        else if (regInMem == {1'b0, imDat[23:19]} || regInMem == {1'b0, imDat[18:14]}) begin
                            stallCtr <= 2'd1;
                            regInEx <= 6'd32;
                        end
                        else begin
                            stallCtr <= 2'd0;
                            regInEx <= {1'b0, imDat[13:9]};
                        end
                        regInMem <= regInEx;
                        //dest Register
                        regInUse <= {1'b0, imDat[13:9]};
                    end
                endcase
                //Store Instruction to instrReg, common to all types
                instrReg <= imDat;
            end

            //Stalling
            else begin
                stallCtr <= stallCtr-1;
                regInMem <= regInEx;
                instrReg <= instrReg;

                regInUse <= regInUse;
                if (stallCtr > 1) begin
                    //NO dest Register
                    regInEx <= 6'd32;
                end
                else begin //stallCtr == 1, last stall, update dependancies
                    regInEx <= regInUse;
                end
            end
        end

        //Invalid
        else begin
            stallCtr <= 2'd0;
            regInMem <= regInEx;
            //NO dest Register
            regInEx <= 6'd32;
        end
    end


    //EX -- Execute
    always @(posedge clk) begin
        if(~halt) begin
            if(~invalidStages[2]) begin
                if (stallCtr == 0) begin
                    case(instrReg[31:28]) //Typeof instruction

                        4'd1: begin //ALU instruction
                            //NOT or NEG, single source operand
                            if( instrReg[27:24]==4'd13 || instrReg[27:24]==4'd15 ) begin
                                A <= Reg[instrReg[23:19]];
                                B <= 32'd0;
                            end
                            else begin
                                A <= Reg[instrReg[23:19]];
                                B <= Reg[instrReg[18:14]];
                            end
                            Sel <= instrReg[27:24]; //opcode

                            branchTaken <= 1'b0;
                            invalidStages <= invalidStages << 1;

                            $display("(%3d) ALU instruction, opcode=%2d\n\tR[%2d] A=%d \n\tR[%2d] B=%d\n\n", progCtr-2, instrReg[27:24], instrReg[23:19], Reg[instrReg[23:19]], instrReg[18:14], Reg[instrReg[18:14]]);
                        end

                        4'd2: begin //CONTROL instruction
                            case(instrReg[27:25])
                                    3'd0: begin  //BUN
                                        invalidStages <= (invalidStages | 5'd3) << 1; //invalidate IF and ID stages, and shiftleft
                                        branchTaken <= 1'b1;
                                        branchProgCtr <= instrReg[24]? instrReg[18:11] : Reg[instrReg[23:19]]; //direct/reg indirect
                                        $display("(%3d) BUN, Addressing: %b (reg indir-0, dir-1), R[%2d], M[%3d]\n\n", progCtr-2, instrReg[24], instrReg[23:19], instrReg[18:11]);
                                    end  
                                    3'd1: begin  //BSA
                                        invalidStages <= (invalidStages | 5'd3) << 1; //invalidate IF and ID stages, and shiftleft
                                        branchTaken <= 1'b1;
                                        branchProgCtr <= instrReg[24]? instrReg[18:11] : Reg[instrReg[23:19]]; //direct/reg indirect
                                        linkReg <= progCtr - 1; //(progCtr - 2) + 1 
                                        $display("(%3d) BSA, Addressing: %b (reg indir-0, dir-1), R[%2d], M[%3d]\n\n", progCtr-2, instrReg[24], instrReg[23:19], instrReg[18:11]);
                                    end
                                    3'd2: begin  //RET
                                        invalidStages <= (invalidStages | 5'd3) << 1; //invalidate IF and ID stages, and shiftleft
                                        branchTaken <= 1'b1;
                                        branchProgCtr <= linkReg;
                                        $display("(%3d) RET, @LR = %d\n\n", progCtr-2, linkReg);
                                    end
                                    3'd3: begin  //HLT
                                        halt <= 1'b1;
                                        invalidStages <= 5'b11111;
                                        branchTaken <= 1'b0;
                                        $display("(%3d) HLT\n\n", progCtr-2,);
                                    end  
                                    3'd4: begin  //BIZ
                                        if (zFlag) begin
                                            invalidStages <= (invalidStages | 5'd3) << 1; //invalidate IF and ID stages, and shiftleft
                                            branchTaken <= 1'b1;
                                            branchProgCtr <= instrReg[24]? instrReg[18:11] : Reg[instrReg[23:19]]; //direct/reg indirect
                                        end
                                        else begin
                                            branchTaken <= 1'b0;
                                            invalidStages <= invalidStages << 1;
                                        end
                                        $display("(%3d) BIZ: taken? %b, Addressing: %b (reg indir-0, dir-1), R[%2d], M[%3d]\n\n", progCtr-2, zFlag, instrReg[24], instrReg[23:19], instrReg[18:11]);
                                    end  
                                    3'd5: begin  //BNZ
                                        if (~zFlag) begin
                                            invalidStages <= (invalidStages | 5'd3) << 1; //invalidate IF and ID stages, and shiftleft
                                            branchTaken <= 1'b1;
                                            branchProgCtr <= instrReg[24]? instrReg[18:11] : Reg[instrReg[23:19]]; //direct/reg indirect
                                        end
                                        else begin
                                            branchTaken <= 1'b0;
                                            invalidStages <= invalidStages << 1;
                                        end
                                        $display("(%3d) BNZ: taken? %b, Addressing: %b (reg indir-0, dir-1), R[%2d], M[%3d]\n\n", progCtr-2, ~zFlag, instrReg[24], instrReg[23:19], instrReg[18:11]);
                                    end  
                                    3'd6: begin  //BIV
                                        if (vFlag) begin
                                            invalidStages <= (invalidStages | 5'd3) << 1; //invalidate IF and ID stages, and shiftleft
                                            branchTaken <= 1'b1;
                                            branchProgCtr <= instrReg[24]? instrReg[18:11] : Reg[instrReg[23:19]]; //direct/reg indirect
                                        end
                                        else begin
                                            branchTaken <= 1'b0;
                                            invalidStages <= invalidStages << 1;
                                        end
                                        $display("(%3d) BIV: taken? %b, Addressing: %b (reg indir-0, dir-1), R[%2d], M[%3d]\n\n", progCtr-2, vFlag, instrReg[24], instrReg[23:19], instrReg[18:11]);
                                    end  
                                    3'd7: begin  //BNV
                                        if (~vFlag) begin
                                            invalidStages <= (invalidStages | 5'd3) << 1; //invalidate IF and ID stages, and shiftleft
                                            branchTaken <= 1'b1;
                                            branchProgCtr <= instrReg[24]? instrReg[18:11] : Reg[instrReg[23:19]]; //direct/reg indirect
                                        end
                                        else begin
                                            branchTaken <= 1'b0;
                                            invalidStages <= invalidStages << 1;
                                        end
                                        $display("(%3d) BNV: taken? %b, Addressing: %b (reg indir-0, dir-1), R[%2d], M[%3d]\n\n", progCtr-2, ~vFlag, instrReg[24], instrReg[23:19], instrReg[18:11]);
                                    end  
                            endcase
                        end

                        4'd4: begin  // MEM
                            A <= Reg[instrReg[18:14]]; //Pointer to address in mem
                            B <= {24'd0, instrReg[13:6]}; //zero padding 8-bit offset
                            Sel <= 4'd0; //ADD offset
                            branchTaken <= 1'b0;
                            invalidStages <= invalidStages << 1;

                            $display("(%3d) LD/STR(0/1)? %b, R[%d], [R[%d]]\n\n", progCtr-2, instrReg[27], instrReg[23:19], instrReg[18:14]);
                        end

                        4'd8: begin // FORCE CONSTANT
                            branchTaken <= 1'b0;
                            invalidStages <= invalidStages << 1;

                            $display("(%3d) FRC R[%2d] to %d\n\n", progCtr-2, instrReg[23:19], instrReg[15:0]);
                        end
                        4'd15: begin //FPU
                            fA <= Reg[instrReg[23:19]];
                            fB <= Reg[instrReg[18:14]];
                            fSel <= instrReg[27:26]; //opcode
                            branchTaken <= 1'b0;
                            invalidStages <= invalidStages << 1;

                            $display("(%3d) FPU instruction, opcode=%2d\n\tR[%2d]mA=%d \n\tR[%2d] B=%d\n\n", progCtr-2, instrReg[27:26], instrReg[23:19], Reg[instrReg[23:19]], instrReg[18:14], Reg[instrReg[18:14]]);
                        end
                    endcase
                    exStageInstrReg <= instrReg;
                end
                //STALLING due to RAW
                else begin
                    //Treat current state as invalid
                    invalidStages <= (invalidStages | 5'd4) << 1;
                    branchTaken <= 1'b0;
                    $display("STALL due to RAW, stallCtr=%1d, regEx=%2d, regMem=%2d\n\n", stallCtr, regInEx, regInMem);
                end
            end

            else begin
                invalidStages <= invalidStages << 1;
                branchTaken <= 1'b0;
                $display("STALL due to BRANCH, invalidStages=%5b [WB, MEM, EX, ID, IF]\n\n", invalidStages);
            end
        end
    end

    //MEM -- Memory Stage
    always @(posedge clk) begin

        if(~invalidStages[3]) begin
            memStageInstrReg <= exStageInstrReg;
            ALU_result <= Out_0;
            FPU_result <= fOut_0;

            case(exStageInstrReg[31:28]) //Typeof instruction

                4'd4: begin  // MEM
                    if(~exStageInstrReg[27]) begin //LOAD
                        dmWrite <= 1'b0;
                        dmDat_addr <= Out_0[7:0]; //Effective address
                    end
                    else begin //STORE
                        dmWrite <= 1'b1;
                        dmDat_addr <= Out_0[7:0]; //Effective address
                        dmWrDat <= Reg[exStageInstrReg[23:19]]; //Register from which data is stored
                    end
                end
            endcase
        end
    end


    //WB -- Write Back
    always @(posedge clk) begin
        if(~invalidStages[4]) begin
            case(memStageInstrReg[31:28])
                4'd1: begin //ALU instruction
                    Reg[memStageInstrReg[13:9]] <= ALU_result;
                end

                4'd4: begin  // MEM
                    if(~memStageInstrReg[27]) begin //LOAD
                        Reg[memStageInstrReg[23:19]] <= dmDat; 
                    end
                end

                4'd8: begin // FORCE CONSTANT
                    Reg[memStageInstrReg[23:19]] <= {16'd0, memStageInstrReg[15:0]};
                    //$display("%4d)WB-FRC R[%2d]=%d\n\n", $time, memStageInstrReg[23:19], {16'd0, memStageInstrReg[15:0]});
                end
                4'd15: begin //FPU
                    Reg[memStageInstrReg[13:9]] <= FPU_result;
                end
            endcase
        end
    end
endmodule