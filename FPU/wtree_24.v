`include "CSA_48.v"

module wtree_24(pp, s, c);
  input [1151:0] pp;
  output [47:0] s, c;
  wire [47:0] ppArr [23:0];

  wire [47:0] stg1 [15:0];
  wire [47:0] stg2 [14:0];
  wire [47:0] stg3 [9:0];
  wire [47:0] stg4 [6:0];
  wire [47:0] stg5 [4:0];
  wire [47:0] stg6 [3:0];
  wire [47:0] stg7 [2:0];
  wire [47:0] stg8 [1:0];



  assign {ppArr[23], ppArr[22], ppArr[21], ppArr[20], ppArr[19], ppArr[18], ppArr[17], ppArr[16], ppArr[15], ppArr[14], ppArr[13], ppArr[12], ppArr[11], ppArr[10], ppArr[9], ppArr[8], ppArr[7], ppArr[6], ppArr[5], ppArr[4], ppArr[3], ppArr[2], ppArr[1], ppArr[0]} = pp;

  CSA_48 s1_1(ppArr[0], ppArr[1], ppArr[2], stg1[0], stg1[1]);
  CSA_48 s1_2(ppArr[3], ppArr[4], ppArr[5], stg1[2], stg1[3]);
  CSA_48 s1_3(ppArr[6], ppArr[7], ppArr[8], stg1[4], stg1[5]);
  CSA_48 s1_4(ppArr[9], ppArr[10], ppArr[11], stg1[6], stg1[7]);
  CSA_48 s1_5(ppArr[12], ppArr[13], ppArr[14], stg1[8], stg1[9]);
  CSA_48 s1_6(ppArr[15], ppArr[16], ppArr[17], stg1[10], stg1[11]);
  CSA_48 s1_7(ppArr[18], ppArr[19], ppArr[20], stg1[12], stg1[13]);
  CSA_48 s1_8(ppArr[21], ppArr[22], ppArr[23], stg1[14], stg1[15]);
 


  CSA_48 s2_1(stg1[0], stg1[1], stg1[2], stg2[0], stg2[1]);
  CSA_48 s2_2(stg1[3], stg1[4], stg1[5], stg2[2], stg2[3]);
  CSA_48 s2_3(stg1[6], stg1[7], stg1[8], stg2[4], stg2[5]);
  CSA_48 s2_4(stg1[9], stg1[10], stg1[11], stg2[6], stg2[7]);
  CSA_48 s2_5(stg1[12], stg1[13], stg1[14], stg2[8], stg2[9]);
  assign stg2[10] = stg1[15];


  CSA_48 s3_1(stg2[0], stg2[1], stg2[2], stg3[0], stg3[1]);
  CSA_48 s3_2(stg2[3], stg2[4], stg2[5], stg3[2], stg3[3]);
  CSA_48 s3_3(stg2[6], stg2[7], stg2[8], stg3[4], stg3[5]);
  assign stg3[6] = stg2[9];
  assign stg3[7] = stg2[10];



  CSA_48 s4_1(stg3[0], stg3[1], stg3[2], stg4[0], stg4[1]);
  CSA_48 s4_2(stg3[3], stg3[4], stg3[5], stg4[2], stg4[3]);
  assign stg4[4] = stg3[6];
  assign stg4[5] = stg3[7];
  
  


  CSA_48 s5_1(stg4[0], stg4[1], stg4[2], stg5[0], stg5[1]);
  CSA_48 s5_2(stg4[3], stg4[4], stg4[5], stg5[2], stg5[3]);
  


  CSA_48 s6_1(stg5[0], stg5[1], stg5[2], stg6[0], stg6[1]);
  assign stg6[2] = stg5[3];  
   


  CSA_48 s7_1(stg6[0], stg6[1], stg6[2], stg7[0], stg7[1]);
  


 




  assign s = stg7[0];
  assign c = stg7[1];

endmodule
