/*
	todo: definir bien los tamanos de las memorias
	Memory with segmentation
	Inputs:
	- clk: the clock
	- we: enables writing on data segment
	- a1: instruction segment address
	- a2: data segment address
	- wd: data to write on data segment
	Outputs:
	- rd1: instruction requested
	- rd2: data requested
*/

module mem #(parameter WIDTH = 16, parameter INSTRUCTIONWIDTH = 24)
  (input logic clk, we,
	input logic [WIDTH-1:0] a1, a2, wd,
	output logic [INSTRUCTIONWIDTH-1:0] rd1,
	output logic [WIDTH-1:0] rd2);
		
	ram ram({1'b0, a2[12:0]}, {1'b1, a1[10:0]}, clk, wd, 32'b0, we, 1'b0, rd2[7:0], rd1);
	assign rd2[15:8] = 8'b0;
endmodule