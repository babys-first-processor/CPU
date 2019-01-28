module dff_async_reset(q, data, clk, reset, enable); //single bit D-Flip-Flop with asynchronous reset & enable
input data, clk, reset, enable;
output reg q;

always @(posedge clk or negedge reset)
if (~reset) begin
	q <= 1'b0;
	end
else if (enable) begin
	q <= data;
	end
endmodule
