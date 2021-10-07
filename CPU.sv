
// TO-DO: 
// problema con el tamano de la instruccion y de los datos (confirmar solucion)
// eliminar operaciones innecesarias de alu, 
// agregar paso libre a alu para ambos datos
			
 
module CPU #(parameter WIDTH = 16, parameter REGNUM = 16, 
				parameter ADDRESSWIDTH = 4, parameter OPCODEWIDTH = 4,
				parameter INSTRUCTIONWIDTH = 24)
	(input logic clock, reset, 
					PCSelectorFD, 
					obtainPCAsR1DD, writeEnableDD,
					writeDataEnableMD,
					resultSelectorWBD,
					data2SelectorED,
					takeBranchE,
					input logic [2:0] aluControlED,
					output logic N, Z, V, C,
					output logic [OPCODEWIDTH-1:0] opcodeD
					);
	
	
	logic [1:0] data1ForwardSelectorE, data2ForwardSelectorE;
	logic stallF, stallD, flushE, flushD;
	
		
	//Hazards Unit 
	hazardsUnitsv #(WIDTH, ADDRESSWIDTH) HazardsUnit(
		writeEnableDWB, writeEnableDM, resultSelectorWBE, takeBranchE,
		regDestinationAddressM, regDestinationAddressWB, regDestinationAddressE,
		reg1AddressE, reg2AddressE, reg1AddressD, reg2AddressD,
		data1ForwardSelectorE, data2ForwardSelectorE,
		stallF, stallD, flushE, flushD);

	// Memory 
	
	logic [WIDTH-1:0] MemoryDataAddress, MemoryDataToWrite,
							MemoryDataOutputM, MemoryDataOutputWB;
	logic [INSTRUCTIONWIDTH-1:0] InstructionF, InstructionD;
	mem #(WIDTH, INSTRUCTIONWIDTH) Memory(clock, writeDataEnableMM, PC, MemoryDataAddress, 
					MemoryDataToWrite, InstructionF, MemoryDataOutputM);
	
	//-------------------------------------------------------------------------------//
	// Fetch

	logic [WIDTH-1:0] NewPCF, PC, PCPlus8;
	Fetch #(WIDTH) Fetch(NewPCF, takeBranchE, clock, reset, !stallF, PC, PCPlus8);
	
	// Fetch - Decoding FlipFlop
	resetableflipflop  #(INSTRUCTIONWIDTH) FetchFlipFlop(clock, flushD, !stallD, InstructionF, InstructionD);
	
	//-------------------------------------------------------------------------------//
	
	// Decoder
	
	logic PCSelectorFE, 
			writeEnableDE,
			writeDataEnableME,
			resultSelectorWBE,
			data2SelectorEE;
	logic [2:0] aluControlEE;	

	
	
	logic [ADDRESSWIDTH-1:0] writeAddressD, 
							regDestinationAddressD, regDestinationAddressE,
							reg1AddressD, reg2AddressD, reg1AddressE, reg2AddressE;
	logic [WIDTH-1:0] inmmediateD, inmmediateE, dataToSaveD;
	logic [WIDTH-1:0] reg1ContentD, reg2ContentD, reg1ContentE, reg2ContentE;
	
	Decode #(WIDTH, REGNUM, ADDRESSWIDTH, OPCODEWIDTH, INSTRUCTIONWIDTH) Decode
	( writeAddressD,
	  dataToSaveD, PCPlus8,
	  InstructionD,
	  clock, reset, obtainPCAsR1DD, writeEnableDD,
	  reg1ContentD, reg2ContentD, inmmediateD,
	  regDestinationAddressD, reg1AddressD, reg2AddressD,
	  opcodeD
	 );
	 
	 
	 // Decode - Execution Flip-Flop
	 
	 resetableflipflop  #(3*ADDRESSWIDTH+3*WIDTH+5+3) DecodeFlipFlop(clock, flushE, 1'b1,
	 {reg1ContentD, reg2ContentD, regDestinationAddressD, inmmediateD, reg1AddressD, reg2AddressD,
			PCSelectorFD, 
			writeEnableDD,
			writeDataEnableMD,
			resultSelectorWBD,
			data2SelectorED,
	      aluControlED}, 
	 {reg1ContentE, reg2ContentE, regDestinationAddressE, inmmediateE, reg1AddressE, reg2AddressE,
			PCSelectorFE, 
			writeEnableDE,
			writeDataEnableME,
			resultSelectorWBE,
			data2SelectorEE,
	      aluControlEE});

	 
	//-------------------------------------------------------------------------------//

	//Execute
	
	logic PCSelectorFM, 
			writeEnableDM,
			writeDataEnableMM,
			resultSelectorWBM;

	
	logic [WIDTH-1:0] aluOutputE, aluOutputM;
	logic [WIDTH-1:0] reg2ContentM, forwardM, forwardWB;
	logic [ADDRESSWIDTH-1:0] regDestinationAddressM;
	
	
	Execute #(WIDTH) Execute
	(reg1ContentE, reg2ContentE, inmmediateE, forwardM, forwardWB,
	 aluControlEE,
	 data2SelectorEE,
	 data1ForwardSelectorE, data2ForwardSelectorE,
	 aluOutputE,
	 N, Z, V, C
	 );		
	
	
	 // Execution - Memory Flip-Flop
	 
	 
	 resetableflipflop  #(2*WIDTH+ADDRESSWIDTH+4) ExecuteFlipFlop(clock, reset, 1'b1,
	 {aluOutputE, reg2ContentE, regDestinationAddressE,
			PCSelectorFE, 
			writeEnableDE,
			writeDataEnableME,
			resultSelectorWBE}, 
	 {aluOutputM, reg2ContentM, regDestinationAddressM,
			PCSelectorFM, 
			writeEnableDM,
			writeDataEnableMM,
			resultSelectorWBM});
	 
   //-------------------------------------------------------------------------------//

	//Memory
	
	

	
	logic PCSelectorFWB,
      	writeEnableDWB,
			resultSelectorWBWB,
			data2SelectorEWB;
	logic [2:0] aluControlEWB;	


	
	
	logic [WIDTH-1:0] aluOutputWB;
	logic [ADDRESSWIDTH-1:0] regDestinationAddressWB;
	
	assign MemoryDataToWrite = reg2ContentM;
	assign MemoryDataAddress = aluOutputM;
	assign forwardM = aluOutputM;
	 // Memory - Write Back Flip-Flop

	resetableflipflop  #(2*WIDTH+ADDRESSWIDTH+3) MemoryFlipFlop(clock, reset, 1'b1,
	 {aluOutputM, MemoryDataOutputM, regDestinationAddressM,
			PCSelectorFM, 
		   writeEnableDM,
			resultSelectorWBM}, 
	 {aluOutputWB, MemoryDataOutputWB, regDestinationAddressWB,
			PCSelectorFWB, 
			writeEnableDWB,
			resultSelectorWBWB});

    //-------------------------------------------------------------------------------//
	 
	 //Write Back
	 
	 
	 logic [WIDTH-1:0] outputWB;
	 mux2  #(WIDTH) writeBack (aluOutputWB, MemoryDataOutputWB, resultSelectorWBWB, outputWB);
	 assign writeAddressD = regDestinationAddressWB;
	 assign dataToSaveD = outputWB;
	 assign NewPCF = outputWB;
	 assign forwardWB = outputWB;

endmodule

