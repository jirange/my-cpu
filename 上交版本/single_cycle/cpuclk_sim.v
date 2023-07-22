`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// ʱ��ģ�����
// 
// Create Date: 2023/06/30 11:08:01
// Module Name: cpuclk_sim
// ע�����
// ��cpuclk_sim�ļ�����Ϊ�����ļ����Ҽ����cpuclk_sim.v���ڵ����Ĳ˵���ѡ��Set as Top�Խ�������Ϊ�����ļ�
// ����PLL���໷��Ҫһ���ĳ�ʼ��ʱ�䣬��˷���ʱ����Ҫ���¿�ݼ�Shift+F2�Զ�����5us�����ܿ���cpu_clk�Ĳ��������
//////////////////////////////////////////////////////////////////////////////////


module cpuclk_sim();
    // input
    reg fpga_clk = 0;
    // output
    wire clk_lock;
    wire pll_clk;
    wire cpu_clk;

    always #5 fpga_clk = ~fpga_clk;

    cpuclk UCLK (
        .clk_in1    (fpga_clk),
        .locked     (clk_lock),
        .clk_out1   (pll_clk)
    );

    assign cpu_clk = pll_clk & clk_lock;

endmodule