`timescale 1 ns / 1 ns
module test_mem();


	parameter WIDTH = 16;
	parameter INSTRUCTIONWIDTH = 24;
	logic clk, we;
	logic [WIDTH-1:0] a1, a2, wd;
	logic [INSTRUCTIONWIDTH-1:0] rd1;
	logic [WIDTH-1:0] rd2;
	
	mem #(WIDTH, INSTRUCTIONWIDTH) mem
  (clk, we,
	a1, a2, wd,
	rd1,
	rd2);
		
	initial 
	begin
	
		we = 0;
	   a1 = 0;
		a2 = 0;
		wd = 0;
		
	   clk = 0;		
		#10;
	   clk = 1;
		#10;
	   clk = 0;
		#10;
	   clk = 1;
		#10;
	   clk = 0;
		#10;
	   clk = 1;
		#10;
	   clk = 1;
		#10;
	   clk = 0;
		#10;
	   clk = 1;
		#10;
	   clk = 0;
	end
	
endmodule 