`timescale 1ns / 1ps

module ControlUnit(
    // 根据数据通路图定义输入和输出
    input [5:0] OpCode,
    input [5:0] func,
    input zero,
    input sign,

    output PCWire,
    output ALUSrcA,
    output ALUSrcB,
    output DBDataSrc,
    output RegWire,
    output InsMemRW,
    output RD,
    output WR,
    output ExtSel,
    output RegDst,
    output [1:0] PCSrc,
    output [2:0] ALUOp
);

// 根据opcode定义控制信号为1或0
assign PCWire = (OpCode == 6'b111111) ? 0 : 1;
assign ALUSrcA = (OpCode == 6'b000000 && func == 6'b000000) ? 1 : 0;
assign ALUSrcB = (OpCode == 6'b001001 || OpCode == 6'b001100 || OpCode == 6'b001101 || OpCode == 6'b001010 || OpCode == 6'b101011 || OpCode == 6'b100011) ? 1 : 0;
assign DBDataSrc = (OpCode == 6'b100011) ? 1 : 0;
assign RegWire = (OpCode == 6'b101011 || OpCode == 6'b000100 || OpCode == 6'b000101 || OpCode == 6'b000110 || OpCode == 6'b000010) ? 0 : 1;
assign InsMemRW = 1;
assign RD = (OpCode == 6'b100011) ? 0 : 1;
assign WR = (OpCode == 6'b101011) ? 1 : 0;
assign ExtSel = (OpCode == 6'b001100 || OpCode == 6'b001101) ? 0 : 1;
assign RegDst = (OpCode == 6'b001001 || OpCode == 6'b001100 || OpCode == 6'b001101 || OpCode == 6'b001010 || OpCode == 6'b100011) ? 0 : 1;
assign PCSrc[0] = ((OpCode == 6'b000100 && zero == 1) || (OpCode == 6'b000101 && zero == 0) || (OpCode == 6'b000110 && sign == 1)) ? 1 : 0;
assign PCSrc[1] = (OpCode == 6'b000010) ? 1 : 0;
assign ALUOp[2] = (OpCode == 6'b001100 || (OpCode == 6'b000000 && func == 6'b100100) || OpCode == 6'b001010) ? 1 : 0;
assign ALUOp[1] = (OpCode == 6'b001101 || OpCode == 6'b001010 || (OpCode == 6'b000000 && func == 6'b100101) || (OpCode == 6'b000000 && func == 6'b000000)) ? 1 : 0;
assign ALUOp[0] = ((OpCode == 6'b000000 && func == 6'b100010) || OpCode == 6'b001101 || (OpCode == 6'b000000 && func == 6'b100101) || OpCode == 6'b000100 || OpCode == 6'b000101 || OpCode == 6'b000110) ? 1 : 0;

endmodule