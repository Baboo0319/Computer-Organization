// 定义时间单位和精度
`timescale 1ns / 1ps

// 定义PC模块
module PC(
    input wire CLK,       // 时钟信号
    input wire Reset,     // 复位信号
    input wire PCWre,     // PC写入使能信号
    input wire [1:0] PCSrc, // PC源选择信号
    input wire signed [15:0] Immediate, // 立即数扩展信号
    input wire [31:0] dataFromRs, // 来自$31号寄存器的PC地址值
    input wire [31:0] JumpPC, // 跳转地址
    output reg signed [31:0] Address, // 当前指令的PC地址值
    output reg [31:0] nextPC, // 下一条指令的PC地址值
    output wire [31:0] PC_add_4, // 用于提供给jal指令写入$31号寄存器的地址值
    output wire [3:0] PC4 // 下一条PC地址的前四位，用于构成JumpPC地址值
);

// 计算下一条PC地址
always @(*) begin
    if(PCSrc == 2'b11) // j,jal指令
        nextPC = JumpPC;
    else if(PCSrc == 2'b01) // beq,bne,bltz指令
        nextPC = Address + 4 + (Immediate << 2);
    else if(PCSrc == 2'b10) // jr指令
        nextPC = dataFromRs;
    else // 默认情况，顺序执行下一条指令
        nextPC = Address + 4;
end

// 计算PC+4的值，用于jal指令
assign PC_add_4 = Address + 4;

// 提取下一条PC地址的前四位
assign PC4 = Address[31:28];

// 在时钟上升沿或复位信号下降沿时更新PC地址
always @(posedge CLK or negedge Reset) begin
    if(Reset == 0) // 复位信号有效时，PC地址清零
        Address = 0;
    else if(PCWre) // 当PCWre为1时，允许更改地址
        if(PCSrc == 2'b11) // j,jal指令
            Address <= JumpPC;
        else if(PCSrc == 2'b01) // beq,bne,bltz指令
            Address <= Address + 4 + (Immediate << 2);
        else if(PCSrc == 2'b10) // jr指令
            Address <= dataFromRs;
        else // 默认情况，顺序执行下一条指令
            Address <= Address + 4;
end

endmodule