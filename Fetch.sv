/*
	Fetch  Module
	Inputs: 
	- NewPC : new pc
   - PCSelector: indicates which pc value to use
	- clock
	- reset
	Outputs:
	- PC: the current PC value
	- PCPlus8: PC + 4?
*/
module Fetch #(parameter WIDTH = 8)
	(input logic [WIDTH-1:0] NewPC,
	 input logic PCSelector, clock, reset,
	 output logic [WIDTH-1:0] PC, PCPlus8
	 );
	
	logic [WIDTH-1:0] TempPC;
	
	resetableflipflop  #(WIDTH) pcflipflop(clock, reset, TempPC ,PC);
	mux2  #(WIDTH) pcmux (PCPlus8, NewPC, PCSelector, TempPC);
	adder  #(WIDTH) pcadder(PC, 1, PCPlus8);
	
endmodule