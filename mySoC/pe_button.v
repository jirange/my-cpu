`timescale 1ns / 1ps
//��дд Ӧ����û����
module pe_button(
    input wire clk,
	input wire rst,
	input wire [11:0] addr,//078

	input wire [4:0] button,//5 λ �������ص�����[4:0]
	
	output reg [31:0] data//�Ӳ��뿪���ж���������
	);
	
	wire enable_signal;//��ʹ��
	assign enable_signal = (addr==12'h078);
	
//������data������ʲô�� ��ʲô������ʽ�� ��������5λ���ĵ���������ʲô��ʽ�� ��������������
	always @ (posedge clk or posedge rst) begin
		if (rst)       
			data <= 32'b0;
		else if (enable_signal) begin
		//�Զ�����ԭ��ķ�ʽ���� ��ֵ����5λ ��λ���
			data <= {8'b00000000,button[4:0]};
			
		end
		else data<=data;
		//enable_signal=0 ������ʱ�� ����ԭ״̬
	end
	
endmodule