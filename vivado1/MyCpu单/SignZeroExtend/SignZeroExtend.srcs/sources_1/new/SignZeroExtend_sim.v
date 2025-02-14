`timescale 1ns / 1ps
`include "SignZeroExtend.v"  // 包含 SignZeroExtend 模块的定义文件

module SignZeroExtend_sim();

    // 定义输入信号为寄存器类型
    reg signed [15:0] Immediate;  // 输入的16位立即数，带符号
    reg ExtSel;                   // 扩展选择信号：1为符号扩展，0为零扩展

    // 定义输出信号为线网类型
    wire [31:0] Out;              // 输出的32位扩展后的数据

    // 实例化 SignZeroExtend 模块，并连接端口
    SignZeroExtend uut (
        .Immediate(Immediate),
        .ExtSel(ExtSel),
        .Out(Out)
    );

initial begin
    // 设置波形记录文件
    $dumpfile("SignZeroExtend.vcd");
    $dumpvars(0, SignZeroExtend_sim);

    // 初始化
    ExtSel = 0;
    Immediate = 16'd0;

    // 提供一个完整的时钟周期以确保初始化完成
    #50;

    // Test1: 零扩展
    ExtSel = 0;
    Immediate = 16'd7;
    #50;

    // Test2: 正数的符号扩展
    ExtSel = 1;
    Immediate = 16'd10;
    #50;

    // Test3: 负数的符号扩展
    ExtSel = 1;
    Immediate = -16'd7;
    #50;

    // 结束仿真
    #50;
    $stop;
end

endmodule
