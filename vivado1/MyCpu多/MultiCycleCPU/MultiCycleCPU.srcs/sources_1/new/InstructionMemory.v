`timescale 1ns / 1ps

// ����ָ��洢��ģ��
module InstructionMemory(
    input [31:0] IAddr, // ָ���ַ����
    input RW, // ��д�����źţ�0��ʾд��1��ʾ��
    output reg [31:0] IDataOut // ָ���������
);

// ��Ϊʵ��Ҫ��ָ��洢�������ݴ洢����Ԫ���һ��ʹ��8λ��
// ���Խ�һ��32λ��ָ����4��8λ�Ĵ洢����Ԫ�洢
// ���ļ���ȡ�������Ǻϲ�Ϊ32λ��ָ��
reg [7:0] Mem[0:127]; // ����һ������128��8λ�洢��Ԫ�Ĵ洢��

// ��ʼ���飬�ڷ��濪ʼʱִ��
initial begin
    // ���ļ��ж�ȡָ���ע���滻Ϊ���Instructions.txt�ļ�����ȷ·��
    $readmemb("C:/Users/Bamboo/Desktop/vivado1/MyCpu1/MultiCycleCPU/Instructions.txt", Mem);
    IDataOut = 0; // ��ʼ��ָ���������Ϊ0
end

// ���Ǽ���IAddr��RW�ı仯
always @(IAddr or RW) begin
    if(RW == 1) begin // ��RWΪ1����������ʱ
        // ��4��������8λ�洢����Ԫ�ϲ�Ϊһ��32λ��ָ��
        IDataOut[7:0] = Mem[IAddr + 3];
        IDataOut[15:8] = Mem[IAddr + 2];
        IDataOut[23:16] = Mem[IAddr + 1];
        IDataOut[31:24] = Mem[IAddr];
    end
end

endmodule