`timescale 1ns / 1ps
//��ʵ��һ�� Ӧ����û����
module pe_led(
    input wire clk,
	input wire rst,
	input wire [11:0] addr,//�ж���������ַȷʵ��led�ĵ�ַ060 

	input wire wen,//дʹ��
	input wire [31:0] data,//Ҫ��ʾ������[31:0]
	output reg [23:0] led

	);
	
	wire enable_signal;//������дʹ��
	assign enable_signal = ((addr==12'h060) && (wen==1));
	

	always @ (posedge clk or posedge rst) begin
		if (rst)       
			led <=0;
		else if (enable_signal) begin
			led <= data[23:0];//ֱ��ȡ��24λ��ֵ��ֵ
		end
		else led<=led;//enable_signal=0 ��д��ʱ�� ����ԭ״̬
		
	end
	endmodule