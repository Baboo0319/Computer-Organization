`timescale 1ns / 1ps

module SingleCycleCPU_sim();

    // 定义输入信号为寄存器类型
    reg CLK;                       // 时钟信号
    reg Reset;                     // 复位信号

    // 定义输出信号为线网类型
    wire [31:0] Out1;              // 寄存器文件的第一个输出
    wire [31:0] Out2;              // 寄存器文件的第二个输出
    wire [31:0] curPC;             // 当前程序计数器值
    wire [31:0] Result;            // ALU 的结果输出
    wire [5:0] Opcode;             // 操作码

    // 实例化被测单元 (Unit Under Test, UUT)
    SingleCycleCPU uut (
        .CLK(CLK),                 // 连接时钟信号
        .Reset(Reset),             // 连接复位信号
        .Opcode(Opcode),           // 输出操作码
        .Out1(Out1),               // 输出寄存器文件的第一个输出
        .Out2(Out2),               // 输出寄存器文件的第二个输出
        .curPC(curPC),             // 输出当前程序计数器值
        .Result(Result)            // 输出 ALU 结果
    );

    initial begin 
        // 设置波形记录文件
        $dumpfile("SCCPU.vcd");    // 波形文件名
        $dumpvars(0, SingleCycleCPU_sim);  // 记录所有变量

        // 初始化输入信号
        CLK = 0;                   // 初始时钟信号为低电平
        Reset = 0;                 // 初始复位信号为低电平（非复位状态）

        #50;
        CLK = 1;                   // 第一个时钟周期上升沿

        #50;
        Reset = 1;                 // 设置复位信号为高电平，触发复位

        // 产生时钟信号
        forever begin
            #50 CLK = !CLK;        // 每隔50时间单位翻转一次时钟信号
        end
    end

endmodule
