`timescale 1 ns / 1 ns
module outdebug();


	parameter WIDTH = 32;
	parameter REGNUM = 16; 
	parameter ADDRESSWIDTH = 4; 
	parameter OPCODEWIDTH = 4;
	parameter INSTRUCTIONWIDTH = 24;
	
	
	logic clock, reset; 
	logic outFlag;
	logic [24:0] out;
	CPU #(WIDTH, REGNUM, ADDRESSWIDTH, OPCODEWIDTH, INSTRUCTIONWIDTH) CPU
	(clock, reset, 0,
	outFlag,
	out);

	logic [15:0] i;
	integer OutFile;
	initial begin
		OutFile = $fopen("C:\\Users\\Juanp\\Documents\\Workspace\\TEC\\PipelineProcessor\\outfile.txt");

		reset = 1;
		clock = 0;
		#10;
		clock = 1;
		#10;
		clock = 0;
		reset = 0;
		#10;
		
		i = 0;
		while(i<5) begin
			clock = 1;
			#10
			if(outFlag) begin 
				$fdisplay(OutFile,"%b", out);
				$display ($sformatf("Out:  %d",out));
				i+=1;
			end
			clock = 0;
			#10;
		end
	end
	
endmodule 