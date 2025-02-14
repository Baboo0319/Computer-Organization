`timescale 1ns / 1ps

module PC_sim();

    // ���������ź�Ϊ�Ĵ�������
    reg CLK;                     // ʱ���ź�
    reg Reset;                   // ��λ�ź�
    reg PCWre;                   // дʹ���ź�
    reg [1:0] PCSrc;             // ���������Դѡ���źţ�2λ
    reg signed [15:0] Immediate;  // ������չ��������
    reg [31:0] JumpPC;           // ���ȱʧ��JumpPC�ź�

    // ��������ź�Ϊ��������
    wire [31:0] Address;         // ��ǰ��PCֵ

    // ʵ���� PC ģ�飬�����Ӷ˿�
    PC uut (
        .CLK(CLK),
        .Reset(Reset),
        .PCWre(PCWre),
        .PCSrc(PCSrc),           // 2λ�ź�
        .Immediate(Immediate),
        .JumpPC(JumpPC),         // ����JumpPC�ź�
        .Address(Address)
    );

    // ����ʱ���źţ�ÿ15��ʱ�䵥λ��תһ��
    always #7.5 CLK = !CLK;      // ʹ�ø���ȷ��ʱ�䵥λ���������Ϊ7.5ns��

    initial begin
        // ���ò��μ�¼�ļ�
        $dumpfile("PC.vcd"); // �����ļ���
        $dumpvars(0, PC_sim); // ��¼���б���

        // ��ʼ��
        CLK = 0;
        Reset = 0;
        PCWre = 0;
        PCSrc = 2'b00;          // ��ʼ��Ϊ˳��ִ��
        Immediate = 0;
        JumpPC = 32'h0000_0000; // ��ʼ��JumpPCΪ0

        // ����ת��˳��ִ����һ����ַ
        #100;                   // �ӳ�100��ʱ�䵥λ
        Reset = 1;              // ȡ����λ
        PCWre = 1;              // �������PCֵ
        PCSrc = 2'b00;          // ˳��ִ��
        Immediate = 4;          // ����������


        // ��ת��ִ����ת֮���ָ��
        #100;
        PCSrc = 2'b01;          // �����ת
        Immediate = 4;


        // ������ת��ִ����ת֮���ָ��
        #100;
        PCSrc = 2'b10;          // ������ת
        JumpPC = 32'h0000_1000; // ������ת��ַ

        // ��������
        #100;
        $stop;                  // ֹͣ����
    end

endmodule