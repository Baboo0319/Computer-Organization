`timescale 1ns / 1ps
module RegisterFile(
    input CLK,                   // ʱ���ź�
    input RegDst,                // �Ĵ���Ŀ��ѡ���źţ�Ϊ1ʱѡ��rd��Ϊ0ʱѡ��rt
    input RegWre,                // �Ĵ���дʹ���źţ�Ϊ1ʱ����д��Ĵ���
    input DBDataSrc,             // ����Դѡ���źţ�Ϊ1ʱ�����ݴ洢����ȡ��Ϊ0ʱ��ALU��ȡ

    // input [5:0] Opcode,        // ָ������루ע�͵���
    input [4:0] rs,              // Դ�Ĵ���1���
    input [4:0] rt,              // Դ�Ĵ���2���
    input [4:0] rd,              // Ŀ��Ĵ������

    // input [10:0] im,           // ��������ע�͵���

    input [31:0] dataFromALU,    // ����ALU������
    input [31:0] dataFromRW,     // �������ݴ洢��������Դ������

    output [31:0] Data1,         // ALU����ĵ�һ������A
    output [31:0] Data2,         // ALU����ĵڶ�������B
    output [31:0] writeData      // д��Ĵ���������
);

// Ҫд�ļĴ����˿�
wire [4:0] writeReg;

// ���� RegDst ѡ��Ҫд���Ŀ��Ĵ���
// RegDst Ϊ��ʱ������R��ָ�ʹ�� rd ��ΪĿ��Ĵ�����Ϊ��ʱ������I��ָ�ʹ�� rt ��ΪĿ��Ĵ���
assign writeReg = RegDst ? rd : rt;

// ���� DBDataSrc ѡ��д��Ĵ�����������Դ
// DBDataSrc Ϊ0ʱ��ʹ������ALU�������Ϊ1ʱ��ʹ���������ݴ洢�������
assign writeData = DBDataSrc ? dataFromRW : dataFromALU;

// ��ʼ���Ĵ������飬��32��32λ�Ĵ���
reg [31:0] register[0:31];
integer i;
initial begin
    for(i = 0; i < 32; i = i + 1) 
        register[i] <= 0; // ���мĴ�����ʼֵ��Ϊ0
end

// ��� Data1 �� Data2 ��Ĵ����仯���仯
// Data1 Ϊ ALU ����ʱ�ĵ�һ������ A����ֵʼ��Ϊ rs �Ĵ���������
// Data2 Ϊ ALU ����ʱ�ĵڶ������� B����ֵʼ��Ϊ rt �Ĵ���������
// ע�⣺ԭʼ�����й��� Opcode �������Ѿ�ע�͵��ˣ����ﲻ�ٿ��� sll ָ������
assign Data1 = register[rs];
assign Data2 = register[rt];

// ��ʱ���½��ش��������¼Ĵ�������
always @ (negedge CLK) begin
    if(RegWre && writeReg != 0) // ֻ���� RegWre Ϊ�ߵ�ƽ�Ҳ���д��0�żĴ���ʱ������д��
        register[writeReg] <= writeData;
end

endmodule