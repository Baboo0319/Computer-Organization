`timescale 1ns / 1ps
module SignZeroExtend(
    // 根据数据通路定义输入和输出
    input wire [15:0] Immediate,  // 输入的16位立即数
    input ExtSel,                // 扩展选择信号：1为符号扩展，0为零扩展
    output wire [31:0] Out       // 输出的32位扩展后的数据
);

// 后16位存储立即数
// 直接将输入的16位立即数赋值给输出的低16位
assign Out[15:0] = Immediate[15:0];

// 前16位根据立即数进行补1或补0的操作
// 如果 ExtSel 为1，则进行符号扩展：将 Immediate 的最高位（第15位）复制到高16位
// 如果 ExtSel 为0，则进行零扩展：将高16位全部设为0
assign Out[31:16] = ExtSel == 1 ? {16{Immediate[15]}} : 16'b0;

endmodule

