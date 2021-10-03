
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
	
	logic [WIDTH-1:0] NewPCF, PC, PCPlus8;
	logic PCSelector;
	Fetch #(WIDTH) Fetch(NewPCF, PCSelector, clock, reset, PC, PCPlus8);
	
	// Fetch - Decoding FlipFlop
	resetableflipflop  #(WIDTH) FetchFlipFlop(clock, reset, InstructionF, InstructionD);
	
	//-------------------------------------------------------------------------------//
	
	// Decoder
	
	logic [ADDRESSWIDTH-1:0] reg1Address, reg2Address, writeAddressD;
	logic [WIDTH-1:0] dataToSaveD, regDestinationAddressD, regDestinationAddressE;
	logic obtainPCAsR1, writeEnable;
	logic [WIDTH-1:0] reg1ContentD, reg2ContentD, reg1ContentE, reg2ContentE;
	
	Decode #(WIDTH, REGNUM, ADDRESSWIDTH) Decode
	( reg1Address, reg2Address, writeAddressD,
	  regDestinationAddressD, dataToSaveD, PCPlus8,
	  clock, reset, obtainPCAsR1, writeEnable,
	  reg1ContentD, reg2ContentD
	 );
	 
	 
	 // Decode - Execution Flip-Flop
	 
	 resetableflipflop  #(3*WIDTH) DecodeFlipFlop(clock, reset, 
	 {reg1ContentD, reg2ContentD, regDestinationAddressD}, 
	 {reg1ContentE, reg2ContentE, regDestinationAddressE});

	 
	//-------------------------------------------------------------------------------//

	//Execute
	
	logic [3:0] aluControl;
	logic [WIDTH-1:0] aluOutputE, aluOutputM;
	logic N, Z, V, C;
	logic [WIDTH-1:0] regDestinationAddressM, reg2ContentM;
	
	Execute #(WIDTH) Execute
	(reg1ContentE, reg2ContentE,
	 aluControl,
	 aluOutputE,
	 N, Z, V, C
	 );		
	
	
	 // Execution - Memory Flip-Flop
	 
	 
	 resetableflipflop  #(3*WIDTH) ExecuteFlipFlop(clock, reset, 
	 {aluOutputE, reg2ContentE, regDestinationAddressE}, 
	 {aluOutputM, reg2ContentM, regDestinationAddressM});
	 
   //-------------------------------------------------------------------------------//

	//Memory
	logic [WIDTH-1:0] regDestinationAddressWB, aluOutputWB;
	
	assign MemoryDataToWrite = reg2ContentM;
	assign MemoryDataAddress = aluOutputM;
	
	 // Memory - Write Back Flip-Flop

	resetableflipflop  #(3*WIDTH) MemoryFlipFlop(clock, reset, 
	 {aluOutputM, MemoryDataOutputM, regDestinationAddressM}, 
	 {aluOutputWB, MemoryDataOutputWB, regDestinationAddressWB});

    //-------------------------------------------------------------------------------//
	 
	 //Write Back
	 
	 logic resultWBSelector;
	 logic outputWB;
	 mux2  #(WIDTH) writeBack (aluOutputWB, MemoryDataOutputWB, resultWBSelector, outputWB);
	 assign writeAddressD = regDestinationAddressWB;
	 assign dataToSaveD = outputWB;
	 assign NewPCF = outputWB;
	 
endmodule

