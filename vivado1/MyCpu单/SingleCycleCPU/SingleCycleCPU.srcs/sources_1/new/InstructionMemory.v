`timescale 1ns / 1ps
module InstructionMemory(
    input [3:0] PC4, // 用于跳转指令的高4位PC值
    input [31:0] IAddr, // 指令地址输入
    input RW, // 读写控制信号：0 表示写入，1 表示读取

    output [5:0] op, // 操作码
    output [4:0] rs, // 源寄存器1
    output [4:0] rt, // 源寄存器2/目标寄存器
    output [4:0] rd, // 目标寄存器（仅适用于某些指令）
    output [5:0] func,
    output [15:0] Immediate, // 立即数
    output [4:0] Sa, // 移位量
    output [31:0] JumpPC, // 跳转地址
    output reg [31:0] IDataOut // 用于保存从内存读取的32位指令
);

// 因为实验要求指令存储器和数据存储器单元宽度一律使用8位，
// 因此将一个32位的指令拆成4个8位的存储器单元存储。
reg [7:0] Mem[0:127]; // 定义一个8位宽、128个地址空间的内存数组来存储指令

// 从文件中取出后将它们合并为32位的指令


// 将IDataOut中的相应位分配给输出端口
assign op = IDataOut[31:26]; // 提取操作码 (6位)
assign func = (IDataOut[31:26] == 6'b000000 ) ? IDataOut[5:0] : 6'bxxxxxx;
assign rs = IDataOut[25:21]; // 提取源寄存器1 (5位)
assign rt = IDataOut[20:16]; // 提取源寄存器2或目标寄存器 (5位)
assign rd = IDataOut[15:11]; // 提取目标寄存器 (5位)
assign Immediate = IDataOut[15:0]; // 提取立即数 (16位)
assign Sa = IDataOut[10:6]; // 提取移位量 (5位)

// 构建跳转地址，由PC4和指令的一部分组成，并在末尾添加两个零以确保是字对齐的
assign JumpPC = {PC4, IDataOut[27:2], 2'b00};

initial begin
    $readmemb("C:/Users/Bamboo/Desktop/vivado1/MyCpu/Instruction.txt", Mem); // 在仿真开始时从文件 "Instructions.txt" 中加载指令集到内存
    IDataOut = 0; // 初始化指令数据为0
end

// 当IAddr或RW发生变化时触发
always @(IAddr or RW) begin
    if(RW == 1) begin // 如果是读操作
        // 根据IAddr从内存中读取4个连续的8位数据并组合成32位指令
        IDataOut[7:0]  = Mem[IAddr + 3];
        IDataOut[15:8] = Mem[IAddr + 2];
        IDataOut[23:16] = Mem[IAddr + 1];
        IDataOut[31:24] = Mem[IAddr];
    end
end

endmodule
