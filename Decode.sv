/*
	Instruction Decoding Module
	Inputs:
	- reg1Address: address del registro 1 a obtener
	- reg2Address: address del registro 2 a obtener
	- writeAddress: address del registro a sobreescribir
	- inmmediate: 
	- PCPlus8: pc+8
	- dataToSave: datos a escribir
	- clock: 
	- reset: 
	- obtainPCAsR1: bit que indica si obtener el pc como reg1Content 
	- writeEnable: 
	
	Outputs:
	- reg1Content: contenido del reg1
	- reg2Content: contenido del reg2
	
	Params: 
	- REGNUM: number of registers in regfile
	- WIDTH: width of the data
	- ADRESSWIDTH: size of the addresses in regfile
*/
module Decode #(parameter WIDTH = 	8, parameter REGNUM = 8, 
					parameter ADDRESSWIDTH = 3, parameter OPCODEWIDTH = 4,
					parameter INSTRUCTIONWIDTH = 16)
	(input logic [ADDRESSWIDTH-1:0] writeAddress,
	 input logic [WIDTH-1:0] dataToSave, PCPlus8,
	 input logic [INSTRUCTIONWIDTH-1:0] instruction,
	 input logic clock, reset, obtainPCAsR1, writeEnable,
	 output logic [WIDTH-1:0] reg1Content, reg2Content, inmediate,
	 output logic [ADDRESSWIDTH-1:0] regDestinationAddress, reg1FinalAddress, reg2Address,
	 output logic [OPCODEWIDTH-1:0] opcode
	 );
	
	logic [ADDRESSWIDTH-1:0] reg1Address;
	
	
	assign reg1Address = instruction[3:0];
	assign reg2Address = instruction[7:4];
	assign regDestinationAddress = instruction[11:8];
	assign inmediate[7:0] = instruction[7:0];
	assign inmediate[WIDTH-1:8] = 0;
	assign opcode = instruction[15:12];
	
	
	mux2  #(ADDRESSWIDTH) r1AddressSelector (reg1Address, 4'd15, obtainPCAsR1, reg1FinalAddress);
	
	
	regfile #(WIDTH, REGNUM, ADDRESSWIDTH) registerFile (!clock, writeEnable, 
reg1FinalAddress,reg2Address, writeAddress, dataToSave, PCPlus8, reg1Content, reg2Content );

endmodule

