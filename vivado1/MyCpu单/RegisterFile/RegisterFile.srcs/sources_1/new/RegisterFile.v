`timescale 1ns / 1ps
module RegisterFile(
    input CLK,                   // 时钟信号
    input RegDst,                // 寄存器目标选择信号：为1时选择rd，为0时选择rt
    input RegWre,                // 寄存器写使能信号：为1时允许写入寄存器
    input DBDataSrc,             // 数据源选择信号：为1时从数据存储器读取，为0时从ALU读取

    // input [5:0] Opcode,        // 指令操作码（注释掉）
    input [4:0] rs,              // 源寄存器1编号
    input [4:0] rt,              // 源寄存器2编号
    input [4:0] rd,              // 目标寄存器编号

    // input [10:0] im,           // 立即数（注释掉）

    input [31:0] dataFromALU,    // 来自ALU的数据
    input [31:0] dataFromRW,     // 来自数据存储器或其它源的数据

    output [31:0] Data1,         // ALU运算的第一个输入A
    output [31:0] Data2,         // ALU运算的第二个输入B
    output [31:0] writeData      // 写入寄存器的数据
);

// 要写的寄存器端口
wire [4:0] writeReg;

// 根据 RegDst 选择要写入的目标寄存器
// RegDst 为真时，处理R型指令，使用 rd 作为目标寄存器；为假时，处理I型指令，使用 rt 作为目标寄存器
assign writeReg = RegDst ? rd : rt;

// 根据 DBDataSrc 选择写入寄存器的数据来源
// DBDataSrc 为0时，使用来自ALU的输出；为1时，使用来自数据存储器的输出
assign writeData = DBDataSrc ? dataFromRW : dataFromALU;

// 初始化寄存器数组，共32个32位寄存器
reg [31:0] register[0:31];
integer i;
initial begin
    for(i = 0; i < 32; i = i + 1) 
        register[i] <= 0; // 所有寄存器初始值设为0
end

// 输出 Data1 和 Data2 随寄存器变化而变化
// Data1 为 ALU 运算时的第一个输入 A，其值始终为 rs 寄存器的内容
// Data2 为 ALU 运算时的第二个输入 B，其值始终为 rt 寄存器的内容
// 注意：原始代码中关于 Opcode 的条件已经注释掉了，这里不再考虑 sll 指令的情况
assign Data1 = register[rs];
assign Data2 = register[rt];

// 在时钟下降沿触发，更新寄存器内容
always @ (negedge CLK) begin
    if(RegWre && writeReg != 0) // 只有在 RegWre 为高电平且不是写入0号寄存器时才允许写入
        register[writeReg] <= writeData;
end

endmodule