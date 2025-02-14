// ����ʱ�䵥λ�;���
`timescale 1ns / 1ps

// ����PCģ��
module PC(
    input wire CLK,       // ʱ���ź�
    input wire Reset,     // ��λ�ź�
    input wire PCWre,     // PCд��ʹ���ź�
    input wire [1:0] PCSrc, // PCԴѡ���ź�
    input wire signed [15:0] Immediate, // ��������չ�ź�
    input wire [31:0] dataFromRs, // ����$31�żĴ�����PC��ֵַ
    input wire [31:0] JumpPC, // ��ת��ַ
    output reg signed [31:0] Address, // ��ǰָ���PC��ֵַ
    output reg [31:0] nextPC, // ��һ��ָ���PC��ֵַ
    output wire [31:0] PC_add_4, // �����ṩ��jalָ��д��$31�żĴ����ĵ�ֵַ
    output wire [3:0] PC4 // ��һ��PC��ַ��ǰ��λ�����ڹ���JumpPC��ֵַ
);

// ������һ��PC��ַ
always @(*) begin
    if(PCSrc == 2'b11) // j,jalָ��
        nextPC = JumpPC;
    else if(PCSrc == 2'b01) // beq,bne,bltzָ��
        nextPC = Address + 4 + (Immediate << 2);
    else if(PCSrc == 2'b10) // jrָ��
        nextPC = dataFromRs;
    else // Ĭ�������˳��ִ����һ��ָ��
        nextPC = Address + 4;
end

// ����PC+4��ֵ������jalָ��
assign PC_add_4 = Address + 4;

// ��ȡ��һ��PC��ַ��ǰ��λ
assign PC4 = Address[31:28];

// ��ʱ�������ػ�λ�ź��½���ʱ����PC��ַ
always @(posedge CLK or negedge Reset) begin
    if(Reset == 0) // ��λ�ź���Чʱ��PC��ַ����
        Address = 0;
    else if(PCWre) // ��PCWreΪ1ʱ��������ĵ�ַ
        if(PCSrc == 2'b11) // j,jalָ��
            Address <= JumpPC;
        else if(PCSrc == 2'b01) // beq,bne,bltzָ��
            Address <= Address + 4 + (Immediate << 2);
        else if(PCSrc == 2'b10) // jrָ��
            Address <= dataFromRs;
        else // Ĭ�������˳��ִ����һ��ָ��
            Address <= Address + 4;
end

endmodule