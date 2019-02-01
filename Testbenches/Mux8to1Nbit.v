module Mux8to1Nbit(F, FS, I7, I6, I5, I4, I3, I2, I1, I0);

parameter N = 8;
output reg [N-1:0]F;
input [2:0] FS;
input [N-1:0] I7, I6, I5, I4, I3, I2, I1, I0;

	always @(*) begin
		case(FS)
			5'h00: F <= I0;
			5'h01: F <= I1;
			5'h02: F <= I2;
			5'h03: F <= I3;
			5'h04: F <= I4;
			5'h05: F <= I5;
			5'h06: F <= I6;
			5'h07: F <= I7;
		endcase
	end
endmodule
