`timescale 1 ns / 1 ns
module test_cpu();
   
	
	parameter WIDTH = 32;
	parameter REGNUM = 16; 
	parameter ADDRESSWIDTH = 4; 
	parameter OPCODEWIDTH = 4;
	parameter INSTRUCTIONWIDTH = 24;
	
	
	logic clock, reset; 
	logic outFlag;
	logic [WIDTH-1:0] out;
	CPU #(WIDTH, REGNUM, ADDRESSWIDTH, OPCODEWIDTH, INSTRUCTIONWIDTH) CPU
	(clock, reset, 0,
	outFlag,
	out);
	
	initial 
	begin	
		reset = 1;
		clock = 0;
		#10;
		clock = 1;
		#10;
		clock = 0;
		reset = 0;
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
		#10;
		clock = 1;
		#10;
		clock = 0;
		reset = 0;
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
		#10;
		clock = 1;
		#10;
		clock = 0;
		reset = 0;
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
		#10;
		clock = 1;
		#10;
		clock = 0;
		reset = 0;
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
		#10;
		clock = 1;
		#10;
		clock = 0;
		reset = 0;
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
		#10;
		clock = 1;
		#10;
		clock = 0;
		reset = 0;
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
		#10;
		clock = 1;
		#10;
		clock = 0;
		reset = 0;
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
		#10;
		clock = 1;
		#10;
		clock = 0;
		reset = 0;
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
		#10;
		clock = 1;
		#10;
		clock = 0;
		reset = 0;
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
		#10;
		clock = 1;
		#10;
		clock = 0;
		reset = 0;
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
		#10;
		clock = 1;
		#10;
		clock = 0;
		reset = 0;
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
		#10;
	end
	
endmodule 