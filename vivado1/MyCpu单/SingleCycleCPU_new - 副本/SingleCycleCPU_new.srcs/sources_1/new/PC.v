`timescale 1ns / 1ps

module PC(
    input CLK, // ʱ���ź�
    input Reset, // ��λ�źţ���Ϊ�͵�ƽʱ��PC����
    input PCWre, // дʹ���źţ�Ϊ�ߵ�ƽʱ�������PCֵ
    input [1:0] PCSrc, // ���������Դѡ���ź�
    input signed [15:0] Immediate, // ������
    input [31:0] JumpPC, // ��תĿ���ַ

    output reg signed [31:0] Address, // ��ǰ��PCֵ
    output [31:0] nextPC, // ��һ��PCֵ
    output [3:0] PC4 // ��ǰPCֵ�ĸ�4λ
);

// ������һ��PCֵ
// ���PCSrc[0]Ϊ1����ִ�������ת��Address + 4 + (Immediate << 2)
// ���PCSrc[1]Ϊ1����ִ�о�����ת��JumpPC
// ����˳��ִ����һ��ָ�Address + 4
assign nextPC = (PCSrc[0]) ? Address + 4 + (Immediate << 2) : ((PCSrc[1]) ? JumpPC : Address + 4);

// ��ȡ��ǰPCֵ�ĸ�4λ
assign PC4 = Address[31:28];

// ��CLK��Reset���½��ش���
always @(posedge CLK or negedge Reset) begin
    if(Reset == 0) begin
        // ���ResetΪ�͵�ƽ����PC����
        Address = 0;
    end else if(PCWre) begin // ֻ����PCWreΪ�ߵ�ƽʱ���������PCֵ
        if(PCSrc[0]) begin
            // ���PCSrc[0]Ϊ1��ִ�������ת
            Address = Address + 4 + (Immediate << 2);
        end else if(PCSrc[1]) begin
            // ���PCSrc[1]Ϊ1��ִ�о�����ת
            Address = JumpPC;
        end else begin
            // ����˳��ִ����һ��ָ��
            Address = Address + 4;
        end
    end
end

endmodule