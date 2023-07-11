`timescale 1ns / 1ps

module reg_mem_wb(
    input             clk	,
    input             rst_n	,
	//为什么没有stop
	input      		  mem_we	,
	input      [31:0] mem_wd	,
	input      [4:0]  mem_wr	,
	
	output     		  wb_we	,
	output reg [31:0] wb_wd	,
	output reg [4:0]  wb_wr	
    /*input             mem_is_inst ,
    output reg        wb_is_inst*/
);

/*always @(posedge clk or negedge rst_n) begin
    if (~rst_n) wb_is_inst <= 'b0         ;
    else          wb_is_inst <= mem_is_inst;
end*/


always @(posedge clk or negedge rst_n) begin
    if (~rst_n) wb_we <= 'b0    ;
    else        wb_we <= mem_we	;
end
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) wb_wd <= 'b0    ;
    else        wb_wd <= mem_wd	;
end
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) wb_wr <= 'b0    ;
    else        wb_wr <= mem_wr	;
end
endmodule
