module ram_sp_sr_sw(
	clk,
	address,
	data,
	cs,
	we,
	oe);
	
parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;
parameter RAM_DEPTH = 1 << ADDR_WIDTH;

input clk;
input [ADDR_WIDTH-1:0] address;
input cs;
input we;
input oe;
inout [DATA_WIDTH-1:0] data;
	
reg [DATA_WIDTH-1:0] data_out;
reg [DATA_WIDTH-1:0] mem [0:RAM_DEPTH-1];
reg oe_r;


initial begin
	//$readmemb("C:/CPU/DE0 Stuff/Fibonacci.list", mem, 12'h800, 12'h807);

/*
	mem[12'h800] <= {32'b0, 32'b1001000100_000000000000_11111_00000}; //ADDI
	mem[12'h801] <= {32'b0, 32'b1001000100_000000000001_11111_00001}; //ADDI
	mem[12'h802] <= {32'b0, 32'b10001011000_00000_000000_00001_00010}; //ADD
	mem[12'h803] <= {32'b0, 32'b10001011000_11111_000000_00001_00000}; //ADD
	mem[12'h804] <= {32'b0, 32'b10001011000_11111_000000_00010_00001}; //ADD
	mem[12'h805] <= {32'b0, 10'b1111000100, 12'd9999, 10'b00000_11111}; //CMPI
	mem[12'h806] <= {32'b0, 32'b01010100_0000000100000000000_0_1100}; //B.GT
	mem[12'h807] <= {32'b0, 32'b000101_00000000000000100000000010}; //B
*/
end //initialize memory (instruction memory in ROM specifically), starting at 0x800 to the end of the RAM, this may be reduced to make space for peripheral memory

//Tri-State Buffer
assign data = (cs && oe && !we) ? data_out : {DATA_WIDTH{1'bz}};

//write 
always @(posedge clk)
begin
	if (cs && we) begin	
		mem[address] = data;
	end
end

//read
always @(posedge clk)
begin
	if (cs && !we && oe) begin
		data_out = mem[address];
		oe_r = 1;
	end else begin
		oe_r = 0;
	end
end

endmodule
