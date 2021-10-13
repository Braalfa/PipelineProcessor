
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

module mem #(parameter WIDTH = 32, parameter INSTRUCTIONWIDTH = 16, parameter RAMSIZE = 16)
  (input logic clk, we,
	input logic [WIDTH-1:0] a1, a2, wd,
	output logic [INSTRUCTIONWIDTH-1:0] rd1,
	output logic [WIDTH-1:0] rd2);
	
	logic [6:0] weAux;
	logic [WIDTH*7-1:0] aAux, wdAux;
	logic [WIDTH*7-1:0] rdAux;
	
	assign weAux[0] = 0;
	assign wdAux[WIDTH-1:0] = 0;
	assign aAux[WIDTH-1:0] = a1;
	assign rd1 = rdAux[WIDTH-1:0];
	
	assign wdAux[WIDTH*7-1:WIDTH] = {wd, wd, wd, wd, wd, wd};
	assign aAux[WIDTH*2-1:WIDTH*1] = a2;
	assign aAux[WIDTH*3-1:WIDTH*2] = a2-RAMSIZE*1;
	assign aAux[WIDTH*4-1:WIDTH*3] = a2-RAMSIZE*2;
	assign aAux[WIDTH*5-1:WIDTH*4] = a2-RAMSIZE*3;
	assign aAux[WIDTH*6-1:WIDTH*5] = a2-RAMSIZE*4;
	assign aAux[WIDTH*7-1:WIDTH*6] = a2-RAMSIZE*5;

	
	unifiedmem #(WIDTH, RAMSIZE) unifiedmem(clk,
														 weAux,
														 aAux, wdAux,
														 rdAux);
	
	always_comb begin
		rd2 = 0;
		if(a2<RAMSIZE) rd2 = rdAux[WIDTH*2-1:WIDTH];
		else if (a2<RAMSIZE*2) rd2  = rdAux[WIDTH*3-1:WIDTH*2];
		else if (a2<RAMSIZE*3)  rd2  = rdAux[WIDTH*4-1:WIDTH*3];
		else if (a2<RAMSIZE*4)  rd2  = rdAux[WIDTH*5-1:WIDTH*4];
		else if (a2<RAMSIZE*5)  rd2  = rdAux[WIDTH*6-1:WIDTH*5];
		else if (a2<RAMSIZE*6)  rd2  = rdAux[WIDTH*7-1:WIDTH*6];
		
	
		weAux[6:1] = 0;
		if (we) begin
			if(a2<RAMSIZE) weAux[1] = 1;
			else if (a2<RAMSIZE*2) weAux[2] = 1;
			else if (a2<RAMSIZE*3) weAux[3] = 1;
			else if (a2<RAMSIZE*4) weAux[4] = 1;
			else if (a2<RAMSIZE*5) weAux[5] = 1;
			else if (a2<RAMSIZE*6) weAux[6] = 1;
		end
		
	end
	
endmodule
