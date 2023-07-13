`timescale 1ns / 1ps
`include "defines.vh"

module id_sext(
    input      [2 :0] op,
    input      [31:7] din  ,

    output reg [31:0] ext
);

//SEXT�Ƿ�����չ����
//���룺ָ���е������� (12bit��20bit) din
//�����������չ֮��������� (32bit)  ext
always @(*) begin
    case (op)
        `EXT_I:ext = {{20{din[31]}}, din[31:20]};//��20λΪ����λ���ظ�ƴ��  20Ҫ��������
		`EXT_S:ext = {{20{din[31]}}, din[31:25], din[11:7]};
		`EXT_B:ext = {{19{din[31]}}, din[31], din[7], din[30:25], din[11:8], 1'b0};//��0�������Ϳ���ֱ��pc+offset��
		`EXT_U:ext = {din[31:12], 12'b0};//lui ��յ�12λ��װ���20λ
		`EXT_J:ext = {{11{din[31]}}, din[31], din[19:12], din[20], din[30:21], 1'b0};
        default:    ext = 32'b0;
    endcase
end

endmodule
