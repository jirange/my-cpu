`timescale 1ns / 1ps
`include "defines.vh"

module ex_alu(
    input      [3:0]  op,
    input      [31:0] A	,
    input      [31:0] B	,
    output reg		  f	,
    output reg [31:0] C
);


wire [4:0] shamt = B[4:0];

//�ѷ�֧���Ƶ�������� �ó��� Ӧ�ÿ��������ٶ� ���ڴ��Ȳ��� ����alu��ȫ����ɿ���

/*
beq x1 x2 label  x1��x2��� �����1  x1-x2
bne x1 x2 label  x1��x2���� �����1  
blt x1 x2 label  x1<x2 �����1  
bge x1 x2 label  x1���ڵ���x2 �����1  */

//alu ��Ҫ��ʲô�����߼� ��λ�� ֮�����  
//����sub���жϱ�־λ���Ǻ���

	
always @(*) begin
    case (op)
        `ALU_ADD: C = A + B ;
		`ALU_SUB: C = A - B ;
		`ALU_AND: C = A & B ;
		`ALU_OR : C = A | B ;
				        
		`ALU_XOR: C = A ^ B ;
		`ALU_SLL: C = A << shamt; 
		`ALU_SRL: C = A >> shamt ;
		`ALU_SRA: C = $signed(A) >>> shamt;

		`ALU_BEQ: if(A==B) f=1;else f=0;
		`ALU_BNE: if(A!=B) f=1;else f=0;
		`ALU_BLT: if($signed(A)<$signed(B))  f=1;else f=0;
		`ALU_BGE: if($signed(A)>=$signed(B)) f=1;else f=0;

        default:  begin C = C; f=f; end
    endcase
end

endmodule