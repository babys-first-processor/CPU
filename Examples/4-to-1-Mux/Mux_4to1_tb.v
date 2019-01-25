module Mux_4to1_tb;

reg[3:0] i;
reg[1:0] s;
wire o;

Mux_4to1 uut (.i(i), .s(s), .o(o));
initial
begin
	#10 i=4'b1010;
	#10 s=2'b00;
	#10 s=2'b01;
	#10 s=2'b10;
	#10 s=2'b11;
	#10 $stop;
end
endmodule
