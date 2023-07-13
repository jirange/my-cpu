`timescale 1ns / 1ps
module pe_switch(
    input wire clk,
	input wire rst,
	input wire [11:0] addr,//�ж���������ַȷʵ��switch�ĵ�ַ070 

	input wire [23:0] sw,//24�����뿪�ص����� �ߵ�ƽ��Ч
	
	output reg [31:0] data//�Ӳ��뿪���ж���������
	);
	
	wire enable_signal;//��ʹ��
	assign enable_signal = (addr==12'h070);
	

	always @ (posedge clk or posedge rst) begin
		if (rst)       
			data <= 32'b0;
		else if (enable_signal) begin
		//�Զ�����ԭ��ķ�ʽ���� ��ֵ����24λ ��λ���
			data <= {8'b00000000,sw[23:0]};
		end
		else data<=data;//enable_signal=0 ������ʱ�� ����ԭ״̬
		
	end
	endmodule