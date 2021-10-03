module ALU #(parameter WIDTH = 32)( 
    input [WIDTH-1:0] A,
	 input [WIDTH-1:0] B,
	 input [3:0] sel,
    output logic [WIDTH-1:0] Out,
	 output logic N,
	 output logic Z,
	 output logic V,
	 output logic C 
);


	//=============SUMADOR=============

	logic [WIDTH-1:0] OutSumador;
	logic CSumador,VSumador;

	Adder_Substractor #(.WIDTH( WIDTH )) Sumador(A,B,OutSumador,sel[0],CSumador,VSumador);

		
	//=============MULTIPLICADOR=============
	
	logic [WIDTH-1:0] OutMultiplicador;
	logic CMultiplicador,VMultiplicador;

	multiplicador #( WIDTH ) Multiplicador(A,B,OutMultiplicador,VMultiplicador,CMultiplicador);
	
	//=============DIVISOR=============
	
	logic [WIDTH-1:0] OutDivisor;
	logic CDivisor,VDivisor;

	divisor #( WIDTH ) Divisor(A,B,OutDivisor,VDivisor,CDivisor);
	
	//=============MODULO=============
	
	logic [WIDTH-1:0] OutModulo;
	logic CModulo,VModulo;

	modulo #( WIDTH ) Modulo(A,B,OutModulo,VModulo,CModulo);
	
	//=============AND=============
	
	logic [WIDTH-1:0] OutAND;
	logic CAND,VAND;

	and_modulo #( WIDTH ) AND(A,B,OutAND,VAND,CAND);
	
	//=============OR=============
	
	logic [WIDTH-1:0] OutOR;
	logic COR,VOR;

	or_modulo #( WIDTH ) OR(A,B,OutOR,VOR,COR);
	
	//=============XOR=============
	
	logic [WIDTH-1:0] OutXOR;
	logic CXOR,VXOR;

	xor_modulo #( WIDTH ) XOR(A,B,OutXOR,VXOR,CXOR);
	
	
	//=============SHIFTL=============
	
	logic [WIDTH-1:0] OutShiftL;
	logic CShiftL,VShiftL;

	shiftL_modulo #( WIDTH ) ShiftL(A,OutShiftL,VShiftL,CShiftL);
	
	//=============SHIFTR=============
	
	logic [WIDTH-1:0] OutShiftR;
	logic CShiftR,VShiftR;

	shiftR_modulo #( WIDTH ) ShiftR(A,OutShiftR,VShiftR,CShiftR);
	

	always_comb begin  
	
      case (sel)  
         4'b0000,
			4'b0001 : begin
				Out = OutSumador;
				C <= CSumador;
				V <= VSumador;
				
			end
			4'b0010 : begin
				Out = OutMultiplicador;
				C <= CMultiplicador;
				V <= VMultiplicador;
				
			end
			4'b0011 :begin
				Out = OutDivisor;
				C <= CDivisor;
				V <= VDivisor;
				
			end
			4'b0100 : begin
				Out = OutModulo;
				C <= CModulo;
				V <= VModulo;
				
			end
			4'b0101 : begin
				Out = OutAND;
				C <= CAND;
				V <= VAND;
				
			end
			4'b0110 :begin
				Out = OutOR;
				C <= COR;
				V <= VOR;
				
			end
			4'b0111 : begin
				Out = OutXOR;
				C <= CXOR;
				V <= VXOR;
				
			end
			4'b1000 : begin
				Out = OutShiftL;
				C <= CShiftL;
				V <= VShiftL;
				
			end
			4'b1001 : begin
				Out = OutShiftR;
				C <= CShiftR;
				V <= VShiftR;
				
			end
			default : begin
				Out = A;
				C <= 0;
				V <= 0;
				
			end
      endcase 
	
		N <= Out[WIDTH-1];
		Z <= ~|Out;
		
		
   end
	
endmodule