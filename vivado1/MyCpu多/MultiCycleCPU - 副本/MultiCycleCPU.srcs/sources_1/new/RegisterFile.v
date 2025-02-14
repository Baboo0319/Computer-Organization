`timescale 1ns / 1ps

// ����Ĵ����ļ�ģ��
module RegisterFile(
    input CLK, // ʱ���ź�
    input WrRegDSrc, // д��Ĵ�������Դѡ���ź�
    input [31:0] PC_add_4, // ��ǰPC��ַ��4��ֵ
    input [1:0] RegDst, // д��Ĵ���Ŀ��ѡ���ź�
    input RegWre, // �Ĵ���д��ʹ���ź�
    input [4:0] rs, rt, rd, // ��ȡ��д��Ĵ����ĵ�ַ
    input [31:0] drDB, // д��Ĵ���������
    output reg [31:0] Data1, Data2, // �ӼĴ�����ȡ������
    output [31:0] writeData // д��Ĵ���������
);

    // ����Ҫд��ļĴ����˿�
    reg [4:0] writeReg;

    // ����RegDstѡ��Ҫд��ļĴ���
    always @(*) begin
        case (RegDst)
            2'b01: writeReg = rt; // д��rt�Ĵ���
            2'b10: writeReg = rd; // д��rd�Ĵ���
            2'b00: writeReg = 5'b11111; // jalָ��д��$31�Ĵ���
            default: writeReg = 5'b00000; // Ĭ�ϲ�д��
        endcase
    end

    // ����WrRegDSrcѡ��д��Ĵ���������Դ
    assign writeData = WrRegDSrc ? drDB : PC_add_4;

    // ��ʼ��32��32λ�Ĵ���
    reg [31:0] register[0:31];
    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1) 
            register[i] = 32'b0; // ʹ��������ֵ��ʼ���Ĵ���Ϊ0
    end

    // ��������ݼĴ�����ַ��ȡ����
    always @(*) begin
        Data1 = register[rs]; // ��ȡrs�Ĵ���������
        Data2 = register[rt]; // ��ȡrt�Ĵ���������
    end

    // д��Ĵ���
    always @(CLK) begin
        if (CLK==0 && RegWre && (writeReg != 5'b00000)&&(writeReg!=5'b11111)) // ����д��Ĵ���0
            register[writeReg] <= writeData; // д���$0�ͷ�$31�ļĴ���
        else if(CLK==1 && RegWre && WrRegDSrc==0 && (writeReg != 5'b00000)) // jalָ��ʱд��$31�Ĵ���
            register[writeReg] <= writeData;
    end
 
endmodule