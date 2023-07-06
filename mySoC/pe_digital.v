`timescale 1ns / 1ps
module pe_digital#(
	parameter NUM0 = 7'b1000000,//40 G……A
	parameter NUM1 = 7'b1111001,//79
	parameter NUM2 = 7'b0100100,//24
	parameter NUM3 = 7'b0110000,//30
	parameter NUM4 = 7'b0011001,//19
	parameter NUM5 = 7'b0010010,//12
	parameter NUM6 = 7'h02,
	parameter NUM7 = 7'h78,
	parameter NUM8 = 7'h00,
	parameter NUM9 = 7'h10,
	parameter NUMA = 7'h08,
	parameter NUMB = 7'h03,
	parameter NUMC = 7'h46,
	parameter NUMD = 7'h21,
	parameter NUME = 7'h06,
	parameter NUMF = 7'h0e,
	parameter BLANK = 7'b1111111
)(
    input wire clk,
	input wire rst,
	input wire [11:0] addr,//写数码管的地址[11:0]  判断如果这个地址确实是数码管的地址 则有反应
	//是cpu地址的低12位 即16进制的3位 0xFFFF_F000 后三位有什么用吗 难道说 必须是000 如果是010什么的就不是数码管了？ 相当于具体的偏移信号
	input wire wen,//数码管的写使能

	
	input wire [31:0] data,//要数码管显示的数据[31:0]
	output reg [7:0] led_en,//low
	output reg [6:0] led_cx//low
	);
	
	//数码管	0xFFFF_F000
	wire enable_signal;//真正的写使能
	assign enable_signal = ((addr==12'h000) && (wen==1));

	reg [31:0] num;

	 
	//data 可能是0x12345678 在对应的位置上显示对应的十六进制数
	reg [6:0] display_num [7:0];
	integer i;
	always @ (posedge clk or posedge rst) begin
		if (rst)       
			for (i = 0; i <= 7; i = i + 1) begin
				display_num[i] <= BLANK;//复位数码管显示的数据 全亮
			end
		else if (enable_signal) begin
			num = data;
			for (i = 0; i <= 7; i = i + 1) begin
				case(num[3:0])//每次只取低四位 每次右移四位
                4'h0:display_num[i]<=NUM0;
                4'h1:display_num[i]<=NUM1;
                4'h2:display_num[i]<=NUM2;
                4'h3:display_num[i]<=NUM3;
				4'h4:display_num[i]<=NUM4;
                4'h5:display_num[i]<=NUM5;
                4'h6:display_num[i]<=NUM6;
				4'h7:display_num[i]<=NUM7;
                4'h8:display_num[i]<=NUM8;
                4'h9:display_num[i]<=NUM9;
				4'hA:display_num[i]<=NUMA;
                4'hB:display_num[i]<=NUMB;
                4'hC:display_num[i]<=NUMC;
                4'hD:display_num[i]<=NUMD;
                4'hE:display_num[i]<=NUME;
                4'hF:display_num[i]<=NUMF;
				
                default:display_num[i]<=display_num[i];
				endcase
				num = num>>4;
			end
		end
		else //enable_signal=0 不写的时候 保持原状态
		display_num<=display_num;
	end
	always @ (posedge clk) begin
		if(rst)
			led_cx <= BLANK;
		else begin
			case(led_en) 
				8'b11111110 : led_cx <= display_num[0];//DK0
				8'b11111101 : led_cx <= display_num[1];//DK1 
				8'b11111011 : led_cx <= display_num[2];//DK2 
				8'b11110111 : led_cx <= display_num[3];//DK3 
				8'b11101111 : led_cx <= display_num[4];//DK4 
				8'b11011111 : led_cx <= display_num[5];//DK5 
				8'b10111111 : led_cx <= display_num[6];//DK6 
				8'b01111111 : led_cx <= display_num[7];//DK7 
				default led_cx <= BLANK;
			endcase
		end
	end
	
endmodule