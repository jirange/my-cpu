`timescale 1ns / 1ps

module reg_ex_mem(
    input             clk       ,
    input             rst_n     ,
//没有flush了 因为分支检测引起的nop 后面根本还没运行到
//为什么没有stop
    input      [31:0] ex_rd2   ,
    input      [1 :0] ex_rf_wesl ,
    input      [31:0] ex_pc4   ,
    input      [31:0] ex_aluC  ,
    input             ex_dram_we,
	
	input      [4 :0] ex_wr     ,	//写回寄存器的编号
    input             ex_we 	,	//寄存器写使能

    output reg [31:0] mem_rd2   ,
    output reg [1 :0] mem_rf_wesl ,
    output reg [31:0] mem_pc4   ,
    output reg [31:0] mem_aluC  ,
    output reg        mem_dram_we,
	
    output reg [4 :0] mem_wr     ,	//写回寄存器的编号
    output reg        mem_we		//寄存器写使能

    //input             ex_is_inst ,
    //output reg        mem_is_inst
);

/*always @(posedge clk or negedge rst_n) begin
    if (~rst_n) mem_is_inst <= 'b0      ;
    else        mem_is_inst <= ex_is_inst;
end
*/
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) 	mem_rd2 <= 'b0      ;
    else          	mem_rd2 <= ex_rd2;
end

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) 	mem_rf_wesl <= 'b0        ;
    else          	mem_rf_wesl <= ex_rf_wesl;
end

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) 	mem_pc4 <= 'b0      ;
    else          	mem_pc4 <= ex_pc4;
end

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) 	mem_aluC <= 'b0       ;
    else          	mem_aluC <= ex_aluC;
end

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) 	mem_dram_we <= 'b0         ;
    else          	mem_dram_we <= ex_dram_we;
end

//为了冒险检测
always @(posedge clk or negedge rst_n) begin
    if (~rst_n)    mem_wr <= 'b0    ;
    else           mem_wr <= ex_wr;
end

always @(posedge clk or negedge rst_n) begin
    if (~rst_n)    mem_we <= 'b0        ;
    else           mem_we <= ex_we;
end


endmodule
