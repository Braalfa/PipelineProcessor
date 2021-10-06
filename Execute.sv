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
	(input logic [WIDTH-1:0] data1, data2, data3, forwardM, forwardWB,
	 input logic [2:0] aluControl,
	 input logic data2Selector,
	 input logic [1:0] data1ForwardSelector, data2ForwardSelector,
	 output logic [WIDTH-1:0] aluOutput,
	 output logic N, Z, V, C
	 );		
	
	logic [WIDTH-1:0] data2Final;
	logic [WIDTH-1:0] data1AfterForward;
	logic [WIDTH-1:0] data2AfterForward;

	mux3  #(WIDTH) data1ForwardMUX(data1, forwardWB, forwardM, 
									data1ForwardSelector, data1AfterForward);	
	mux3  #(WIDTH) data2ForwardMUX(data2, forwardWB, forwardM, 
	data2ForwardSelector, data2AfterForward);	

	mux2  #(WIDTH) data2MUX(data2AfterForward, 
						data3, data2Selector, data2Final);

	
	ALU #(WIDTH) ALU( 
		 data1AfterForward,
		 data2Final,
		 aluControl,
		 aluOutput,
		 N,
		 Z,
		 V,
		 C 
	);

endmodule

