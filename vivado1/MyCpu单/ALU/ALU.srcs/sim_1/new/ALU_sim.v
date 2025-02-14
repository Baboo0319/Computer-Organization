`timescale 1ns / 1ps

module ALU_sim();

    // ���������ź�Ϊ�Ĵ�������
    reg [31:0] ReadData1; // ��һ��������
    reg [31:0] ReadData2; // �ڶ���������
    reg [31:0] Ext;       // ��չ���������
    reg [4:0] Sa;         // ��λ����5λ��
    reg [2:0] ALUop;      // ָ��Ҫִ�еĲ�������
    reg ALUSrcA, ALUSrcB; // �����źţ�ѡ���������Դ

    // ��������ź�Ϊ��������
    wire zero;            // ���־λ
    wire [31:0] Result;   // ������

    // ʵ����ALUģ�飬�����Ӷ˿�
    ALU uut(
        .ReadData1(ReadData1),
        .ReadData2(ReadData2),
        .Ext(Ext),
        .Sa(Sa),
        .ALUop(ALUop),
        .ALUSrcA(ALUSrcA),
        .ALUSrcB(ALUSrcB),
        .zero(zero),
        .Result(Result)
    );

    initial begin
        // ���ò��μ�¼�ļ�
        $dumpfile("ALU32.vcd"); // �����ļ���
        $dumpvars(0, ALU_sim);  // ��¼���б���

        // �������п�ʼ

        // add1: ���Լӷ�������ALUSrcA=0, ALUSrcB=0
        #0;
        ReadData1 = 0;
        ReadData2 = 0;
        Ext = 1;
        Sa = 5'b00001; 
        ALUop = 3'b000;
        ALUSrcA = 0;
        ALUSrcB = 0;

        // add2: ���Լӷ�������ALUSrcA=1, ALUSrcB=0
        #50;
        ReadData1 = 0;
        ReadData2 = 0;
        Ext = 1;
        Sa = 5'b00001;
        ALUop = 3'b000;
        ALUSrcA = 1;
        ALUSrcB = 0;

        // add3: ���Լӷ�������ALUSrcA=0, ALUSrcB=1
        #50;
        ReadData1 = 0;
        ReadData2 = 0;
        Ext = 1;
        Sa = 5'b00001;
        ALUop = 3'b000;
        ALUSrcA = 0;
        ALUSrcB = 1;

        // add4: ���Լӷ�������ALUSrcA=1, ALUSrcB=1
        #50;
        ReadData1 = 0;
        ReadData2 = 0;
        Ext = 1;
        Sa = 5'b00001;
        ALUop = 3'b000;
        ALUSrcA = 1;
        ALUSrcB = 1;

        // sub1: ���Լ���������ALUSrcA=0, ALUSrcB=0
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd3;
        Sa = 5'b00100;
        ALUop = 3'b001;
        ALUSrcA = 0;
        ALUSrcB = 0;

        // sub2: ���Լ���������ALUSrcA=1, ALUSrcB=0
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd3;
        Sa = 5'b00100;
        ALUop = 3'b001;
        ALUSrcA = 1;
        ALUSrcB = 0;

        // sub3: ���Լ���������ALUSrcA=0, ALUSrcB=1
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd3;
        Sa = 5'b00100;
        ALUop = 3'b001;
        ALUSrcA = 0;
        ALUSrcB = 1;

        // sub4: ���Լ���������ALUSrcA=1, ALUSrcB=1
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd3;
        Sa = 5'b00100;
        ALUop = 3'b001;
        ALUSrcA = 1;
        ALUSrcB = 1;

        // left_shift1: ���������߼�������ALUSrcA=0, ALUSrcB=0
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd2;
        Sa = 5'b00100;
        ALUop = 3'b010;
        ALUSrcA = 0;
        ALUSrcB = 0;

        // left_shift2: ���������߼�������ALUSrcA=1, ALUSrcB=0
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd2;
        Sa = 5'b00100;
        ALUop = 3'b010;
        ALUSrcA = 1;
        ALUSrcB = 0;

        // left_shift3: ���������߼�������ALUSrcA=0, ALUSrcB=1
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd2;
        Sa = 5'b00100;
        ALUop = 3'b010;
        ALUSrcA = 0;
        ALUSrcB = 1;

        // left_shift4: ���������߼�������ALUSrcA=1, ALUSrcB=1
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd2;
        Sa = 5'b00100;
        ALUop = 3'b010;
        ALUSrcA = 1;
        ALUSrcB = 1;

        // or1: ���Ի����㣬ALUSrcA=0, ALUSrcB=0
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd2;
        Sa = 5'b00100;
        ALUop = 3'b011;
        ALUSrcA = 0;
        ALUSrcB = 0;

        // or2: ���Ի����㣬ALUSrcA=1, ALUSrcB=0
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd2;
        Sa = 5'b00100;
        ALUop = 3'b011;
        ALUSrcA = 1;
        ALUSrcB = 0;

        // or3: ���Ի����㣬ALUSrcA=0, ALUSrcB=1
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd2;
        Sa = 5'b00100;
        ALUop = 3'b011;
        ALUSrcA = 0;
        ALUSrcB = 1;

        // or4: ���Ի����㣬ALUSrcA=1, ALUSrcB=1
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd2;
        Sa = 5'b00100;
        ALUop = 3'b011;
        ALUSrcA = 1;
        ALUSrcB = 1;

        // and1: ���������㣬ALUSrcA=0, ALUSrcB=0
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd2;
        Sa = 5'b00100;
        ALUop = 3'b100;
        ALUSrcA = 0;
        ALUSrcB = 0;

        // and2: ���������㣬ALUSrcA=1, ALUSrcB=0
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd2;
        Sa = 5'b00100;
        ALUop = 3'b100;
        ALUSrcA = 1;
        ALUSrcB = 0;

        // and3: ���������㣬ALUSrcA=0, ALUSrcB=1
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd2;
        Sa = 5'b00100;
        ALUop = 3'b100;
        ALUSrcA = 0;
        ALUSrcB = 1;

        // and4: ���������㣬ALUSrcA=1, ALUSrcB=1
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd2;
        Sa = 5'b00100;
        ALUop = 3'b100;
        ALUSrcA = 1;
        ALUSrcB = 1;

        // �������űȽ�1: �����޷���С�ڱȽϣ�ALUSrcA=0, ALUSrcB=0
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd2;
        Sa = 5'b00001;
        ALUop = 3'b101;
        ALUSrcA = 0;
        ALUSrcB = 0;

        // �������űȽ�2: �����޷���С�ڱȽϣ�ALUSrcA=1, ALUSrcB=0
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd2;
        Sa = 5'b00001;
        ALUop = 3'b101;
        ALUSrcA = 1;
        ALUSrcB = 0;

        // �������űȽ�3: �����޷���С�ڱȽϣ�ALUSrcA=0, ALUSrcB=1
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd2;
        Sa = 5'b00001;
        ALUop = 3'b101;
        ALUSrcA = 0;
        ALUSrcB = 1;

        // �������űȽ�4: �����޷���С�ڱȽϣ�ALUSrcA=1, ALUSrcB=1
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd2;
        Sa = 5'b00001;
        ALUop = 3'b101;
        ALUSrcA = 1;
        ALUSrcB = 1;

        // �����űȽ�1: ���Դ�����С�ڱȽϣ�ALUSrcA=0, ALUSrcB=0
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd2;
        Sa = 5'b00001;
        ALUop = 3'b110;
        ALUSrcA = 0;
        ALUSrcB = 0;

        // �����űȽ�2: ���Դ�����С�ڱȽϣ�ALUSrcA=1, ALUSrcB=0
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd2;
        Sa = 5'b00001;
        ALUop = 3'b110;
        ALUSrcA = 1;
        ALUSrcB = 0;

        // �����űȽ�3: ���Դ�����С�ڱȽϣ�ALUSrcA=0, ALUSrcB=1
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd2;
        Sa = 5'b00001;
        ALUop = 3'b110;
        ALUSrcA = 0;
        ALUSrcB = 1;

        // �����űȽ�4: ���Դ�����С�ڱȽϣ�ALUSrcA=1, ALUSrcB=1
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd2;
        Sa = 5'b00001;
        ALUop = 3'b110;
        ALUSrcA = 1;
        ALUSrcB = 1;

        // nor1: ����������㣬ALUSrcA=0, ALUSrcB=0
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd2;
        Sa = 5'b00001;
        ALUop = 3'b111;
        ALUSrcA = 0;
        ALUSrcB = 0;

        // nor2: ����������㣬ALUSrcA=1, ALUSrcB=0
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd2;
        Sa = 5'b00001;
        ALUop = 3'b111;
        ALUSrcA = 1;
        ALUSrcB = 0;

        // nor3: ����������㣬ALUSrcA=0, ALUSrcB=1
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd2;
        Sa = 5'b00001;
        ALUop = 3'b111;
        ALUSrcA = 0;
        ALUSrcB = 1;

        // nor4: ����������㣬ALUSrcA=1, ALUSrcB=1
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd2;
        Sa = 5'b00001;
        ALUop = 3'b111;
        ALUSrcA = 1;
        ALUSrcB = 1;

        // ��������
        #50;
        $stop; // ֹͣ����
    end

endmodule