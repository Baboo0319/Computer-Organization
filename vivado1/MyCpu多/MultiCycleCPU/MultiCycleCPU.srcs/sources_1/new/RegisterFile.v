`timescale 1ns / 1ps

// 定义寄存器文件模块
module RegisterFile(
    input CLK, // 时钟信号
    input WrRegDSrc, // 写入寄存器数据源选择信号
    input [31:0] PC_add_4, // 当前PC地址加4的值
    input [1:0] RegDst, // 写入寄存器目标选择信号
    input RegWre, // 寄存器写入使能信号
    input [4:0] rs, rt, rd, // 读取和写入寄存器的地址
    input [31:0] drDB, // 写入寄存器的数据
    output reg [31:0] Data1, Data2, // 从寄存器读取的数据
    output [31:0] writeData // 写入寄存器的数据
);

    // 定义要写入的寄存器端口
    reg [4:0] writeReg;

    // 根据RegDst选择要写入的寄存器
    always @(*) begin
        case (RegDst)
            2'b01: writeReg = rt; // 写入rt寄存器
            2'b10: writeReg = rd; // 写入rd寄存器
            2'b00: writeReg = 5'b11111; // jal指令写入$31寄存器
            default: writeReg = 5'b00000; // 默认不写入
        endcase
    end

    // 根据WrRegDSrc选择写入寄存器的数据源
    assign writeData = WrRegDSrc ? drDB : PC_add_4;

    // 初始化32个32位寄存器
    reg [31:0] register[0:31];
    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1) 
            register[i] = 32'b0; // 使用阻塞赋值初始化寄存器为0
    end

    // 输出：根据寄存器地址读取数据
    always @(*) begin
        Data1 = register[rs]; // 读取rs寄存器的数据
        Data2 = register[rt]; // 读取rt寄存器的数据
    end

    // 写入寄存器
    always @(CLK) begin
        if (CLK==0 && RegWre && (writeReg != 5'b00000)&&(writeReg!=5'b11111)) // 避免写入寄存器0
            register[writeReg] <= writeData; // 写入非$0和非$31的寄存器
        else if(CLK==1 && RegWre && WrRegDSrc==0 && (writeReg != 5'b00000)) // jal指令时写入$31寄存器
            register[writeReg] <= writeData;
    end
 
endmodule