`timescale 1ns / 1ps

module SingleCycleCPU_sim();

    // ���������ź�Ϊ�Ĵ�������
    reg CLK;                       // ʱ���ź�
    reg Reset;                     // ��λ�ź�

    // ��������ź�Ϊ��������
    wire [31:0] Out1;              // �Ĵ����ļ��ĵ�һ�����
    wire [31:0] Out2;              // �Ĵ����ļ��ĵڶ������
    wire [31:0] curPC;             // ��ǰ���������ֵ
    wire [31:0] Result;            // ALU �Ľ�����
    wire [5:0] Opcode;             // ������

    // ʵ�������ⵥԪ (Unit Under Test, UUT)
    SingleCycleCPU uut (
        .CLK(CLK),                 // ����ʱ���ź�
        .Reset(Reset),             // ���Ӹ�λ�ź�
        .Opcode(Opcode),           // ���������
        .Out1(Out1),               // ����Ĵ����ļ��ĵ�һ�����
        .Out2(Out2),               // ����Ĵ����ļ��ĵڶ������
        .curPC(curPC),             // �����ǰ���������ֵ
        .Result(Result)            // ��� ALU ���
    );

    initial begin 
        // ���ò��μ�¼�ļ�
        $dumpfile("SCCPU.vcd");    // �����ļ���
        $dumpvars(0, SingleCycleCPU_sim);  // ��¼���б���

        // ��ʼ�������ź�
        CLK = 0;                   // ��ʼʱ���ź�Ϊ�͵�ƽ
        Reset = 0;                 // ��ʼ��λ�ź�Ϊ�͵�ƽ���Ǹ�λ״̬��

        #50;
        CLK = 1;                   // ��һ��ʱ������������

        #50;
        Reset = 1;                 // ���ø�λ�ź�Ϊ�ߵ�ƽ��������λ

        // ����ʱ���ź�
        forever begin
            #50 CLK = !CLK;        // ÿ��50ʱ�䵥λ��תһ��ʱ���ź�
        end
    end

endmodule
