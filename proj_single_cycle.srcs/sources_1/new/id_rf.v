`timescale 1ns / 1ps

module id_rf(
    input             clk   ,
    input             rst_n ,
    input      [4 :0] rs1   ,
    input      [4 :0] rs2   ,
    input      [4 :0] wr    ,
    input             WE,//rf_we
    input      [31:0] wd,//rf_we

    output     [31:0] rd1   ,
    output     [31:0] rd2
);

reg [31:0] regfile [31:0];//�Ĵ�����

integer i;

//д�Ĵ�����
always @(posedge clk ) begin
	begin
		if(WE && wr!=5'b00000) 	regfile[wr] <= wd;
        else	regfile[wr] <= regfile[wr];
    end
	
	regfile[0] <= 0;  //x0ʼ��Ϊ0 ����д��ȥ�� ҲҪ��0
end

//���Ĵ�����
assign rd1 = regfile[rs1];
assign rd2 = regfile[rs2];

endmodule
