module ControlUnit(
	input clock,
	input reset,
	input [3:0] status, //VCNZ
	input [31:0] instruction,
	output reg[33:0] CW, 
	output reg[63:0] K);


reg [31:0] prev_instruction;
wire [1:0] state;
wire [3:0] cond_flag;
wire [3:0] constant_sel;
wire [1:0]  EX0_sel, EX1_sel, data_reg_sel, branch_sel;
wire [33:0] control_word, IF, EX0, EX1, EX2, data_immediate, branches, mem, data_reg;
reg [33:0] cond_branch;
wire [63:0] constant;
//state register
RegisterNbit state_register(.Q(state), .D(control_word[33:32]), .L(1'b1), .R(reset), .clock(clock));
defparam state_register.N = 2;
// 00 - IF
// 01 - EX0
// 10 - EX1
// 11 - EX2

always @(posedge clock or posedge reset)
	begin
		if (reset) begin
			CW <= IF;
			K <= 64'b0;
			prev_instruction = 32'b0;
		end
		else begin
			CW <= control_word;
			K <= constant;
			if (state[1] == 1'b1) prev_instruction <= instruction;
		end
	end
	
//constant generator
//potential solution to MOVZ and MOVK where, for a second execution state, the constant can be changed to a mask
//for now, implementing only MOVZ and MOVK, more can be added. 
assign constant_sel = {control_word[33], instruction[26:24]};


assign constant = constant_sel == 4'b0000 ? instruction[20:12] : //D format
						constant_sel == 4'b0001 ? instruction[21:10] : //I format
						{constant_sel, instruction[22:21]} == {instruction[29], 5'b010_00} ? {48'h0000_0000_0000, prev_instruction[20:5]} : //MOVZ no shift/4th word / MOVK 4th word
						{constant_sel, instruction[22:21]} == {instruction[29], 5'b010_01} ? {32'h0000_0000, prev_instruction[20:5], 16'b0000} : //MOVZ 3rd word / MOVK 3rd word
						{constant_sel, instruction[22:21]} == {instruction[29], 5'b010_10} ? {16'h0000, prev_instruction[20:5], 32'b0000_0000} : //MOVZ 2nd word / MOVK 2nd word
						{constant_sel, instruction[22:21]} == {instruction[29], 5'b010_11} ? {prev_instruction[20:5], 48'h0000_0000_0000} : //MOVZ 1st word / MOVK 1st word
						{instruction[29], constant_sel, instruction[22:21]} == 7'b10010_00 ? 64'hFFFF_FFFF_FFFF_0000 : //MOVK 4th word mask
						{instruction[29], constant_sel, instruction[22:21]} == 7'b10010_01 ? 64'hFFFF_FFFF_0000_FFFF : //MOVK 3rd word mask
						{instruction[29], constant_sel, instruction[22:21]} == 7'b10010_10 ? 64'hFFFF_0000_FFFF_FFFF : //MOVK 2nd word mask
						{instruction[29], constant_sel, instruction[22:21]} == 7'b10010_11 ? 64'h0000_FFFF_FFFF_FFFF : //MOVK 1st word mask
						constant_sel == 3'b0011 ? instruction[15:10] : //R format
						({instruction[31:29], instruction[26]} == 4'b1011 || {instruction[31:29], instruction[26]} == 4'b0101) ? instruction[23:5] : instruction[25:0]; //CB or B formats. CB USES PREV INSTRUCTION FOR UNKNOWN REASON


//final output
assign control_word = state == 2'b00 ? IF :
							 state == 2'b01 ? EX0 :
							 state == 2'b10 ? EX1 : EX2;

//State 00 is always IF
// control word:      	  |   |  |   |PC | K |	|	|		|	|	|	|		|		  |		|
//								NS| AS|DS| PS|Sel|Sel|IL|SL|  FS |C0|MW|RW| DA  |  SA   |  SB  |
assign IF = 		   34'b01_1__11__00__0___0__1__0__00000__0__0__0__00000_00000__00000;
assign EX0_sel = {instruction[27], ((~instruction[27]&instruction[26]) | (instruction[27]&(instruction[25])))};
					  
assign EX0 = EX0_sel == 2'b00 ? data_immediate :
				 EX0_sel == 2'b01 ? branches :
				 EX0_sel == 2'b10 ? mem : data_reg;
				 
assign EX1_sel = {instruction[30], instruction[29] instruction[24]};

assign EX1 = {status[0], EX1_sel} == 4'b1010 ? 34'b11_0_00_10_1_0_0_0_00000_0_0_0_11110_00000_00000 : //Branch if Z=1 and opcode is CBZ
				 {status[0], EX1_sel} == 3'b0011 ? 34'b11_0_00_10_1_0_0_0_00000_0_0_0_11110_00000_00000 : //Branch if Z=0 and opcode is CBNZ
				 EX1_sel == 3'b110 ? {19'b00_0_00_01_0_1_0_0_01000_0_0_1, prev_instruction[4:0], prev_instruction[4:0], 5'b00000} : 
				 EX1_sel[2:1] == 2'b00 ? 34'b00_1__11__00__0___0__1__0__00000__0__0__0__00000_00000__00000;
				 34'b00_0_00_01_0_0_0_0_00000_0_0_0_00000_00000_00000; //Complete MOVK by adding constant to masked value ///// NOP for CBZ/CBNZ fallthrough. 



assign EX2 = 34'b00_0_00_01_0_0_0_0_00000_0_0_0_00000_00000_00000; //no instructions are 2 cycles, if you end up here do NOP to get back to state0/IF;

assign data_immediate = instruction[25:23] == 3'b010 ? {10'b00_0_00_01_0_1_0, instruction[29], 4'b0100, instruction[30], instruction[30], 2'b0_1, instruction[4:0], instruction[9:5], 5'b00000} :
								instruction[25:23] == 3'b100 ? {10'b00_0_00_01_0_1_0, (instruction[30] & ~instruction[29]), 1'b0, ((instruction[30]&~instruction[29]) | (~instruction[30]&instruction[29])),
								(instruction[30]&~instruction[29]), 5'b00_0_0_1, instruction[4:0], instruction[9:5], 5'b00000} :
								instruction[25:23] == 3'b101 ? {instruction[29], 11'b0_0_00_01_0_1_0_0_0, ~instruction[29], instruction[29], 5'b00_0_0_1, instruction[4:0], (instruction[29] == 1'b0 ? 5'b11111 : instruction[4:0]), 5'b00000} : //MOVZ and MOVK here
								instruction[25:23] == 3'b110 ? 34'bx : //bitfield here
								34'bx; //extract here
								
//status, //VCNZ
always @* begin
	if((status[0]) && ({instruction[26],instruction[3:0]} == 5'b10000)) cond_branch <= {3'b00_0, instruction[31], 14'b0_10_1_0_0_0_00000_0_0, instruction[31], 15'b11110_00000_00000}; //branch on EQ
	else if(~status[0] && ({instruction[26],instruction[3:0]} == 5'b10001)) cond_branch <= {3'b00_0, instruction[31], 14'b0_10_1_0_0_0_00000_0_0, instruction[31], 15'b11110_00000_00000}; //branch on EQ
	else if(~status[2] && ({instruction[26],instruction[3:0]} == 5'b10010)) cond_branch <= {3'b00_0, instruction[31], 14'b0_10_1_0_0_0_00000_0_0, instruction[31], 15'b11110_00000_00000}; //branch on EQ
	else if(status[2] && ({instruction[26],instruction[3:0]} == 5'b10011)) cond_branch <= {3'b00_0, instruction[31], 14'b0_10_1_0_0_0_00000_0_0, instruction[31], 15'b11110_00000_00000}; //branch on EQ
	else if(~status[1] && ({instruction[26],instruction[3:0]} == 5'b10100)) cond_branch <= {3'b00_0, instruction[31], 14'b0_10_1_0_0_0_00000_0_0, instruction[31], 15'b11110_00000_00000}; //branch on EQ
	else if(status[1] && ({instruction[26],instruction[3:0]} == 5'b10101)) cond_branch <= {3'b00_0, instruction[31], 14'b0_10_1_0_0_0_00000_0_0, instruction[31], 15'b11110_00000_00000}; //branch on EQ
	else if(~status[3] && ({instruction[26],instruction[3:0]} == 5'b10110)) cond_branch <= {3'b00_0, instruction[31], 14'b0_10_1_0_0_0_00000_0_0, instruction[31], 15'b11110_00000_00000}; //branch on EQ
	else if(status[3] && ({instruction[26],instruction[3:0]} == 5'b10111)) cond_branch <= {3'b00_0, instruction[31], 14'b0_10_1_0_0_0_00000_0_0, instruction[31], 15'b11110_00000_00000}; //branch on EQ
	else if((status[2] & ~status[0]) && ({instruction[26],instruction[3:0]} == 5'b11000)) cond_branch <= {3'b00_0, instruction[31], 14'b0_10_1_0_0_0_00000_0_0, instruction[31], 15'b11110_00000_00000}; //branch on EQ	
	else if((~status[2] | status[0]) && ({instruction[26],instruction[3:0]} == 5'b11001)) cond_branch <= {3'b00_0, instruction[31], 14'b0_10_1_0_0_0_00000_0_0, instruction[31], 15'b11110_00000_00000}; //branch on EQ
	else if((~(status[1]^status[3])) && ({instruction[26],instruction[3:0]} == 5'b11010)) cond_branch <= {3'b00_0, instruction[31], 14'b0_10_1_0_0_0_00000_0_0, instruction[31], 15'b11110_00000_00000}; //branch on EQ
	else if((status[1]^status[3]) && ({instruction[26],instruction[3:0]} == 5'b11011)) cond_branch <= {3'b00_0, instruction[31], 14'b0_10_1_0_0_0_00000_0_0, instruction[31], 15'b11110_00000_00000}; //branch on EQ
	else if((~status[0] & ~(status[1]^status[3])) && ({instruction[26],instruction[3:0]} == 5'b11100)) cond_branch <= {3'b00_0, instruction[31], 14'b0_10_1_0_0_0_00000_0_0, instruction[31], 15'b11110_00000_00000}; //branch on EQ
	else if((status[0] | (status[1]^status[3])) && ({instruction[26],instruction[3:0]} == 5'b11101)) cond_branch <= {3'b00_0, instruction[31], 14'b0_10_1_0_0_0_00000_0_0, instruction[31], 15'b11110_00000_00000}; //branch on EQ
	else if(1'b1 && ({instruction[26],instruction[3:0]} == 5'b11110)) cond_branch <= {3'b00_0, instruction[31], 14'b0_10_1_0_0_0_00000_0_0, instruction[31], 15'b11110_00000_00000}; //branch on EQ
	else if(1'b1 && ({instruction[26],instruction[3:0]} == 5'b11111)) cond_branch <= {3'b00_0, instruction[31], 14'b0_10_1_0_0_0_00000_0_0, instruction[31], 15'b11110_00000_00000}; //branch on EQ
	else cond_branch <= 34'b0;	//NOP if the cond field of the instruction does not match one of the cond encodings specified by the status flags. These encodings are implicitly defined on the LHS of the cases.
										//Condition codes can be found explicitly in the instruction set/ARM manual, but due to the nature of the later conditions could not be implemented explicitly. 
end
						
assign branches = instruction[30:29] == 2'b00 ? {3'b10_0, instruction[31], 14'b0_10_1_0_0_0_00000_0_0, instruction[31], 15'b11110_00000_00000} : //B/BL
						instruction[30:29] == 2'b01 ? {24'b10_0_00_01_0_0_0_1_01000_0_0_0_00000, instruction[4:0], 5'b11111} : //CBZ/CBNZ
						instruction[30:29] == 2'b10 ? cond_branch : //B.cond
						instruction[31:30] == 2'b11 ? {23'b00_0_00_10_0_0_0_0_00000_0_0_00000, instruction[9:5], 5'b00000} : //BR/BLR/etc
						34'b0;

						
						
						
assign mem = instruction[22] == 1'b0 ? {19'b00_0_01_01_0_1_0_0_01000_0_1_0, 5'b00000, instruction[9:5], instruction[4:0]} :
				{19'b00_0_11_00_0_1_0_0_01000_0_0_1, instruction[4:0], instruction[9:5], 5'b00000} ;



				
assign data_reg = {instruction[28], instruction[24]} == 2'b00 ? {8'b00_0_01_0_0_0, (instruction[30]&instruction[29]), 1'b0, (instruction[30]&~instruction[29]), (instruction[30] ^ instruction[29]), 2'b0,
						 3'b0_0_1, instruction[4:0], instruction[9:5], instruction[20:16]} :
						{instruction[28], instruction[24]} == 2'b01 ? {8'b00_0_01_0_0_0, instruction[29], 4'b0100, instruction[30], instruction[30], 2'b0_1, instruction[4:0], instruction[9:5], instruction[20:16]} :
						{instruction[28], instruction[24]} == 2'b10 ? {24'b00_0_00_10_1_0_0_0_00000_0_0_0_00000, instruction[9:5], 5'b00000} :
						{11'b00_0_00_01_0_1_0_0, 2'b00, instruction[21], 2'b00, 3'b0_0_1, instruction[4:0], instruction[9:5], 5'b00000};

endmodule
