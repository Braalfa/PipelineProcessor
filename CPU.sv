
// TO-DO: 
// problema con el tamano de la instruccion y de los datos (confirmar solucion)
// eliminar operaciones innecesarias de alu, 
// agregar paso libre a alu para ambos datos
			
 
module CPU #(parameter WIDTH = 32, parameter REGNUM = 16, 
				parameter ADDRESSWIDTH = 4, parameter OPCODEWIDTH = 4,
				parameter INSTRUCTIONWIDTH = 16)
	(input logic clock, reset, startIO, 
	output logic outFlagIOWB,
	output logic [24:0] out);
	
	logic writeEnableDD,
	writeDataEnableMD,
	resultSelectorWBD,
	data2SelectorED,
	takeBranchE,
	outFlagIOD;
	logic [2:0] aluControlED;
	logic NE2, ZE2, VE2, CE2;
	logic [OPCODEWIDTH-1:0] opcodeD, opcodeE;
	

	
	logic [1:0] data1ForwardSelectorE, data2ForwardSelectorE;
	logic stallF, stallD, flushE, flushD;

	

	logic [WIDTH-1:0] NewPCF, PCF;


	
	logic [WIDTH-1:0] MemoryDataAddress, MemoryDataToWrite,
							MemoryDataOutputM, MemoryDataOutputWB;
	logic [INSTRUCTIONWIDTH-1:0] InstructionF, InstructionD;

	
	
	logic writeEnableDE,
			writeDataEnableME,
			resultSelectorWBE,
			data2SelectorEE,
			outFlagIOE;
	logic [2:0] aluControlEE;	
	logic [ADDRESSWIDTH-1:0] writeAddressD, 
							regDestinationAddressD, regDestinationAddressE,
							reg1AddressD, reg2AddressD, reg1AddressE, reg2AddressE;
	logic [WIDTH-1:0] inmmediateD, inmmediateE, dataToSaveD;
	logic [WIDTH-1:0] reg1ContentD, reg2ContentD, reg1ContentE, reg2ContentE;


	
	logic writeEnableDM,
			writeDataEnableMM,
			resultSelectorWBM,
			outFlagIOM;
	logic NE1, ZE1, VE1, CE1;
	logic [WIDTH-1:0] aluOutputE, aluOutputM;
	logic [WIDTH-1:0] reg2ContentM, forwardM, forwardWB;
	logic [ADDRESSWIDTH-1:0] regDestinationAddressM;

	
	
	logic writeEnableDWB,
			resultSelectorWBWB,
			data2SelectorEWB;
	logic [2:0] aluControlEWB;	
	logic [WIDTH-1:0] aluOutputWB;
	logic [ADDRESSWIDTH-1:0] regDestinationAddressWB;
	
	
	logic [WIDTH-1:0] outputWB;

	
	// Control Unit
	controlunit #(OPCODEWIDTH) controlunit(
		writeEnableDD,
		writeDataEnableMD,
		resultSelectorWBD,
		data2SelectorED,
		outFlagIOD,
		aluControlED,
		opcodeD
	);
	
	// condunit
	
	condunit #(OPCODEWIDTH) condunit
	(takeBranchE,
	 opcodeE,
	NE2, ZE2, VE2, CE2
	);
	
	// -----------------//
		
		
	//Hazards Unit 
	hazardsUnitsv #(WIDTH, ADDRESSWIDTH) HazardsUnit(
		writeEnableDWB, writeEnableDM, resultSelectorWBE, takeBranchE,
		regDestinationAddressM, regDestinationAddressWB, regDestinationAddressE,
		reg1AddressE, reg2AddressE, reg1AddressD, reg2AddressD,
		data1ForwardSelectorE, data2ForwardSelectorE,
		stallF, stallD, flushE, flushD);

	// Memory 
	
	mem #(WIDTH, INSTRUCTIONWIDTH) Memory(clock, writeDataEnableMM, PCF, MemoryDataAddress, 
					MemoryDataToWrite, InstructionF, MemoryDataOutputM);
	
	//-------------------------------------------------------------------------------//
	// Fetch

	Fetch #(WIDTH) Fetch(NewPCF, takeBranchE, clock, reset, !stallF, PCF);
	
	// Fetch - Decoding FlipFlop
	resetableflipflop  #(INSTRUCTIONWIDTH) FetchFlipFlop(clock, flushD, !stallD, {InstructionF}, {InstructionD});
	
	//-------------------------------------------------------------------------------//
	
	// Decoder
		
	Decode #(WIDTH, REGNUM, ADDRESSWIDTH, OPCODEWIDTH, INSTRUCTIONWIDTH) Decode
	( writeAddressD,
	  dataToSaveD,
	  InstructionD,
	  clock, reset, writeEnableDWB, startIO,
	  reg1ContentD, reg2ContentD, inmmediateD,
	  regDestinationAddressD, reg1AddressD, reg2AddressD,
	  opcodeD
	 );
	 
	 
	 // Decode - Execution Flip-Flop
	 
	 resetableflipflop  #(3*ADDRESSWIDTH+3*WIDTH+4+3+4+4+1) DecodeFlipFlop(clock, flushE, 1'b1,
	 {reg1ContentD, reg2ContentD, regDestinationAddressD, inmmediateD, reg1AddressD, reg2AddressD,
			writeEnableDD,
			writeDataEnableMD,
			resultSelectorWBD,
			data2SelectorED,
	      aluControlED,
			opcodeD,
			NE1, ZE1, VE1, CE1, outFlagIOD}, 
	 {reg1ContentE, reg2ContentE, regDestinationAddressE, inmmediateE, reg1AddressE, reg2AddressE,
			writeEnableDE,
			writeDataEnableME,
			resultSelectorWBE,
			data2SelectorEE,
	      aluControlEE,
			opcodeE,
			NE2, ZE2, VE2, CE2, outFlagIOE});

	 
	//-------------------------------------------------------------------------------//

	//Execute
	
	logic [WIDTH-1:0] reg2FinalE;

	Execute #(WIDTH) Execute
	(reg1ContentE, reg2ContentE, inmmediateE, forwardM, forwardWB,
	 aluControlEE,
	 data2SelectorEE,
	 data1ForwardSelectorE, data2ForwardSelectorE,
	 reg2FinalE, aluOutputE,
	 NE1, ZE1, VE1, CE1
	 );		
	


	 assign NewPCF = aluOutputE;
	
	 // Execution - Memory Flip-Flop
	 
	 
	 resetableflipflop  #(2*WIDTH+ADDRESSWIDTH+4) ExecuteFlipFlop(clock, reset, 1'b1,
	 {aluOutputE, reg2FinalE, regDestinationAddressE,
			writeEnableDE,
			writeDataEnableME,
			resultSelectorWBE,
			outFlagIOE}, 
	 {aluOutputM, reg2ContentM, regDestinationAddressM,
			writeEnableDM,
			writeDataEnableMM,
			resultSelectorWBM,
			outFlagIOM});
	 
   //-------------------------------------------------------------------------------//

	//Memory
	
	
	assign MemoryDataToWrite = reg2ContentM;
	assign MemoryDataAddress = aluOutputM;
	assign forwardM = aluOutputM;

	 // Memory - Write Back Flip-Flop

	resetableflipflop  #(2*WIDTH+ADDRESSWIDTH+3) MemoryFlipFlop(clock, reset, 1'b1,
	 {aluOutputM, MemoryDataOutputM, regDestinationAddressM,
		   writeEnableDM,
			resultSelectorWBM,
			outFlagIOM}, 
	 {aluOutputWB, MemoryDataOutputWB, regDestinationAddressWB,
			writeEnableDWB,
			resultSelectorWBWB,
			outFlagIOWB});

    //-------------------------------------------------------------------------------//
	 
	 //Write Back
	 
	 
	 mux2  #(WIDTH) writeBack (aluOutputWB, MemoryDataOutputWB, resultSelectorWBWB, outputWB);
	 assign writeAddressD = regDestinationAddressWB;
	 assign dataToSaveD = outputWB;
	 assign forwardWB = outputWB;
	 
	 
	 
	 assign out = MemoryDataOutputWB[24:0];

	 initial begin 
		resultSelectorWBE = 0;
	 end
	 
	 
	 always_ff@(posedge clock) begin 
		$display ("----------------Ciclo-------------------");
				
				
		$display ($sformatf("Primer Flip Flop: InstructionF = %b, PCF = %d",InstructionF, PCF));
		
		
		$display ($sformatf("Segundo Flip Flop: reg1ContentD = %h, reg2ContentD = %h",reg1ContentD, reg2ContentD));
		$display ($sformatf("Segundo Flip Flop: regDestinationAddressD = %h, inmmediateD = %h ", regDestinationAddressD, inmmediateD));
		$display ($sformatf("Segundo Flip Flop: reg1AddressD = %h, reg2AddressD = %h ", reg1AddressD, reg2AddressD));
		$display ($sformatf("Segundo Flip Flop: writeEnableDD = %h, writeDataEnableMD = %h ", writeEnableDD, writeDataEnableMD));
		$display ($sformatf("Segundo Flip Flop: resultSelectorWBD = %h, data2SelectorED = %h ", resultSelectorWBD, data2SelectorED));
		$display ($sformatf("Segundo Flip Flop: aluControlED = %h, opcodeD = %h ", aluControlED, opcodeD));
		$display ($sformatf("Segundo Flip Flop: NE1 = %h, ZE1 = %h, VE1 = %h, CE1 = %h", NE1, ZE1, VE1, CE1));


		$display ($sformatf("Tercer Flip Flop: aluOutputE = %b, reg2FinalE = %b",aluOutputE, reg2FinalE));
		$display ($sformatf("Tercer Flip Flop: regDestinationAddressE = %h, writeEnableDE = %b",regDestinationAddressE, writeEnableDE));
		$display ($sformatf("Tercer Flip Flop: writeDataEnableME = %b, resultSelectorWBE = %b",writeDataEnableME, resultSelectorWBE));
		
		
		$display ($sformatf("Cuarto Flip Flop: aluOutputM = %b, MemoryDataOutputM = %d",aluOutputM, MemoryDataOutputM));
		$display ($sformatf("Cuarto Flip Flop: regDestinationAddressM = %b, writeEnableDM = %d",regDestinationAddressM, writeEnableDM));
		$display ($sformatf("Cuarto Flip Flop: resultSelectorWBM = %b",resultSelectorWBM));

		
		$display ($sformatf("WriteBack: regDestinationAddressWB = %b, outputWB = %b",regDestinationAddressWB, outputWB));
		
		$display ($sformatf("Riesgos: stallF = %b, stallD = %d",stallF, stallD));
		$display ($sformatf("Riesgos: flushE = %b, flushD = %d",flushE, flushD));
		$display ($sformatf("Riesgos: data1ForwardSelectorE = %b, data2ForwardSelectorE = %b",data1ForwardSelectorE, data2ForwardSelectorE));
	end

endmodule

