
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

module mem #(parameter WIDTH = 16, parameter INSTRUCTIONWIDTH = 24, parameter RAMSIZE = 8)
  (input logic clk, we,
	input logic [WIDTH-1:0] a1, a2, wd,
	output logic [INSTRUCTIONWIDTH-1:0] rd1,
	output logic [WIDTH-1:0] rd2);
	
	logic [5:0] weAux;
	logic [WIDTH*6-1:0] aAux, wdAux;
	logic [8*6-1:0] rdAux;
	
	assign weAux[2:0] = 0;
	assign wdAux[WIDTH*3-1:0] = 0;
	assign aAux[WIDTH*3-1:0] = {a1, a1, a1};
	assign rd1 = {rdAux[8-1:0], rdAux[8*2-1:8], rdAux[8*3-1:8*2]};
	
	assign wdAux[WIDTH*6-1:WIDTH*3] = {wd, wd, wd};
	assign aAux[WIDTH*4-1:WIDTH*3] = a2;
	assign aAux[WIDTH*5-1:WIDTH*4] = a2-RAMSIZE;
	assign aAux[WIDTH*6-1:WIDTH*5] = a2-RAMSIZE*2;
	assign rd2[15:8] = 0;
	unifiedmem #(WIDTH, RAMSIZE) unifiedmem(clk,
														 weAux,
														 aAux, wdAux,
														 rdAux);
	
	always_comb begin
	
		rd2[7:0] = 0;
		if(a2<RAMSIZE) rd2[7:0] <= rdAux[8*4-1:8*3];
		else if (a2<RAMSIZE*2) rd2[7:0]  <= rdAux[8*5-1:8*4];
		else if (a2<RAMSIZE*3)  rd2[7:0]  <= rdAux[8*6-1:8*5];
		
	
		weAux[5:3] = 0;
		if (we) begin
			$display ($sformatf("write enable a2: %h", a2));
			if(a2<RAMSIZE) weAux[3] = 1;
			else if (a2<RAMSIZE*2) weAux[4] = 1;
			else if (a2<RAMSIZE*3) weAux[5] = 1;
		end
		
	end
	
endmodule
