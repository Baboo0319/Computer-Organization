`timescale 1ns / 1ps
module InstructionMemory(
    input [3:0] PC4, // ������תָ��ĸ�4λPCֵ
    input [31:0] IAddr, // ָ���ַ����
    input RW, // ��д�����źţ�0 ��ʾд�룬1 ��ʾ��ȡ

    output [5:0] op, // ������
    output [4:0] rs, // Դ�Ĵ���1
    output [4:0] rt, // Դ�Ĵ���2/Ŀ��Ĵ���
    output [4:0] rd, // Ŀ��Ĵ�������������ĳЩָ�
    output [5:0] func,
    output [15:0] Immediate, // ������
    output [4:0] Sa, // ��λ��
    output [31:0] JumpPC, // ��ת��ַ
    output reg [31:0] IDataOut // ���ڱ�����ڴ��ȡ��32λָ��
);

// ��Ϊʵ��Ҫ��ָ��洢�������ݴ洢����Ԫ���һ��ʹ��8λ��
// ��˽�һ��32λ��ָ����4��8λ�Ĵ洢����Ԫ�洢��
reg [7:0] Mem[0:127]; // ����һ��8λ��128����ַ�ռ���ڴ��������洢ָ��

// ���ļ���ȡ�������Ǻϲ�Ϊ32λ��ָ��


// ��IDataOut�е���Ӧλ���������˿�
assign op = IDataOut[31:26]; // ��ȡ������ (6λ)
assign func = (IDataOut[31:26] == 6'b000000 ) ? IDataOut[5:0] : 6'bxxxxxx;
assign rs = IDataOut[25:21]; // ��ȡԴ�Ĵ���1 (5λ)
assign rt = IDataOut[20:16]; // ��ȡԴ�Ĵ���2��Ŀ��Ĵ��� (5λ)
assign rd = IDataOut[15:11]; // ��ȡĿ��Ĵ��� (5λ)
assign Immediate = IDataOut[15:0]; // ��ȡ������ (16λ)
assign Sa = IDataOut[10:6]; // ��ȡ��λ�� (5λ)

// ������ת��ַ����PC4��ָ���һ������ɣ�����ĩβ�����������ȷ�����ֶ����
assign JumpPC = {PC4, IDataOut[27:2], 2'b00};

initial begin
    $readmemb("C:/Users/Bamboo/Desktop/vivado1/MyCpu/Instruction.txt", Mem); // �ڷ��濪ʼʱ���ļ� "Instructions.txt" �м���ָ����ڴ�
    IDataOut = 0; // ��ʼ��ָ������Ϊ0
end

// ��IAddr��RW�����仯ʱ����
always @(IAddr or RW) begin
    if(RW == 1) begin // ����Ƕ�����
        // ����IAddr���ڴ��ж�ȡ4��������8λ���ݲ���ϳ�32λָ��
        IDataOut[7:0]  = Mem[IAddr + 3];
        IDataOut[15:8] = Mem[IAddr + 2];
        IDataOut[23:16] = Mem[IAddr + 1];
        IDataOut[31:24] = Mem[IAddr];
    end
end

endmodule
