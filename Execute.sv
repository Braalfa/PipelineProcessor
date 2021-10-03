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
	(input logic [WIDTH-1:0] data1, data2,
	 input logic [3:0] aluControl,
	 output logic [WIDTH-1:0] aluOutput,
	 output logic N, Z, V, C
	 );		
	
	ALU #(WIDTH) ALU( 
		 data1,
		 data2,
		 aluControl,
		 aluOutput,
		 N,
		 Z,
		 V,
		 C 
	);

endmodule

