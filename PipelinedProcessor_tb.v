`include "PipelinedProcessor.v"

module PipelinedProcessor_tb;

    reg clk = 1'b0;

    PipelinedProcessor P (clk);

    initial begin
        #1000
        $finish;
    end

    always begin
        #1 clk = ~clk;
    end

endmodule