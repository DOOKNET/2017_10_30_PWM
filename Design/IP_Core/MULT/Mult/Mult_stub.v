// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.4 (win64) Build 1733598 Wed Dec 14 22:35:39 MST 2016
// Date        : Tue Oct 31 09:02:52 2017
// Host        : DESKTOP-JC6NIF0 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               E:/Workspace/Vivado_16.4/2017_10_30_PWM/Design/IP_Core/MULT/Mult/Mult_stub.v
// Design      : Mult
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "mult_gen_v12_0_12,Vivado 2016.4" *)
module Mult(A, B, P)
/* synthesis syn_black_box black_box_pad_pin="A[8:0],B[9:0],P[18:0]" */;
  input [8:0]A;
  input [9:0]B;
  output [18:0]P;
endmodule
