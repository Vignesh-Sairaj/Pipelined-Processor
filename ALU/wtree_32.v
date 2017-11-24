`include "CSA_64.v"

module wtree_32(pp, s, c);
  input [2047:0] pp;
  output [63:0] s, c;
  wire [63:0] ppArr [31:0];

  wire [63:0] stg1 [21:0];
  wire [63:0] stg2 [14:0];
  wire [63:0] stg3 [9:0];
  wire [63:0] stg4 [6:0];
  wire [63:0] stg5 [4:0];
  wire [63:0] stg6 [3:0];
  wire [63:0] stg7 [2:0];
  wire [63:0] stg8 [1:0];



  assign {ppArr[31], ppArr[30], ppArr[29], ppArr[28], ppArr[27], ppArr[26], ppArr[25], ppArr[24], ppArr[23], ppArr[22], ppArr[21], ppArr[20], ppArr[19], ppArr[18], ppArr[17], ppArr[16], ppArr[15], ppArr[14], ppArr[13], ppArr[12], ppArr[11], ppArr[10], ppArr[9], ppArr[8], ppArr[7], ppArr[6], ppArr[5], ppArr[4], ppArr[3], ppArr[2], ppArr[1], ppArr[0]} = pp;

  CSA_64 s1_1(ppArr[0], ppArr[1], ppArr[2], stg1[0], stg1[1]);
  CSA_64 s1_2(ppArr[3], ppArr[4], ppArr[5], stg1[2], stg1[3]);
  CSA_64 s1_3(ppArr[6], ppArr[7], ppArr[8], stg1[4], stg1[5]);
  CSA_64 s1_4(ppArr[9], ppArr[10], ppArr[11], stg1[6], stg1[7]);
  CSA_64 s1_5(ppArr[12], ppArr[13], ppArr[14], stg1[8], stg1[9]);
  CSA_64 s1_6(ppArr[15], ppArr[16], ppArr[17], stg1[10], stg1[11]);
  CSA_64 s1_7(ppArr[18], ppArr[19], ppArr[20], stg1[12], stg1[13]);
  CSA_64 s1_8(ppArr[21], ppArr[22], ppArr[23], stg1[14], stg1[15]);
  CSA_64 s1_9(ppArr[24], ppArr[25], ppArr[26], stg1[16], stg1[17]);
  CSA_64 s1_10(ppArr[27], ppArr[28], ppArr[29], stg1[18], stg1[19]);
  assign stg1[20] = ppArr[30];
  assign stg1[21] = ppArr[31];


  CSA_64 s2_1(stg1[0], stg1[1], stg1[2], stg2[0], stg2[1]);
  CSA_64 s2_2(stg1[3], stg1[4], stg1[5], stg2[2], stg2[3]);
  CSA_64 s2_3(stg1[6], stg1[7], stg1[8], stg2[4], stg2[5]);
  CSA_64 s2_4(stg1[9], stg1[10], stg1[11], stg2[6], stg2[7]);
  CSA_64 s2_5(stg1[12], stg1[13], stg1[14], stg2[8], stg2[9]);
  CSA_64 s2_6(stg1[15], stg1[16], stg1[17], stg2[10], stg2[11]);
  CSA_64 s2_7(stg1[18], stg1[19], stg1[20], stg2[12], stg2[13]);
  assign stg2[14] = stg1[21];


  CSA_64 s3_1(stg2[0], stg2[1], stg2[2], stg3[0], stg3[1]);
  CSA_64 s3_2(stg2[3], stg2[4], stg2[5], stg3[2], stg3[3]);
  CSA_64 s3_3(stg2[6], stg2[7], stg2[8], stg3[4], stg3[5]);
  CSA_64 s3_4(stg2[9], stg2[10], stg2[11], stg3[6], stg3[7]);
  CSA_64 s3_5(stg2[12], stg2[13], stg2[14], stg3[8], stg3[9]);



  CSA_64 s4_1(stg3[0], stg3[1], stg3[2], stg4[0], stg4[1]);
  CSA_64 s4_2(stg3[3], stg3[4], stg3[5], stg4[2], stg4[3]);
  CSA_64 s4_3(stg3[6], stg3[7], stg3[8], stg4[4], stg4[5]);
  assign stg4[6] = stg3[9];


  CSA_64 s5_1(stg4[0], stg4[1], stg4[2], stg5[0], stg5[1]);
  CSA_64 s5_2(stg4[3], stg4[4], stg4[5], stg5[2], stg5[3]);
  assign stg5[4] = stg4[6];


  CSA_64 s6_1(stg5[0], stg5[1], stg5[2], stg6[0], stg6[1]);
  assign stg6[2] = stg5[3];  
  assign stg6[3] = stg5[4];  


  CSA_64 s7_1(stg6[0], stg6[1], stg6[2], stg7[0], stg7[1]);
  assign stg7[2] = stg6[3];


  CSA_64 s8_1(stg7[0], stg7[1], stg7[2], stg8[0], stg8[1]);




  assign s = stg8[0];
  assign c = stg8[1];

endmodule
