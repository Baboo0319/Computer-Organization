// 设置时间尺度：1ns 的时间单位，1ps 的精度
`timescale 1ns / 1ps

module IM_sim;

// 定义输入信号为寄存器类型
reg [31:0] IAddr; // 指令地址输入
reg RW;           // 读写控制信号：0 表示写入，1 表示读取
reg [3:0] PC4;

// 定义输出信号为线网类型
wire [5:0] op;        // 操作码
wire [5:0] funct;
wire [4:0] rs, rt, rd;// 寄存器索引
wire [15:0] Immediate;// 立即数
wire [4:0] Sa;        // 移位量
wire [31:0] JumpPC;

// 实例化 InstructionMemory 模块，并连接端口
InstructionMemory uut (
    .IAddr(IAddr),    // 连接指令地址输入
    .RW(RW),          // 连接读写控制信号
    .PC4(PC4),
    .op(op),          // 连接操作码输出
    .funct(funct),
    .rs(rs),          // 连接源寄存器1输出
    .rt(rt),          // 连接源寄存器2或目标寄存器输出
    .rd(rd),          // 连接目标寄存器输出
    .Immediate(Immediate), // 连接立即数输出
    .Sa(Sa),           // 连接移位量输出
    .JumpPC(JumpPC)
);

initial begin
    // 设置波形记录文件
    $dumpfile("IM.vcd"); // 波形文件名
    $dumpvars(0, IM_sim); // 记录所有变量

    // 初始化
    #10; // 延迟10个时间单位
    PC4=4'd0;
    RW = 0; // 设置为写模式（尽管在这个测试中不会进行写操作）
    IAddr = 32'd0; // 将指令地址设置为0

    // 测试读取指令
    #50; // 延迟50个时间单位
    PC4=4'd0;
    RW = 1; // 设置为读模式
    IAddr = 32'd0; // 将指令地址设置为0，读取第一个指令

    // 测试读取第二个指令
    #50; // 再延迟50个时间单位
    PC4=4'd0;
    RW = 1; // 确保仍然处于读模式
    IAddr = 32'd4; // 将指令地址设置为4（下一个指令）

    // 测试读取第三个指令
    #50; // 再延迟50个时间单位
    PC4=4'd0;
    RW = 1; // 确保仍然处于读模式
    IAddr = 32'd8; // 将指令地址设置为8（再下一个指令）
    
    #50; // 再延迟50个时间单位
    PC4=4'd0;
    RW = 1; // 确保仍然处于读模式
    IAddr = 32'h00000048; // 将指令地址设置为h48（再下一个指令）

    // 结束仿真
    #50; // 最后延迟10个时间单位
    $stop; // 停止仿真
end

endmodule