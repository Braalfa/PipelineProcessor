module CPU
	(input logic clock, reset);
	
	// Connection to memory
	
	logic writeDataEnable;
	logic [31:0] DataAddress, DataWrite, InstructionF, InstructionD, MemoryData;
	mem Memory(clock, writeDataEnable, PC, DataAddress, 
					DataWrite, InstructionF, MemoryData);
	assign writeDataEnable = 0;
	
	// Fetch
	
	logic [31:0] NewPC, PC, PCPlus8;
	logic PCSelector;
	Fetch Fetch(NewPC, PCSelector, clock, reset, PC, PCPlus8);
	
	// Fetch - Decoding FlipFlop
	resetableflipflop  #(32) FetchFlipFlop(clock, reset, InstructionF, InstructionD);
	
	// 
endmodule