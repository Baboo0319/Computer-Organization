`timescale 1ns / 1ps

module PC(
    input CLK, // 时钟信号
    input Reset, // 复位信号：当为低电平时将PC置零
    input PCWre, // 写使能信号：为高电平时允许更新PC值
    input [1:0] PCSrc, // 程序计数器源选择信号
    input signed [15:0] Immediate, // 立即数
    input [31:0] JumpPC, // 跳转目标地址

    output reg signed [31:0] Address, // 当前的PC值
    output [31:0] nextPC, // 下一个PC值
    output [3:0] PC4 // 当前PC值的高4位
);

// 计算下一个PC值
// 如果PCSrc[0]为1，则执行相对跳转：Address + 4 + (Immediate << 2)
// 如果PCSrc[1]为1，则执行绝对跳转：JumpPC
// 否则顺序执行下一条指令：Address + 4
assign nextPC = (PCSrc[0]) ? Address + 4 + (Immediate << 2) : ((PCSrc[1]) ? JumpPC : Address + 4);

// 提取当前PC值的高4位
assign PC4 = Address[31:28];

// 在CLK上升沿或Reset的下降沿触发
always @(posedge CLK or negedge Reset) begin
    if(Reset == 0) begin
        // 如果Reset为低电平，将PC置零
        Address = 0;
    end else if(PCWre) begin // 只有在PCWre为高电平时才允许更改PC值
        if(PCSrc[0]) begin
            // 如果PCSrc[0]为1，执行相对跳转
            Address = Address + 4 + (Immediate << 2);
        end else if(PCSrc[1]) begin
            // 如果PCSrc[1]为1，执行绝对跳转
            Address = JumpPC;
        end else begin
            // 否则，顺序执行下一条指令
            Address = Address + 4;
        end
    end
end

endmodule