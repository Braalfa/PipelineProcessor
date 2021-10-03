
// TO-DO: Conectar la InstructionD con el Decode
 
module CPU #(parameter WIDTH = 8, parameter REGNUM = 8, parameter ADDRESSWIDTH = 3)
	(input logic clock, reset);
	
	// Connection to memory
	
	logic writeDataEnable;
	logic [WIDTH-1:0] MemoryDataAddress, MemoryDataToWrite, 
	InstructionF, InstructionD, MemoryDataOutputM, MemoryDataOutputWB;
	mem #(WIDTH) Memory(clock, writeDataEnable, PC, MemoryDataAddress, 
					MemoryDataToWrite, InstructionF, MemoryDataOutputM);
	
	//-------------------------------------------------------------------------------//
	// Fetch
	
	logic [WIDTH-1:0] NewPC, PC, PCPlus8;
	logic PCSelector;
	Fetch #(WIDTH) Fetch(NewPC, PCSelector, clock, reset, PC, PCPlus8);
	
	// Fetch - Decoding FlipFlop
	resetableflipflop  #(WIDTH) FetchFlipFlop(clock, reset, InstructionF, InstructionD);
	
	//-------------------------------------------------------------------------------//
	
	// Decoder
	
	logic [ADDRESSWIDTH-1:0] reg1Address, reg2Address, writeAddress;
	logic [WIDTH-1:0] inmediateD, inmediateE;
	logic obtainPCAsR1, writeEnable;
	logic [WIDTH-1:0] reg1ContentD, reg2ContentD, reg1ContentE, reg2ContentE;
	
	Decode #(WIDTH, REGNUM, ADDRESSWIDTH) Decode
	( reg1Address, reg2Address, writeAddress,
	  inmediateD, PCPlus8,
	  clock, reset, obtainPCAsR1, writeEnable,
	  reg1ContentD, reg2ContentD
	 );
	 
	 
	 // Decode - Execution Flip-Flop
	 
	 resetableflipflop  #(3*WIDTH) DecodeFlipFlop(clock, reset, 
	 {reg1ContentD, reg2ContentD, inmediateD}, 
	 {reg1ContentE, reg2ContentE, inmediateE});

	 
	//-------------------------------------------------------------------------------//

	//Execute
	
	logic [3:0] aluControl;
	logic [WIDTH-1:0] aluOutputE, aluOutputM;
	logic N, Z, V, C;
	logic [WIDTH-1:0] inmediateM, reg2ContentM;
	
	Execute #(WIDTH) Execute
	(reg1ContentE, reg2ContentE,
	 aluControl,
	 aluOutputE,
	 N, Z, V, C
	 );		
	
	
	 // Execution - Memory Flip-Flop
	 
	 
	 resetableflipflop  #(3*WIDTH) ExecuteFlipFlop(clock, reset, 
	 {aluOutputE, reg2ContentE, inmediateE}, 
	 {aluOutputM, reg2ContentM, inmediateM});
	 
   //-------------------------------------------------------------------------------//

	//Memory
	logic [WIDTH-1:0] inmediateWB, aluOutputWB;
	
	assign MemoryDataToWrite = reg2ContentM;
	assign MemoryDataAddress = aluOutputM;
	
	 // Memory - Write Back Flip-Flop

	resetableflipflop  #(3*WIDTH) MemoryFlipFlop(clock, reset, 
	 {aluOutputM, MemoryDataOutputM, inmediateM}, 
	 {aluOutputWB, MemoryDataOutputWB, inmediateWB});

endmodule

