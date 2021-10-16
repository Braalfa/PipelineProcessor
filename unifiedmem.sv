
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

module unifiedmem #(parameter WIDTH = 32, parameter RAMSIZE = 512)
  (input logic clk,
	input logic [6:0] we,
	input logic [WIDTH*7-1:0] a, wd,
	output logic [WIDTH*7-1:0] rd);
	

	logic [WIDTH-1:0] RAM1 [RAMSIZE-1:0];
	logic [WIDTH-1:0] RAM2 [RAMSIZE-1:0];
	logic [WIDTH-1:0] RAM3 [RAMSIZE-1:0];
	logic [WIDTH-1:0] RAM4 [RAMSIZE-1:0];
	logic [WIDTH-1:0] RAM5 [RAMSIZE-1:0];
	logic [WIDTH-1:0] RAM6 [RAMSIZE-1:0];
	logic [WIDTH-1:0] RAM7 [RAMSIZE-1:0];

	initial begin
		$readmemb("C:\\Users\\alfab\\Documents\\PipelineProcessor\\mem1.txt",RAM1);
		$readmemb("C:\\Users\\alfab\\Documents\\PipelineProcessor\\mem2.txt",RAM2);
		$readmemb("C:\\Users\\alfab\\Documents\\PipelineProcessor\\mem3.txt",RAM3);
		$readmemb("C:\\Users\\alfab\\Documents\\PipelineProcessor\\mem4.txt",RAM4);
		$readmemb("C:\\Users\\alfab\\Documents\\PipelineProcessor\\mem5.txt",RAM5);
		$readmemb("C:\\Users\\alfab\\Documents\\PipelineProcessor\\mem6.txt",RAM6);
   	$readmemb("C:\\Users\\alfab\\Documents\\PipelineProcessor\\mem7.txt",RAM7);
	end
	
	assign rd[WIDTH-1:0] = RAM1[a[WIDTH-1:0]]; 
	assign rd[WIDTH*2-1:WIDTH] = RAM2[a[WIDTH*2-1:WIDTH]]; 
	assign rd[WIDTH*3-1:WIDTH*2] = RAM3[a[WIDTH*3-1:WIDTH*2]]; 
	assign rd[WIDTH*4-1:WIDTH*3] = RAM4[a[WIDTH*4-1:WIDTH*3]]; 
	assign rd[WIDTH*5-1:WIDTH*4] = RAM5[a[WIDTH*5-1:WIDTH*4]]; 
	assign rd[WIDTH*6-1:WIDTH*5] = RAM6[a[WIDTH*6-1:WIDTH*5]]; 
	assign rd[WIDTH*7-1:WIDTH*6] = RAM7[a[WIDTH*7-1:WIDTH*6]]; 

	always_ff @(posedge clk) begin
		if (we[0]) RAM1[a[WIDTH-1:0]] <= wd[WIDTH-1:0];
		if (we[1]) RAM2[a[WIDTH*2-1:WIDTH]] <= wd[WIDTH*2-1:WIDTH];
		if (we[2]) RAM3[a[WIDTH*3-1:WIDTH*2]] <= wd[WIDTH*3-1:WIDTH*2];
		if (we[3]) RAM4[a[WIDTH*4-1:WIDTH*3]] <= wd[WIDTH*4-1:WIDTH*3];
		if (we[4]) RAM5[a[WIDTH*5-1:WIDTH*4]] <= wd[WIDTH*5-1:WIDTH*4];
		if (we[5]) RAM6[a[WIDTH*6-1:WIDTH*5]] <= wd[WIDTH*6-1:WIDTH*5];
		if (we[6]) RAM7[a[WIDTH*7-1:WIDTH*6]] <= wd[WIDTH*7-1:WIDTH*6];
	end
endmodule