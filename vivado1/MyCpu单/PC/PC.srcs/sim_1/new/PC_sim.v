`timescale 1ns / 1ps

module PC_sim();

    // 定义输入信号为寄存器类型
    reg CLK;                     // 时钟信号
    reg Reset;                   // 复位信号
    reg PCWre;                   // 写使能信号
    reg [1:0] PCSrc;             // 程序计数器源选择信号，2位
    reg signed [15:0] Immediate;  // 符号扩展的立即数
    reg [31:0] JumpPC;           // 添加缺失的JumpPC信号

    // 定义输出信号为线网类型
    wire [31:0] Address;         // 当前的PC值

    // 实例化 PC 模块，并连接端口
    PC uut (
        .CLK(CLK),
        .Reset(Reset),
        .PCWre(PCWre),
        .PCSrc(PCSrc),           // 2位信号
        .Immediate(Immediate),
        .JumpPC(JumpPC),         // 连接JumpPC信号
        .Address(Address)
    );

    // 生成时钟信号，每15个时间单位翻转一次
    always #7.5 CLK = !CLK;      // 使用更精确的时间单位（半个周期为7.5ns）

    initial begin
        // 设置波形记录文件
        $dumpfile("PC.vcd"); // 波形文件名
        $dumpvars(0, PC_sim); // 记录所有变量

        // 初始化
        CLK = 0;
        Reset = 0;
        PCWre = 0;
        PCSrc = 2'b00;          // 初始化为顺序执行
        Immediate = 0;
        JumpPC = 32'h0000_0000; // 初始化JumpPC为0

        // 不跳转，顺序执行下一条地址
        #100;                   // 延迟100个时间单位
        Reset = 1;              // 取消复位
        PCWre = 1;              // 允许更新PC值
        PCSrc = 2'b00;          // 顺序执行
        Immediate = 4;          // 设置立即数


        // 跳转，执行跳转之后的指令
        #100;
        PCSrc = 2'b01;          // 相对跳转
        Immediate = 4;


        // 绝对跳转，执行跳转之后的指令
        #100;
        PCSrc = 2'b10;          // 绝对跳转
        JumpPC = 32'h0000_1000; // 设置跳转地址

        // 结束仿真
        #100;
        $stop;                  // 停止仿真
    end

endmodule