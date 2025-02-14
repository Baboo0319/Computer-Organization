`timescale 1ns / 1ps
module SignZeroExtend(
    // ��������ͨ·������������
    input wire [15:0] Immediate,  // �����16λ������
    input ExtSel,                // ��չѡ���źţ�1Ϊ������չ��0Ϊ����չ
    output wire [31:0] Out       // �����32λ��չ�������
);

// ��16λ�洢������
// ֱ�ӽ������16λ��������ֵ������ĵ�16λ
assign Out[15:0] = Immediate[15:0];

// ǰ16λ�������������в�1��0�Ĳ���
// ��� ExtSel Ϊ1������з�����չ���� Immediate �����λ����15λ�����Ƶ���16λ
// ��� ExtSel Ϊ0�����������չ������16λȫ����Ϊ0
assign Out[31:16] = ExtSel == 1 ? {16{Immediate[15]}} : 16'b0;

endmodule

