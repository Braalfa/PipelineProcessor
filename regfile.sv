
/**
	Register module: Contains 14 registers 
	Inputs:
	- ra1 and ra2 indicate de registers to be read
   - we3 indicates whether to write into the registers
	- wa3 indicates the register on which to write
	- wd3 : the data to write
	Outputs:
 	- rd1 and rd2 provide the requested registers value
	Params:
	- REGNUM: number of registers
	- WIDTH: width of each register
	- ADRESSWIDTH: size of the addresses
**/
module regfile #(parameter WIDTH = 16, parameter REGNUM = 16, parameter ADDRESSWIDTH = 4)
	(input logic clk,
	input logic we3,
	input logic [ADDRESSWIDTH-1:0] ra1, ra2, wa3,
	input logic [WIDTH-1:0] wd3, pc,
	output logic [WIDTH-1:0] rd1, rd2);
	
	logic [WIDTH-1:0] rf[REGNUM-1:0];
	
	
	always_ff @(posedge clk)
		if (we3) rf[wa3] <= wd3;
		assign rd1 = (ra1 == 4'b1111) ? pc : rf[ra1];
		assign rd2 = (ra2 == 4'b1111) ? pc : rf[ra2];

endmodule
