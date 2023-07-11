`timescale 1ns / 1ps
//���� �Ĵ�����rf ��������չext ���Ƶ�Ԫcontroller
module idecode(
    input             clk   ,
    input             rst_n ,
	
	input      [31:0] inst,
	
    input      [31:0] wb_wd	,//wb_wd
    input      [4 :0] wb_wr	,//wb_wr
    input      		  wb_we	,//wb_we

    output reg [4 :0] rs1   ,//id_rs1 ð�ռ����
    output reg [4 :0] rs2   ,

    output     [31:0] rd1   ,
    output     [31:0] rd2   ,
    output     [31:0] aluB   ,
	
	output reg [31:0] ext   ,
	
    output reg [4 :0] id_wr_o   ,//д�ؼĴ������
	

	output reg  [1:0] npc_op	,
	output            npco_sel  ,
	output      	  id_rf_we	,//ID�׶ε� �Ĵ���дʹ��id_we
	output reg  [1:0] rf_wesl	,
	//output reg  [2:0] sext_op	,//����
	output reg  [3:0] alu_op	,
	//output            alub_sel	,//����
	output            dram_we    
	output            have_inst,    
	
);
assign have_inst = inst[6:0] != 0;//���׶�����ָ�����е� ��nop �ǵ�һ��ָ��տ�ʼ�Ŀհ�
//ֻ��Ϊ��trace�� wb��have_inst

reg	[2:0] sext_op;
reg	alub_sel;

assign aluB = alub_sel ? ext : rd2;//0��rd2,1��ext

assign rs1 = inst[19:15];
assign rs2 = inst[24:20];

assign id_wr_o = inst[11:7]	;

id_rf RF (
	.clk	(cpu_clk),
	.rst_n	(rst_n	),
	.rs1	(rs1),
	.rs2	(rs2),
	.wr		(wb_wr),
	.WE		(wb_we),
	.wd		(wb_wd),
	
	.rd1	(rd1	),
	.rd2	(rd2	)
);

id_sext SEXT (
	.op		(sext_op),
	.din	(inst[31:7]),
	.ext	(ext	)
);

//control 
control CONTROLLER (
	.opcode	(inst[6:0]	),
	.funct3	(inst[14:12]),
	.funct7	(inst[31:25]),
	.npc_op	(npc_op		),
	.npco_sel(npco_sel	),
	.rf_we	(id_rf_we	),
	.rf_wesl(rf_wesl	),
	.sext_op(sext_op	),
	.alu_op	(alu_op		),
	.alub_sel(alub_sel	),
	.dram_we(dram_we	)

);

endmodule
