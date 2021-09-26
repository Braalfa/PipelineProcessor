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
module Fetch
	(input logic [31:0] NewPC,
	 input logic PCSelector, clock, reset,
	 output logic [31:0] PC, PCPlus8
	 );
	
	logic [31:0] TempPC;
	
	resetableflipflop  #(32) pcflipflop(clock, reset, TempPC ,PC);
	mux2  #(32) pcmux (PCPlus8, NewPC, PCSelector, TempPC);
	adder  #(32) pcadder(PC, 4, PCPlus8);
	
endmodule