`timescale 1ns / 1ps
module RegisterFile(
    input CLK,                   // ʱ���ź�
    input RegDst,                // �Ĵ���Ŀ��ѡ���źţ�Ϊ1ʱѡ��rd��ΪĿ��Ĵ�����Ϊ0ʱѡ��rt��ΪĿ��Ĵ���
    input RegWre,                // �Ĵ���дʹ���źţ�Ϊ1ʱ����д��Ĵ���
    input DBDataSrc,             // ����Դѡ���źţ�Ϊ1ʱ�����ݴ洢����ȡ��Ϊ0ʱ��ALU��ȡ
    //input [5:0] Opcode,          // ָ�������
    input [4:0] rs,              // Դ�Ĵ���1���
    input [4:0] rt,              // Դ�Ĵ���2���
    input [4:0] rd,              // Ŀ��Ĵ������
   // input [10:0] im,             // ������

    input [31:0] dataFromALU,    // ����ALU������
    input [31:0] dataFromRW,     // �������ݴ洢��������Դ������

    output  reg [31:0] Data1,     // ALU����ĵ�һ������A
    output  reg [31:0] Data2,     // ALU����ĵڶ�������B
    output  [31:0] writeData  // д��Ĵ���������
);

// ����Ҫд�ļĴ����˿�
wire [4:0] writeReg;

// ���� RegDst �����ź�ѡ��Ҫд���Ŀ��Ĵ�����
// ��� RegDst Ϊ�棬����R��ָ�ʹ�� rd ��ΪĿ��Ĵ�����
// ��� RegDst Ϊ�٣�����I��ָ�ʹ�� rt ��ΪĿ��Ĵ�����
assign writeReg = RegDst ? rd : rt;

// ���� DBDataSrc �����ź�ѡ��д��Ĵ�����������Դ��
// ��� DBDataSrc Ϊ0����ʹ������ALU�������
// ��� DBDataSrc Ϊ1����ʹ���������ݴ洢���������
assign writeData = DBDataSrc ? dataFromRW : dataFromALU;

// ��ʼ���Ĵ������飬��32��32λ�Ĵ���
reg [31:0] register[0:31];
integer i;
initial begin
    for(i = 0; i < 32; i = i + 1) 
        register[i] <= 0; // ���мĴ�����ʼֵ��Ϊ0
end
always@(*) begin
    Data1 = register[rs];
    Data2 = register[rt];
end

// ��ʱ���½��ش��������¼Ĵ������ݣ�
// ֻ���� RegWre Ϊ�ߵ�ƽ�Ҳ���д��0�żĴ���ʱ������д�롣
always @ (negedge CLK) begin
    if(RegWre && writeReg != 0) // ��ֹ����д��0�żĴ���
        register[writeReg] <= writeData;
end

endmodule

