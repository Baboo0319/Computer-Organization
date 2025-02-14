`timescale 1ns / 1ps

// 定义指令存储器模块
module InstructionMemory(
    input [31:0] IAddr, // 指令地址输入
    input RW, // 读写控制信号，0表示写，1表示读
    output reg [31:0] IDataOut // 指令数据输出
);

// 因为实验要求指令存储器和数据存储器单元宽度一律使用8位，
// 所以将一个32位的指令拆成4个8位的存储器单元存储
// 从文件中取出后将它们合并为32位的指令
reg [7:0] Mem[0:127]; // 定义一个包含128个8位存储单元的存储器

// 初始化块，在仿真开始时执行
initial begin
    // 从文件中读取指令集，注意替换为你的Instructions.txt文件的正确路径
    $readmemb("C:/Users/Bamboo/Desktop/vivado1/MyCpu1/MultiCycleCPU/Instructions.txt", Mem);
    IDataOut = 0; // 初始化指令数据输出为0
end

// 总是监视IAddr或RW的变化
always @(IAddr or RW) begin
    if(RW == 1) begin // 当RW为1，即读操作时
        // 将4个连续的8位存储器单元合并为一个32位的指令
        IDataOut[7:0] = Mem[IAddr + 3];
        IDataOut[15:8] = Mem[IAddr + 2];
        IDataOut[23:16] = Mem[IAddr + 1];
        IDataOut[31:24] = Mem[IAddr];
    end
end

endmodule