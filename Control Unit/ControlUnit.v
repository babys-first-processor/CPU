module ControlUnit(
	input clock,
	input reset,
	input [3:0] status,
	input [31:0] instruction,
	output [97:0] control_word);

wire [1:0] SR_in, SR_out;
wire [97:0] State00, State01, State10, State11;


RegisterNbit state_register(.Q(SR_out), .D(SR_in), .L(1'b1), .R(reset), .clock(clock));
defparam state_register.N = 2;
// 00 - IF
// 01 - EX0
// 10 - EX1
// 11 - EX2

assign control_word = SR_out == 2'b00 ? State00 :
							 SR_out == 2'b01 ? State01 :
							 SR_out == 2'b10 ? State10 : State11;

							 
//State 00 is always IF
// control word:       |   |  |   |PC | B |	|	|		|	|	|	|		|		  |		|																									|
//							NS| AS|DS| PS|Sel|Sel|IL|SL|  FS |C0|MW|RW| DA  |  SA   |  SB  | 													K 												|
assign State00 = 98'b01__1__11__01__x___x__1__0__xxxxx__x__0__0__xxxxx__xxxxx__xxxxx__xxxxxxxx_xxxxxxxx_xxxxxxxx_xxxxxxxx_xxxxxxxx_xxxxxxxx_xxxxxxxx_xxxxxxxx;

endmodule
