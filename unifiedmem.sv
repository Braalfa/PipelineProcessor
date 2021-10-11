
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

module unifiedmem #(parameter WIDTH = 16, parameter RAMSIZE = 4)
  (input logic clk,
	input logic [5:0] we,
	input logic [WIDTH*6-1:0] a, wd,
	output logic [8*6-1:0] rd);
	

	logic [7:0] RAM1 [RAMSIZE-1:0];
	logic [7:0] RAM2 [RAMSIZE-1:0];
	logic [7:0] RAM3 [RAMSIZE-1:0];
	logic [7:0] RAM4 [RAMSIZE-1:0];
	logic [7:0] RAM5 [RAMSIZE-1:0];
	logic [7:0] RAM6 [RAMSIZE-1:0];

	initial begin
		$readmemh("C:\\Users\\alfab\\Documents\\PipelineProcessor\\mem1.txt",RAM1);
		$readmemh("C:\\Users\\alfab\\Documents\\PipelineProcessor\\mem2.txt",RAM2);
		$readmemh("C:\\Users\\alfab\\Documents\\PipelineProcessor\\mem3.txt",RAM3);
		$readmemh("C:\\Users\\alfab\\Documents\\PipelineProcessor\\mem4.txt",RAM4);
		$readmemh("C:\\Users\\alfab\\Documents\\PipelineProcessor\\mem5.txt",RAM5);
		$readmemh("C:\\Users\\alfab\\Documents\\PipelineProcessor\\mem6.txt",RAM6);
	end
	
	assign rd[8-1:0] = RAM1[a[WIDTH-1:0]]; 
	assign rd[8*2-1:8] = RAM2[a[WIDTH*2-1:WIDTH]]; 
	assign rd[8*3-1:8*2] = RAM3[a[WIDTH*3-1:WIDTH*2]]; 
	assign rd[8*4-1:8*3] = RAM4[a[WIDTH*4-1:WIDTH*3]]; 
	assign rd[8*5-1:8*4] = RAM5[a[WIDTH*5-1:WIDTH*4]]; 
	assign rd[8*6-1:8*5] = RAM6[a[WIDTH*6-1:WIDTH*5]]; 

	always_ff @(posedge clk) begin
		$display ($sformatf("write enable : %b, address: %h, newdata: %h", we, a[WIDTH*4-1:WIDTH*3], wd[WIDTH*4-1:WIDTH*3]));
		if (we[0]) RAM1[a[WIDTH-1:0]] <= wd[WIDTH-1:0];
		if (we[1]) RAM2[a[WIDTH*2-1:WIDTH]] <= wd[WIDTH*2-1:WIDTH];
		if (we[2]) RAM3[a[WIDTH*3-1:WIDTH*2]] <= wd[WIDTH*3-1:WIDTH*2];
		if (we[3]) RAM4[a[WIDTH*4-1:WIDTH*3]] <= wd[WIDTH*4-1:WIDTH*3];
		if (we[4]) RAM5[a[WIDTH*5-1:WIDTH*4]] <= wd[WIDTH*5-1:WIDTH*4];
		if (we[5]) RAM6[a[WIDTH*6-1:WIDTH*5]] <= wd[WIDTH*6-1:WIDTH*5];
	end
endmodule