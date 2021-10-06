
// TO-DO: 
// problema con el tamano de la instruccion y de los datos (confirmar solucion)
// eliminar operaciones innecesarias de alu, 
// agregar paso libre a alu para ambos datos
			
 
module CPU #(parameter WIDTH = 16, parameter REGNUM = 16, 
				parameter ADDRESSWIDTH = 4, parameter OPCODEWIDTH = 4,
				parameter INSTRUCTIONWIDTH = 24)
	(input logic clock, reset, 
					PCSelectorF, 
					obtainPCAsR1D, writeEnableD,
					writeDataEnableM,
					resultSelectorWB,
					data2SelectorE,
					input logic [2:0] aluControlE,
					output logic N, Z, V, C,
					output logic [OPCODEWIDTH-1:0] opcodeD
					);
	
	// Connection to memory
	
	logic [WIDTH-1:0] MemoryDataAddress, MemoryDataToWrite,
							MemoryDataOutputM, MemoryDataOutputWB;
	logic [INSTRUCTIONWIDTH-1:0] InstructionF, InstructionD;
	mem #(WIDTH, INSTRUCTIONWIDTH) Memory(clock, writeDataEnableM, PC, MemoryDataAddress, 
					MemoryDataToWrite, InstructionF, MemoryDataOutputM);
	
	//-------------------------------------------------------------------------------//
	// Fetch
	
	logic [WIDTH-1:0] NewPCF, PC, PCPlus8;
	Fetch #(WIDTH) Fetch(NewPCF, PCSelectorF, clock, reset, PC, PCPlus8);
	
	// Fetch - Decoding FlipFlop
	resetableflipflop  #(INSTRUCTIONWIDTH) FetchFlipFlop(clock, reset, InstructionF, InstructionD);
	
	//-------------------------------------------------------------------------------//
	
	// Decoder
	
	logic [ADDRESSWIDTH-1:0] writeAddressD, 
							regDestinationAddressD, regDestinationAddressE;
	logic [WIDTH-1:0] inmmediateD, inmmediateE, dataToSaveD;
	logic [WIDTH-1:0] reg1ContentD, reg2ContentD, reg1ContentE, reg2ContentE;
	
	Decode #(WIDTH, REGNUM, ADDRESSWIDTH, OPCODEWIDTH, INSTRUCTIONWIDTH) Decode
	( writeAddressD,
	  dataToSaveD, PCPlus8,
	  InstructionD,
	  clock, reset, obtainPCAsR1D, writeEnableD,
	  reg1ContentD, reg2ContentD, inmmediateD,
	  regDestinationAddressD,
	  opcodeD
	 );
	 
	 
	 // Decode - Execution Flip-Flop
	 
	 resetableflipflop  #(ADDRESSWIDTH+3*WIDTH) DecodeFlipFlop(clock, reset, 
	 {reg1ContentD, reg2ContentD, regDestinationAddressD, inmmediateD}, 
	 {reg1ContentE, reg2ContentE, regDestinationAddressE, inmmediateE});

	 
	//-------------------------------------------------------------------------------//

	//Execute
	
	logic [WIDTH-1:0] aluOutputE, aluOutputM;
	logic [WIDTH-1:0] reg2ContentM;
	logic [ADDRESSWIDTH-1:0] regDestinationAddressM;
	
	Execute #(WIDTH) Execute
	(reg1ContentE, reg2ContentE, inmmediateE,
	 aluControlE,
	 data2SelectorE,
	 aluOutputE,
	 N, Z, V, C
	 );		
	
	
	 // Execution - Memory Flip-Flop
	 
	 
	 resetableflipflop  #(2*WIDTH+ADDRESSWIDTH) ExecuteFlipFlop(clock, reset, 
	 {aluOutputE, reg2ContentE, regDestinationAddressE}, 
	 {aluOutputM, reg2ContentM, regDestinationAddressM});
	 
   //-------------------------------------------------------------------------------//

	//Memory
	logic [WIDTH-1:0] aluOutputWB;
	logic [ADDRESSWIDTH-1:0] regDestinationAddressWB;
	
	assign MemoryDataToWrite = reg2ContentM;
	assign MemoryDataAddress = aluOutputM;
	
	 // Memory - Write Back Flip-Flop

	resetableflipflop  #(2*WIDTH+ADDRESSWIDTH) MemoryFlipFlop(clock, reset, 
	 {aluOutputM, MemoryDataOutputM, regDestinationAddressM}, 
	 {aluOutputWB, MemoryDataOutputWB, regDestinationAddressWB});

    //-------------------------------------------------------------------------------//
	 
	 //Write Back
	 
	 logic [WIDTH-1:0] outputWB;
	 mux2  #(WIDTH) writeBack (aluOutputWB, MemoryDataOutputWB, resultSelectorWB, outputWB);
	 assign writeAddressD = regDestinationAddressWB;
	 assign dataToSaveD = outputWB;
	 assign NewPCF = outputWB;
	 
endmodule

