`timescale 1ns / 1ps

module RegFile_sim();
    // ���������ź�Ϊ�Ĵ�������
    reg CLK;                  // ʱ���ź�
    reg RegDst;               // �Ĵ���Ŀ��ѡ���źţ�Ϊ1ʱѡ��rd��ΪĿ��Ĵ�����Ϊ0ʱѡ��rt��ΪĿ��Ĵ���
    reg RegWre;               // �Ĵ���дʹ���źţ�Ϊ1ʱ����д��Ĵ���
    reg DBDataSrc;            // ����Դѡ���źţ�Ϊ1ʱ�����ݴ洢����ȡ��Ϊ0ʱ��ALU��ȡ
   // reg [5:0] Opcode;         // ָ������루Ŀǰ��ģ����δʹ�ã�
    reg [4:0] rs, rt, rd;     // Դ�Ĵ�����Ŀ��Ĵ������
  //  reg [10:0] im;            // ������
    reg [31:0] dataFromALU;   // ����ALU������
    reg [31:0] dataFromRW;    // �������ݴ洢��������Դ������

    // ��������ź�Ϊ��������
    wire [31:0] Data1;        // ALU����ĵ�һ������A
    wire [31:0] Data2;        // ALU����ĵڶ�������B

    // ʵ���� RegisterFile ģ�飬�����Ӷ˿�
    RegisterFile uut (
        .CLK(CLK),
        .RegDst(RegDst),
        .RegWre(RegWre),
        .DBDataSrc(DBDataSrc),
      //  .Opcode(Opcode),      // Ŀǰ��ģ����δʹ��
        .rs(rs),
        .rt(rt),
        .rd(rd),
       // .im(im),
        .dataFromALU(dataFromALU),
        .dataFromRW(dataFromRW),

        .Data1(Data1),
        .Data2(Data2)
    );

    // ����ʱ���źţ�ÿ15��ʱ�䵥λ��תһ��
    always #15 CLK = !CLK;

    initial begin
        // ���ò��μ�¼�ļ�
        $dumpfile("RegisterFile.vcd"); // �����ļ���
        $dumpvars(0, RegFile_sim);     // ��¼���б���

        // ��ʼ��
        CLK = 0;
        RegDst = 0;
        RegWre = 0;
        DBDataSrc = 0;
       // Opcode = 6'b000000; // ��ȻĿǰ��ģ����δʹ�ã������Ա����Ա�����ʹ��
        rs = 5'b00000;
        rt = 5'b00000;
        rd = 5'b00000;
       // im = 11'b0;
        dataFromALU = 32'd0;
        dataFromRW = 32'd0;

        // Test1: ����R��ָ�д��Ĵ�����ʹ������ALU�����
        #10;
        CLK = 0;
        RegDst = 1;           // ����R��ָ��
        RegWre = 1;           // ����д�Ĵ���
        DBDataSrc = 0;        // ʹ������ALU�����
     //   Opcode = 6'b000000;   // R��ָ��Ĳ�����
        rs = 5'b00000;
        rt = 5'b00001;
        rd = 5'b00010;
      //  im = 11'b0;
        dataFromALU = 32'd1;  // ����ALU�����
        dataFromRW = 32'd2;   // ����RW�����

        // �ṩһ��������ʱ������
        #30;

        // Test2: ������R��ָ�������д�Ĵ�����ʹ���������ݴ洢�������
        RegDst = 0;           // ����I��ָ��
        RegWre = 0;           // ������д�Ĵ���
        DBDataSrc = 1;        // ʹ���������ݴ洢�������
       // Opcode = 6'b000000;   // I��ָ��Ĳ����루������Ч��
        rs = 5'b00011;
        rt = 5'b00100;
        rd = 5'b00101;
      //  im = 11'd10;
        dataFromALU = 32'd3;  // ����ALU�����
        dataFromRW = 32'd4;   // ����RW�����

       #30;     
        // ��������
        $stop;                // ֹͣ����
    end
endmodule
