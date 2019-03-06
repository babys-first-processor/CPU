// RegisterNbit.v
module RegisterNbit(Q, D, L, R, clock);
	parameter N = 8; //size parameter
	output reg [N-1:0]Q; // registered output
	input [N-1:0]D; // data input
	input L; // load enable
	input R; // positive logic asynchronous reset
	input clock;
	

always @(posedge clock or posedge R) begin
	if(R)
		Q <= 1'b0;
	else if(L)
		Q <= D;
	else
		Q <= Q;
end
endmodule
