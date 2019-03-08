module instruction_register(
	input [31:0] in,
	input load, reset,
	output reg [31:0] out);
	
always @ (load or reset or in)
	if (reset) begin
		out <= 31'b0;
	end else if (load) begin
		out <= in;
	end

endmodule

	


