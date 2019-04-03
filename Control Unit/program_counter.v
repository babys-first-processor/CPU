module program_counter(
	input clk,
	input rst,
	input [31:0] in,
	input [1:0] PS,
	output reg [31:0] out);
	
///////////////////////////
//  PS  |      Output    //
//-----------------------//
//  00  |     PC <- PC   //
//  01  |   PC <- PC + 1 //
//  10  |     PC <- in   //
//  11  |  PC <- PC + in //
///////////////////////////

// not using byte-addressing, 
//each address is a 32 bit instruction, 
//no need for x4s

wire [31:0] D;

assign D = PS == 2'b00 ? out :
			  PS == 2'b01 ? out + 32'd1 :
			  PS == 2'b10 ? in : out + in;
			  
parameter PC_RESET_VALUE = 32'h0000_0800;
always @(posedge clk or posedge rst)
	begin
		if (rst) out <= PC_RESET_VALUE;
		else out <= D;
	end
endmodule
