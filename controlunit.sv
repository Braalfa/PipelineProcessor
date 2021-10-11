module controlunit
	(output logic PCSelectorFD, 
					obtainPCAsR1DD, writeEnableDD,
					writeDataEnableMD,
					resultSelectorWBD,
					data2SelectorED,
					outFlag,
					takeBranchE,
					output logic [2:0] aluControlED,
					input logic N, Z, V, C,
					input logic [OPCODEWIDTH-1:0] opcodeD
					);
					
	always_comb begin 
		
		case(opcodeD)
			4'b0000: begin 
				PCSelectorFD = 0; 
				obtainPCAsR1DD = 0; 
				writeEnableDD = 1;
				//data2SelectorED = ;
				aluControlED = 3'b110;
				writeDataEnableMD = 0;
				resultSelectorWBD = 1;
				outFlag = 0;
			end
			4'b0001: begin 
				PCSelectorFD = 0; 
				obtainPCAsR1DD = 0; 
				writeEnableDD = 0;
				//data2SelectorED = ;
				aluControlED = 3'b110;
				writeDataEnableMD = 1;
				//resultSelectorWBD = 1;
				outFlag = 0;
			end
			4'b0010: begin 
				PCSelectorFD = 0; 
				obtainPCAsR1DD = 0; 
				writeEnableDD = 1;
				data2SelectorED = 1;
				aluControlED = 3'b111;
				writeDataEnableMD = 0;
				resultSelectorWBD = 0;
				outFlag = 0;
			end
			4'b0011: begin 
				PCSelectorFD = 0; 
				obtainPCAsR1DD = 0; 
				writeEnableDD = 1;
				//data2SelectorED = 1;
				aluControlED = 3'b110;
				writeDataEnableMD = 0;
				resultSelectorWBD = 0;
				outFlag = 0;
			end
			4'b0100: begin 
				PCSelectorFD = 0; 
				obtainPCAsR1DD = 0; 
				writeEnableDD = 0;
				//data2SelectorED = ;
				aluControlED = 3'b110;
				writeDataEnableMD = 0;
				//resultSelectorWBD = 0;
				outFlag = 1;
			end
			4'b0101: begin 
				PCSelectorFD = 0; 
				obtainPCAsR1DD = 0; 
				writeEnableDD = 1;
				data2SelectorED = 0;
				aluControlED = 3'b000;
				writeDataEnableMD = 0;
				resultSelectorWBD = 0;
				outFlag = 0;
			end
			4'b0110: begin 
				PCSelectorFD = 0; 
				obtainPCAsR1DD = 0; 
				writeEnableDD = 1;
				data2SelectorED = 0;
				aluControlED = 3'b000;
				writeDataEnableMD = 0;
				resultSelectorWBD = 0;
				outFlag = 0;
			end
			4'b0111: begin 
				PCSelectorFD = 0; 
				obtainPCAsR1DD = 0; 
				writeEnableDD = 1;
				data2SelectorED = 0;
				aluControlED = 3'b000;
				writeDataEnableMD = 0;
				resultSelectorWBD = 0;
				outFlag = 0;
			end
			4'b1000: begin 
				PCSelectorFD = 0; 
				obtainPCAsR1DD = 0; 
				writeEnableDD = 1;
				data2SelectorED = 0;
				aluControlED = 3'b000;
				writeDataEnableMD = 0;
				resultSelectorWBD = 0;
				outFlag = 0;
			end
			4'b1001: begin 
				PCSelectorFD = 0; 
				obtainPCAsR1DD = 0; 
				writeEnableDD = 1;
				data2SelectorED = 0;
				aluControlED = 3'b000;
				writeDataEnableMD = 0;
				resultSelectorWBD = 0;
				outFlag = 0;
			end
			4'b1010: begin 
				PCSelectorFD = 0; 
				obtainPCAsR1DD = 0; 
				writeEnableDD = 0;
				data2SelectorED = 0;
				aluControlED = 3'b001;
				writeDataEnableMD = 0;
				//resultSelectorWBD = 0;
				outFlag = 0;
			end
			4'b1011: begin 
				PCSelectorFD = 1; 
				obtainPCAsR1DD = 1; 
				writeEnableDD = 0;
				data2SelectorED = 1;
				aluControlED = 3'b000;
				writeDataEnableMD = 0;
				resultSelectorWBD = 0;
				outFlag = 0;
			end
			4'b1100: begin 
				PCSelectorFD = 1; 
				obtainPCAsR1DD = 1; 
				writeEnableDD = 0;
				data2SelectorED = 1;
				aluControlED = 3'b000;
				writeDataEnableMD = 0;
				resultSelectorWBD = 0;
				outFlag = 0;		
			end
			4'b1101: begin 
				PCSelectorFD = 1; 
				obtainPCAsR1DD = 1; 
				writeEnableDD = 0;
				data2SelectorED = 1;
				aluControlED = 3'b000;
				writeDataEnableMD = 0;
				resultSelectorWBD = 0;
				outFlag = 0;			
			end
			4'b1110: begin 
				PCSelectorFD = 1; 
				obtainPCAsR1DD = 1; 
				writeEnableDD = 0;
				data2SelectorED = 1;
				aluControlED = 3'b000;
				writeDataEnableMD = 0;
				resultSelectorWBD = 0;
				outFlag = 0;					
			end
			4'b1111: begin 
				PCSelectorFD = 1; 
				obtainPCAsR1DD = 1; 
				writeEnableDD = 0;
				data2SelectorED = 1;
				aluControlED = 3'b000;
				writeDataEnableMD = 0;
				resultSelectorWBD = 0;
				outFlag = 0;			
			end
			
		endcase
		
	
	end
	
	

endmodule
	