
/**
	Register module: Contains 14 registers 
	Inputs:
	- ra1 and ra2 indicate de registers to be read
   - we3 indicates whether to write into the registers
	- wa3 indicates the register on which to write
	
	Outputs:
 	- rd1 and rd2 provide the requested registers value
**/
module regfile(input logic clk,
	input logic we3,
	input logic [3:0] ra1, ra2, wa3,
	input logic [31:0] wd3,
	output logic [31:0] rd1, rd2);
	
	logic [31:0] rf[14:0];
	
	
	always_ff @(posedge clk)
		if (we3) rf[wa3] <= wd3;
		assign rd1 = rf[ra1];
		assign rd2 = rf[ra2];
endmodule