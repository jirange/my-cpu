`timescale 1ns / 1ps

module reg_id_exe(
    input             clk       ,
    input             rst_n     ,

    input             flush     ,
	
    input      [31:0] id_pc     ,
	
    input             id_npco_sel,
    input      [1 :0] id_rf_wesl,
    input      [3 :0] id_alu_op ,
    input             id_dram_we,
    input      [1 :0] id_npc_op ,
	
    input      [31:0] id_ext    ,
    input      [31:0] id_aluA   ,
    input      [31:0] id_aluB   ,
    input      [31:0] id_rd2    ,
	
    input      [4 :0] id_wr     ,	//写回寄存器的编号
    input             id_we 	,	//寄存器写使能
	
    output reg        exe_npco_sel,
    output reg [1 :0] exe_rf_wesl,
    output reg [3 :0] exe_alu_op ,
    output reg        exe_dram_we,
    output reg [1 :0] exe_npc_op ,
	
    output reg [31:0] exe_ext    ,
    output reg [31:0] exe_aluA   ,
    output reg [31:0] exe_aluB   ,
    output reg [31:0] exe_rd2    
	
    output reg [4 :0] exe_wr     ,	//写回寄存器的编号
    output reg        exe_we		//寄存器写使能

    //input             id_is_inst  ,//大概是没用？？？
    //output reg        exe_is_inst//大概是没用？？？
);
always @(posedge clk or negedge rst_n) begin
    if (~rst_n)     exe_pc <= 'b0    	;
    else if (flush) exe_pc <= 'b0    	;
	else if (stop) 	exe_pc <= exe_pc	;
    else            exe_pc <= id_pc		;
end
always @(posedge clk or negedge rst_n) begin
    if (~rst_n)     exe_npco_sel <= 'b0    	;
    else if (flush) exe_npco_sel <= 'b0    	;
	else if (stop) 	exe_npco_sel <= exe_npco_sel	;
    else            exe_npco_sel <= id_npco_sel	;
end
always @(posedge clk or negedge rst_n) begin
    if (~rst_n)     exe_rf_wesl <= 'b0    		;
    else if (flush) exe_rf_wesl <= 'b0    		;
	else if (stop) 	exe_rf_wesl <= exe_rf_wesl	;
    else            exe_rf_wesl <= id_rf_wesl	;
end
always @(posedge clk or negedge rst_n) begin
    if (~rst_n)     exe_alu_op <= 'b0    	;
    else if (flush) exe_alu_op <= 'b0    	;
	else if (stop) 	exe_alu_op <= exe_alu_op	;
    else            exe_alu_op <= id_alu_op	;
end
always @(posedge clk or negedge rst_n) begin
    if (~rst_n)     exe_npc_op <= 'b0    	;
    else if (flush) exe_npc_op <= 'b0    	;
	else if (stop) 	exe_npc_op <= exe_npc_op;
    else            exe_npc_op <= id_npc_op	;
end


always @(posedge clk or negedge rst_n) begin
    if (~rst_n)     exe_ext <= 'b0    	;
    else if (flush) exe_ext <= 'b0    	;
	else if (stop) 	exe_ext <= exe_ext;
    else            exe_ext <= id_ext	;
end
always @(posedge clk or negedge rst_n) begin
    if (~rst_n)     exe_aluA <= 'b0    ;
    else if (flush) exe_aluA <= 'b0    ;
	else if (stop) 	exe_aluA <= exe_aluA;
    else            exe_aluA <= id_aluA;
end
always @(posedge clk or negedge rst_n) begin
    if (~rst_n)     exe_aluB <= 'b0		;
    else if (flush) exe_aluB <= 'b0		;
	else if (stop) 	exe_aluB <= exe_aluB;
    else            exe_aluB <= id_aluB	;
end
always @(posedge clk or negedge rst_n) begin
    if (~rst_n)     exe_rd2 <= 'b0		;
    else if (flush) exe_rd2 <= 'b0		;
	else if (stop)  exe_rd2 <= exe_rd2;
    else            exe_rd2 <= id_rd2	;
end

//为了冒险检测
always @(posedge clk or negedge rst_n) begin
    if (~rst_n)     exe_wr <= 'b0    ;
    else if (flush) exe_wr <= 'b0    ;
	else if (stop)  exe_wr <= exe_wr;
    else            exe_wr <= id_wr;
end

always @(posedge clk or negedge rst_n) begin
    if (~rst_n)     exe_we <= 'b0        ;
    else if (flush) exe_we <= 'b0        ;
	else if (stop)  exe_we <= exe_we;
    else            exe_we <= id_we;
end
/*always @(posedge clk or negedge rst_n) begin
    if (~rst_n)    exe_is_inst <= 'b0       ;
    else if (flush)exe_is_inst <= 'b0       ;
    else             exe_is_inst <= id_is_inst;
end*/
//为什么这个停顿的时候也要变成0 呢 是不是要改
/*always @(posedge clk or negedge rst_n) begin
    if (~rst_n)     exe_pc <= 'b0    	;
    else if (flush) exe_pc <= 'b0    	;
    else            exe_pc <= id_pc		;
end
always @(posedge clk or negedge rst_n) begin
    if (~rst_n)     exe_npco_sel <= 'b0    	;
    else if (flush) exe_npco_sel <= 'b0    	;
    else            exe_npco_sel <= id_npco_sel	;
end
always @(posedge clk or negedge rst_n) begin
    if (~rst_n)     exe_rf_wesl <= 'b0    		;
    else if (flush) exe_rf_wesl <= 'b0    		;
    else            exe_rf_wesl <= id_rf_wesl	;
end
always @(posedge clk or negedge rst_n) begin
    if (~rst_n)     exe_alu_op <= 'b0    	;
    else if (flush) exe_alu_op <= 'b0    	;
    else            exe_alu_op <= id_alu_op	;
end
always @(posedge clk or negedge rst_n) begin
    if (~rst_n)     exe_npc_op <= 'b0    	;
    else if (flush) exe_npc_op <= 'b0    	;
    else            exe_npc_op <= id_npc_op	;
end


always @(posedge clk or negedge rst_n) begin
    if (~rst_n)     exe_ext <= 'b0    	;
    else if (flush) exe_ext <= 'b0    	;
    else            exe_ext <= id_ext	;
end
always @(posedge clk or negedge rst_n) begin
    if (~rst_n)     exe_aluA <= 'b0    ;
    else if (flush) exe_aluA <= 'b0    ;
    else            exe_aluA <= id_aluA;
end
always @(posedge clk or negedge rst_n) begin
    if (~rst_n)     exe_aluB <= 'b0		;
    else if (flush) exe_aluB <= 'b0		;
    else            exe_aluB <= id_aluB	;
end
always @(posedge clk or negedge rst_n) begin
    if (~rst_n)    exe_rd2 <= 'b0		;
    else if (flush)exe_rd2 <= 'b0		;
    else           exe_rd2 <= id_rd2	;
end

//为了冒险检测
always @(posedge clk or negedge rst_n) begin
    if (~rst_n)    exe_wr <= 'b0    ;
    else if (flush)exe_wr <= 'b0    ;
    else           exe_wr <= id_wr;
end

always @(posedge clk or negedge rst_n) begin
    if (~rst_n)    exe_we <= 'b0        ;
    else if (flush)exe_we <= 'b0        ;
    else           exe_we <= id_we;
end
*/

endmodule
