
// TO-DO: Conectar la InstructionD con el Decode
 
module CPU #(parameter WIDTH = 8, parameter REGNUM = 8, parameter ADDRESSWIDTH = 3)
	(input logic clock, reset);
	
	// Connection to memory
	
	logic writeDataEnable;
	logic [WIDTH-1:0] DataAddress, DataWrite, InstructionF, InstructionD, MemoryData;
	mem #(WIDTH) Memory(clock, writeDataEnable, PC, DataAddress, 
					DataWrite, InstructionF, MemoryData);
	assign writeDataEnable = 0;
	
	// Fetch
	
	logic [WIDTH-1:0] NewPC, PC, PCPlus8;
	logic PCSelector;
	Fetch #(WIDTH) Fetch(NewPC, PCSelector, clock, reset, PC, PCPlus8);
	
	// Fetch - Decoding FlipFlop
	resetableflipflop  #(WIDTH) FetchFlipFlop(clock, reset, InstructionF, InstructionD);
	
	
	// Decoder
	
	logic [ADDRESSWIDTH-1:0] reg1Address, reg2Address, writeAddress;
	logic [WIDTH-1:0] inmmediate;
	logic obtainPCAsR1, writeEnable;
	logic [WIDTH-1:0] reg1Content, reg2Content;
	
	Decode #(WIDTH, REGNUM, ADDRESSWIDTH)
	( reg1Address, reg2Address, writeAddress,
	  inmmediate, PCPlus8, inmmediate,
	  clock, reset, obtainPCAsR1, writeEnable,
	  reg1Content, reg2Content
	 );
	 
	 // To do: crear un flip flop parametrizable

endmodule