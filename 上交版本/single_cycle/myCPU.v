`timescale 1ns / 1ps

`include "defines.vh"

module myCPU (
    input  wire         cpu_rst,
    input  wire         cpu_clk,

    // Interface to IROM
    output wire [13:0]  inst_addr,	//ָ��ĵ�ַ��cpu�����IROM
    input  wire [31:0]  inst,		//ָ������ݣ�IROM��cpu������
    
    // Interface to Bridge       //������DRAM������������ܴ򽻵���
    output wire [31:0]  Bus_addr,	//����ĵ�ַ
    input  wire [31:0]  Bus_rdata,	//�������������
    output wire         Bus_wen,	//�����дʹ��
    output wire [31:0]  Bus_wdata	//Ҫ����д������

`ifdef RUN_TRACE
    ,// Debug Interface
    output wire         debug_wb_have_inst,
    output wire [31:0]  debug_wb_pc,
    output              debug_wb_ena,
    output wire [ 4:0]  debug_wb_reg,
    output wire [31:0]  debug_wb_value
`endif
);

    // TODO: ������Լ��ĵ�����CPU���
	
//IF�����ź� 
wire        br;
wire [31:0] pc4  ;
wire [31:0] pc   ;
wire [31:0] npc  ;
wire [31:0] offset ;

// signals ID & WB generates
wire [31:0] rd1;
wire [31:0] rd2;
wire [31:0] wd ;
wire [31:0] ext;

// signals EXE generates
wire [31:0] aluA;
wire [31:0] aluB;
wire  		aluf;
wire [31:0] aluC;

// signals MEM generates
wire [31:0] dram_rdo;

// control  8
wire npco_sel,rf_we, alub_sel, dram_we;
wire [1:0] npc_op ;//4
wire [1:0] rf_wesl ;//4
wire [2:0] sext_op;//5
wire [3:0] alu_op;//11

wire rst_n;
assign rst_n = ~cpu_rst;


//ȡָIF
if_npc NPC (
	.op     (npc_op	),
	.pc   	(pc		),
	.br 	(aluf	),
	.offset	(offset	),
	
	.npc    (npc   	),
	.pc4    (pc4   	)
	
);

assign offset = (npco_sel==`NPCO_ALU) ? aluC : ext;//��npco_sel=1��������ALU.C

if_pc PC (
	.clk	(cpu_clk),
	.rst_n	(rst_n	),
	.din	(npc	),
	
	.pc		(pc		)
);
	
assign inst_addr = pc[15:2];  //32bits-��14

//д��WB
wb_mux WB_MUX (
	.rf_wesl(rf_wesl),
	.aluC	(aluC),
	.dram_rdo(dram_rdo),
	.ext	(ext),
	.pc4	(pc4),
	.wd		(wd	)
);

//����ID

id_rf RF (
	.clk	(cpu_clk),
	.rst_n	(rst_n	),
	.rs1	(inst[19:15]),
	.rs2	(inst[24:20]),
	.wr		(inst[11:7]	),
	.WE		(rf_we		),
	.wd		(wd		),
	.rd1	(rd1	),
	.rd2	(rd2	)
);

id_sext SEXT (
	.op		(sext_op),
	.din	(inst[31:7]),
	.ext	(ext	)
);

//ִ��EX
assign aluA = rd1;
assign aluB = alub_sel ? ext : rd2;//0��rd2,1��ext
ex_alu ALU (
	.op	(alu_op	),
	.A	(aluA	),
	.B	(aluB	),
	.f	(aluf	),
	.C	(aluC	)
);

//�ô�MEM
    // Interface to Bridge       //������DRAM������������ܴ򽻵���
    // wire [31:0]  Bus_addr,	//����ĵ�ַ
    // wire [31:0]  Bus_rdata,	//�������������
    // wire         Bus_wen,	//�����дʹ��
    // wire [31:0]  Bus_wdata	//Ҫ����д������

assign Bus_addr=aluC;//lw sw
assign Bus_wen=dram_we;
assign Bus_wdata=rd2;
assign dram_rdo = Bus_rdata;


//control 
control CONTROLLER (
	.opcode	(inst[6:0]	),
	.funct3	(inst[14:12]),
	.funct7	(inst[31:25]),
	.npc_op	(npc_op		),
	.npco_sel(npco_sel	),
	.rf_we	(rf_we		),
	.rf_wesl(rf_wesl	),
	.sext_op(sext_op	),
	.alu_op	(alu_op		),
	.alub_sel(alub_sel	),
	.dram_we(dram_we	)

);

`ifdef RUN_TRACE
    // Debug Interface
    assign debug_wb_have_inst = 1;/* WB�׶���ָ�� ���ڵ�����CPU��Ϊ1 */
    assign debug_wb_pc        = pc;
    assign debug_wb_ena       = rf_we;
    assign debug_wb_reg       = inst[11:7];
    assign debug_wb_value     = wd;
`endif

endmodule
