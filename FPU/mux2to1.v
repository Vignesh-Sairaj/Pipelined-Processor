
`ifndef _mux2to1_
`define _mux2to1_
module mux2to1(in0, in1, sel, out);

    input in0, in1, sel;
    output out;

    assign out = (~sel)&in0 | sel&in1;

endmodule
`endif