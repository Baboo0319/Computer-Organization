`timescale 1ns / 1ps
module DataMemory(
    input CLK, // ʱ���ź�
    input wire [31:0] DAddr,  // ��ַ���룬����ָ�����ʵ��ڴ�λ��
    input wire [31:0] DataIn, // �������룬������д����ʱ����ΪҪд�������
    input RD,                 // ��ʹ���źţ�Ϊ1ʱ�����������Ϊ0ʱ�����ж������������̬��
    input WR,                 // дʹ���źţ�Ϊ0ʱ����д������Ϊ1ʱ��ֹд�������������̬
    output wire [31:0] DataOut // ��������������ж�����ʱ���Ӵ������ȡ������
);

// ����һ��8λ��128����ַ�ռ���ڴ�����
reg [7:0] Memory [0:127]; // ÿ���洢��ԪΪ8λ������128�������Ĵ洢��Ԫ

// ��Ϊһ��ָ�����ĸ��洢��Ԫ�洢�����Ե�ַ��Ҫ������λ�Գ���4
wire [31:0] address;
assign address = (DAddr << 2); // �������ַ������λ���൱�ڳ���4���õ�ʵ�ʵ��ֽڵ�ַ

// �����������RDΪ0������ڴ��ж�ȡ���ݣ������������̬��'z')
assign DataOut[7:0]  = (RD == 0) ? Memory[address + 3] : 8'bz; // ����ֽ�
assign DataOut[15:8] = (RD == 0) ? Memory[address + 2] : 8'bz; // �ڶ����ֽ�
assign DataOut[23:16] = (RD == 0) ? Memory[address + 1] : 8'bz; // �������ֽ�
assign DataOut[31:24] = (RD == 0) ? Memory[address] : 8'bz; // ����ֽ�

// д��������CLK���½��ش��������WRΪ0����DataIn�е�����д���ڴ�
always @ (negedge CLK) begin
    if(WR == 0) begin // ���дʹ���ź�Ϊ0����ִ��д����
        Memory[address] <= DataIn[31:24];   // д������ֽ�
        Memory[address + 1] <= DataIn[23:16]; // д��������ֽ�
        Memory[address + 2] <= DataIn[15:8];  // д��ڶ����ֽ�
        Memory[address + 3] <= DataIn[7:0];   // д������ֽ�
    end
end
 
endmodule
