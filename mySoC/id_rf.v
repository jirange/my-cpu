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

reg [31:0] regfile [31:0];//寄存器堆

integer i;

//写寄存器堆
always @(posedge clk or negedge rst_n) begin

//    if (~rst_n) begin//硬件是不需要初始化的
//        for (i = 0; i <= 31; i = i + 1) begin
//            regfile[i] <= 32'b0;//复位则寄存器堆清0
//        end
//	end else 
	begin
		if(WE && wr!=5'b00000) 	regfile[wr] <= wd;
        else	regfile[wr] <= regfile[wr];
    end
	
	regfile[0] <= 0;  //x0始终为0 即便写进去了 也要是0
end

//读寄存器堆
assign rd1 = regfile[rs1];
assign rd2 = regfile[rs2];

endmodule
