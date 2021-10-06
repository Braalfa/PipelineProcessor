/*
	Execution Module
	Inputs:
	- data1, data2
	- aluControl: alu operation mode
	
	Outputs:
	- aluOutput: 
	- N, Z, V, C: alu flags
	
	Params: 
	- WIDTH: width of the data
*/
module Execute #(parameter WIDTH = 8)
	(input logic [WIDTH-1:0] data1, data2, data3,
	 input logic [2:0] aluControl,
	 input logic data2Selector,
	 output logic [WIDTH-1:0] aluOutput,
	 output logic N, Z, V, C
	 );		
	
	logic [WIDTH-1:0] data2Final;
	
	mux2  #(WIDTH) data2MUX(data2, data3, data2Selector, data2Final);

	ALU #(WIDTH) ALU( 
		 data1,
		 data2Final,
		 aluControl,
		 aluOutput,
		 N,
		 Z,
		 V,
		 C 
	);

endmodule

