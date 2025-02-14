`timescale 1ns / 1ps
`include "SignZeroExtend.v"  // ���� SignZeroExtend ģ��Ķ����ļ�

module SignZeroExtend_sim();

    // ���������ź�Ϊ�Ĵ�������
    reg signed [15:0] Immediate;  // �����16λ��������������
    reg ExtSel;                   // ��չѡ���źţ�1Ϊ������չ��0Ϊ����չ

    // ��������ź�Ϊ��������
    wire [31:0] Out;              // �����32λ��չ�������

    // ʵ���� SignZeroExtend ģ�飬�����Ӷ˿�
    SignZeroExtend uut (
        .Immediate(Immediate),
        .ExtSel(ExtSel),
        .Out(Out)
    );

initial begin
    // ���ò��μ�¼�ļ�
    $dumpfile("SignZeroExtend.vcd");
    $dumpvars(0, SignZeroExtend_sim);

    // ��ʼ��
    ExtSel = 0;
    Immediate = 16'd0;

    // �ṩһ��������ʱ��������ȷ����ʼ�����
    #50;

    // Test1: ����չ
    ExtSel = 0;
    Immediate = 16'd7;
    #50;

    // Test2: �����ķ�����չ
    ExtSel = 1;
    Immediate = 16'd10;
    #50;

    // Test3: �����ķ�����չ
    ExtSel = 1;
    Immediate = -16'd7;
    #50;

    // ��������
    #50;
    $stop;
end

endmodule
