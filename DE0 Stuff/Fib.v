// Copyright (C) 1991-2013 Altera Corporation
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, Altera MegaCore Function License 
// Agreement, or other applicable license agreement, including, 
// without limitation, that your use is for the sole purpose of 
// programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the 
// applicable agreement for further details.

// PROGRAM		"Quartus II 64-Bit"
// VERSION		"Version 13.1.0 Build 162 10/23/2013 SJ Web Edition"
// CREATED		"Sat May 04 11:20:24 2019"

module Fib(
	CLOCK_50,
	BUTTON,
	HEX0,
	HEX1,
	HEX2,
	HEX3,
	LEDG
);


input wire	CLOCK_50;
input wire	[0:0] BUTTON;
output wire	[6:0] HEX0;
output wire	[6:0] HEX1;
output wire	[6:0] HEX2;
output wire	[6:0] HEX3;
output wire	[9:0] LEDG;

wire	[27:0] o;
wire	[15:0] register;
wire	[3:0] status;
wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	[27:0] SYNTHESIZED_WIRE_2;

assign	LEDG[4] = 0;
assign	LEDG[5] = 0;
assign	LEDG[6] = 0;
assign	LEDG[7] = 0;
assign	LEDG[8] = 0;




CPU	CPU(
	.clk(SYNTHESIZED_WIRE_0),
	.rst(SYNTHESIZED_WIRE_1),
	.r0(register),
	.r1(),
	.r2(),
	.r3(),
	.r4(),
	.r5(),
	.r6(),
	.r7(),
	.status(status));

assign	SYNTHESIZED_WIRE_1 =  ~BUTTON;




Binary_7seg_12bits	b2v_inst3(
	.in(register[11:0]),
	.out(SYNTHESIZED_WIRE_2));


Clock_divider	b2v_inst6(
	.clock_in(CLOCK_50),
	.clock_out(SYNTHESIZED_WIRE_0));
	defparam	b2v_inst6.DIVISOR = 5;

assign	o =  ~SYNTHESIZED_WIRE_2;

assign	HEX0[6:0] = o[6:0];
assign	HEX1[6:0] = o[13:7];
assign	HEX2[6:0] = o[20:14];
assign	HEX3[6:0] = o[27:21];
assign	LEDG[0] = status[0];
assign	LEDG[1] = status[1];
assign	LEDG[2] = status[2];
assign	LEDG[3] = status[3];
assign 	LEDG[9] = SYNTHESIZED_WIRE_0;
assign	register[15:12] = 4'b0;

endmodule
