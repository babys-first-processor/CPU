module CPU(
	input clk,
	input rst,
	output [15:0] r0, r1, r2, r3, r4, r5, r6, r7,  		//For demonstration, I assume peripherals/IO will be added later??
	output reg [3:0] status);
	
wire AS; 						//Address Select
wire [1:0] DS; 				//Data Select
wire [1:0] PS; 				//PC function select
wire PC_Sel; 					//Choose A or K for PC_in
wire K_Sel; 					//Choose B or K for ALU in
wire IL; 						//Instruction Register Load
wire SL; 						//Status Load
wire [4:0] FS; 				//ALU function select
wire C0; 						//Carry wire for ALU
wire MW; 						//Memory write
wire RW; 						//Regfile write
wire [4:0] DA; 				//Regfile D address
wire [4:0] SA, SB; 			//Regfile A address and B address
wire [63:0] K; 				//Constant wire
wire [3:0] SF; 
wire [31:0] IR_Out;  		//wire from instruction register
wire [33:0] control_word;
wire [1:0] NS;


/*
initial begin
	$readmemh("C:/CPU/DE0 Stuff/Fibonacci.mem", mem, 12'h800, 12'h807);

	core.regfile_alu_ram.ram0.mem[12'h800] <= {32'b0, 32'b1001000100_000000000000_11111_00000}; //ADDI
	core.regfile_alu_ram.ram0.mem[12'h801] <= {32'b0, 32'b1001000100_000000000001_11111_00001}; //ADDI
	core.regfile_alu_ram.ram0.mem[12'h802] <= {32'b0, 32'b10001011000_00000_000000_00001_00010}; //ADD
	core.regfile_alu_ram.ram0.mem[12'h803] <= {32'b0, 32'b10001011000_11111_000000_00001_00000}; //ADD
	core.regfile_alu_ram.ram0.mem[12'h804] <= {32'b0, 32'b10001011000_11111_000000_00010_00001}; //ADD
	core.regfile_alu_ram.ram0.mem[12'h805] <= {32'b0, 10'b1111000100, 12'd9999, 10'b00000_11111}; //CMPI
	core.regfile_alu_ram.ram0.mem[12'h806] <= {32'b0, 32'b01010100_0000000100000000000_0_1100}; //B.GT
	core.regfile_alu_ram.ram0.mem[12'h807] <= {32'b0, 32'b000101_00000000000000100000000010}; //B

end //initialize memory (instruction memory in ROM specifically), starting at 0x800 to the end of the RAM, this may be reduced to make space for peripheral memory
*/

assign {NS, AS, DS, PS, PC_Sel, K_Sel, IL, SL, FS, C0, MW, RW, DA, SA, SB} = control_word;

datapath_core core(clk, rst, AS, DS, PS, PC_Sel, K_Sel, IL, SL, FS, C0, MW, RW, DA, SA, SB, K, r0, r1, r2, r3, r4, r5, r6, r7, SF, IR_Out);
ControlUnit CU(clk, rst, SF, IR_Out, control_word, K);

endmodule
