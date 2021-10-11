module condunit
	(output logic takeBranchE,
	input logic [OPCODEWIDTH-1:0] opcodeE,
	input logic N, Z, V, C
	);
		
	always_comb
		case(opcodeE)
			4'b1011: takeBranchE = Z; // EQ
			4'b1100: takeBranchE = ~Z; // NE
			4'b1101: takeBranchE = N!=V; // LT
			4'b1110: takeBranchE = N==V; // GE
			default: takeBranchE = 1'b0; // 0
		endcase
	
endmodule 
					