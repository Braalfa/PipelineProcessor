`timescale 1 ns / 1 ns
module test_cpu();
   
	
	parameter WIDTH = 16;
	parameter REGNUM = 16; 
	parameter ADDRESSWIDTH = 4; 
	parameter OPCODEWIDTH = 4;
	parameter INSTRUCTIONWIDTH = 24;
	
	
	logic clock, reset; 
	logic outFlag;
	logic [WIDTH-1:0] out;
	CPU #(WIDTH, REGNUM, ADDRESSWIDTH, OPCODEWIDTH, INSTRUCTIONWIDTH) CPU
	(clock, reset, 
	outFlag,
	out);
	
	initial 
	begin	
		reset = 0;
		#10;
		reset = 1;
		#10;
		reset = 0;
		#10
		clock = 0;
		#10
		clock = 1;
		#10
		clock = 0;
		#10
		clock = 1;
		#10
		clock = 0;
		#10
		clock = 1;
		#10
		clock = 0;
		#10
		clock = 1;
		#10
		clock = 0;
		#10
		clock = 1;
		#10
		clock = 0;
		#10
		clock = 1;
		#10
		clock = 0;
		#10
		clock = 1;
		#10
		clock = 0;
		#10
		clock = 1;
		#10
		clock = 0;
		#10
		clock = 1;
		#10
		clock = 0;
	end
	
endmodule 