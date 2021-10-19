
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

module mem #(parameter WIDTH = 32, parameter INSTRUCTIONWIDTH = 24, parameter RAMSIZE = 1024)
  (input logic clk, we, startIO,
	input logic [WIDTH-1:0] a1, a2, wd,
	output logic [INSTRUCTIONWIDTH-1:0] rd1,
	output logic [WIDTH-1:0] rd2);
	
	
	logic [WIDTH-1:0] startIOExtended;
	assign startIOExtended[WIDTH-1:1] = 0;
	assign startIOExtended[0] = startIO;
	
	
	logic [3:0] weAux;
	logic [WIDTH*4-1:0] aAux, wdAux;
	logic [WIDTH*4-1:0] rdAux;
	
	assign weAux[0] = 0;
	assign wdAux[WIDTH-1:0] = 0;
	assign aAux[WIDTH-1:0] = a1;
	assign rd1 = rdAux[WIDTH-1:0];
	
	assign wdAux[WIDTH*4-1:WIDTH] = {wd, wd, wd};
	assign aAux[WIDTH*2-1:WIDTH*1] = a2;
	assign aAux[WIDTH*3-1:WIDTH*2] = a2-32;
	assign aAux[WIDTH*4-1:WIDTH*3] = a2-(32+1024);

	
	unifiedmem #(WIDTH, RAMSIZE) unifiedmem(clk,
														 weAux,
														 aAux, wdAux,
														 rdAux);
	
	always_comb begin
		rd2 = 0;
		if (a2==1568) rd2 = startIOExtended;
		else if(a2<32) rd2 = rdAux[WIDTH*2-1:WIDTH];
		else if (a2<32+1024) rd2  = rdAux[WIDTH*3-1:WIDTH*2];
		else if (a2<32+1024+512)  rd2  = rdAux[WIDTH*4-1:WIDTH*3];
		
	
		weAux[3:1] = 0;
		if (we) begin
			if(a2<32) weAux[1] = 1;
			else if (a2<32+1024) weAux[2] = 1;
			else if (a2<32+1024+512) weAux[3] = 1;
		end
		
	end
	
endmodule
