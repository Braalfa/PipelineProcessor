
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

module unifiedmem #(parameter WIDTH = 36)
  (input logic clk,
	input logic [3:0] we,
	input logic [WIDTH*4-1:0] a, wd,
	output logic [WIDTH*4-1:0] rd);
	

	logic [24-1:0] RAM1 [1024-1:0];
	logic [WIDTH-1:0] RAM2 [32-1:0];
	logic [5-1:0] RAM3 [1024-1:0];
	logic [WIDTH-1:0] RAM4 [750-1:0];

	initial begin
		$readmemb("C://Users//Juanp//Documents//Workspace//TEC//PipelineProcessor//mem1.txt",RAM1);
		$readmemb("C://Users//Juanp//Documents//Workspace//TEC//PipelineProcessor//mem2.txt",RAM2);
		$readmemb("C://Users//Juanp//Documents//Workspace//TEC//PipelineProcessor//mem3.txt",RAM3);
		$readmemb("C://Users//Juanp//Documents//Workspace//TEC//PipelineProcessor//mem4.txt",RAM4);
	end
	
	assign rd[WIDTH-1:0] = RAM1[a[WIDTH-1:0]]; 
	assign rd[WIDTH*2-1:WIDTH] = RAM2[a[WIDTH*2-1:WIDTH]]; 
	assign rd[WIDTH*3-1:WIDTH*2] = RAM3[a[WIDTH*3-1:WIDTH*2]]; 
	assign rd[WIDTH*4-1:WIDTH*3] = RAM4[a[WIDTH*4-1:WIDTH*3]]; 

	always_ff @(posedge clk) begin
		if (we[0]) RAM1[a[WIDTH-1:0]] <= wd[WIDTH-1:0];
		if (we[1]) RAM2[a[WIDTH*2-1:WIDTH]] <= wd[WIDTH*2-1:WIDTH];
		if (we[2]) RAM3[a[WIDTH*3-1:WIDTH*2]] <= wd[WIDTH*3-1:WIDTH*2];
		if (we[3]) RAM4[a[WIDTH*4-1:WIDTH*3]] <= wd[WIDTH*4-1:WIDTH*3];
	end
endmodule