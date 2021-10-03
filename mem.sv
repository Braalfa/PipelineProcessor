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

module mem #(parameter WIDTH = 8)
  (input logic clk, we,
	input logic [WIDTH-1:0] a1, a2, wd,
	output logic [WIDTH-1:0] rd1, rd2);
	
	logic [WIDTH-1:0] RAM[63:0];

	initial begin
		$readmemh("instructions.txt",RAM);
		$readmemh("datamemory.txt",RAM, 32);
	end
	
	always_ff @(posedge clk)
		if (we) RAM[32+a2] <= wd;
	
	assign rd1 = RAM[a1]; 
	assign rd2 = RAM[32+a2];
endmodule