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
module Decode #(parameter WIDTH = 8, parameter REGNUM = 8, parameter ADDRESSWIDTH = 3)
	(input logic [ADDRESSWIDTH-1:0] reg1Address, reg2Address, writeAddress,
	 input logic [WIDTH-1:0] inmmediate, PCPlus8,
	 input logic clock, reset, obtainPCAsR1, writeEnable,
	 output logic [WIDTH-1:0] reg1Content, reg2Content
	 );
	
	logic [ADDRESSWIDTH-1:0] reg1FinalAddress;
	
	mux2  #(WIDTH) r1AddressSelector (reg1Address, 4'd8, obtainPCAsR1, reg1FinalAddress);
	regfile #(WIDTH, REGNUM, ADDRESSWIDTH) registerFile (clock, writeEnable, 
reg1FinalAddress,reg2Address, writeAddress, inmmediate, PCPlus8, reg1Content, reg2Content );

endmodule
