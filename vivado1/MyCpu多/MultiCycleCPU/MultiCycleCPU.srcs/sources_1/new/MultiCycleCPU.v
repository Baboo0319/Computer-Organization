`timescale 1ns / 1ps

// ���������CPUģ��
module multiCycleCPU(
    input CLK, // ʱ���ź�
    input Reset, // ��λ�ź�
    output [4:0] rs, rt, // ��ȡ�Ĵ����ĵ�ַ
    output wire [5:0] OpCode, // ������
    output wire [31:0] Out1, Out2, // �Ĵ����ļ����
    output wire [31:0] curPC, nextPC, // ��ǰ����һ�������������ֵ
    output wire [31:0] Result, // ALU������
    output wire [31:0] DBData, // �����������
    output wire [31:0] Instruction // ָ��洢�����
);

    // �����ڲ��ź�
    wire [2:0] ALUOp; // ALU������
    wire [5:0] func; // ������
    wire [2:0] state; // ״̬��
    wire [31:0] Extout, DMOut; // ��չ��������ݴ洢�����
    wire [15:0] Immediate; // ������
    wire [4:0] rd, sa; // д��Ĵ�����ַ����λ��
    wire [31:0] JumpPC; // ��ת�����������ֵ
    wire zero, sign; // ALU���־�ͷ��ű�־
    wire PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, IRWre, WrRegDSrc; // �����ź�
    wire InsMemRW, RD, WR, ExtSel; // �ڴ��д�źź���չѡ���ź�
    wire [1:0] RegDst, PCSrc; // �Ĵ���Ŀ��ѡ���źźͳ��������Դѡ���ź�
    wire [3:0] PC4; // �����������4��ֵ
    wire [31:0] PC_add_4, drPC_add_4; // �����������4��ֵ�����ӳٰ汾
    wire [31:0] drOut1, drOut2; // �Ĵ����ļ�������ӳٰ汾
    wire [31:0] DAddr; // ���ݵ�ַ
    wire [31:0] DB, drDB; // �������ߺ����ӳٰ汾

    // ״̬��ģ�飬���ڸı�״̬
    ChangeState ST(OpCode, func, Reset, CLK, state);

    // ���Ƶ�Ԫģ�飬�������ɿ����ź�
    ControlUnit CU(state, OpCode, func, zero, sign, IRWre, PCWre, ALUSrcA, ALUSrcB, DBDataSrc, WrRegDSrc, InsMemRW, RD, WR, ExtSel, RegDst, PCSrc, ALUOp, RegWre);

    // ���������ģ��
    PC pc(CLK, Reset, PCWre, PCSrc, Immediate, Out1, JumpPC, curPC, nextPC, PC_add_4, PC4);

    // ָ��洢��ģ��
    InstructionMemory IM(curPC, InsMemRW, Instruction);

    // ָ��Ĵ���ģ��
    IR ir(CLK, IRWre, Instruction, PC4, OpCode, func, rs, rt, rd, Immediate, sa, JumpPC);

    // �Ĵ����ļ�ģ��
    RegisterFile RF(CLK, WrRegDSrc, drPC_add_4, RegDst, RegWre, rs, rt, rd, drDB, Out1, Out2, DBData);

    // �ӳټĴ���ģ�飬���ڳ����������4��ֵ
    DR pcadd(CLK, PC_add_4, drPC_add_4); // ���ģ��ı�Ҫ�����ڣ����û�������ڷ���ʱjalָ���ܹ�������$31�żĴ���д��PC+4��������ʵ��Ӳ���ϸ�ָ��ȴ��������ִ��

    // �ӳټĴ���ģ�飬����Out1���ӳ�
    DR Adr(CLK, Out1, drOut1);

    // �ӳټĴ���ģ�飬����Out2���ӳ�
    DR Bdr(CLK, Out2, drOut2);

    // �����߼���Ԫģ��
    ALU alu(drOut1, drOut2, Extout, sa, ALUOp, ALUSrcA, ALUSrcB, zero, Result, sign);

    // �ӳټĴ���ģ�飬����ALU������ӳ�
    DR aluOutDr(CLK, Result, DAddr);

    // ���ݴ洢��ģ��
    DataMemory DM(DAddr, drOut2, RD, WR, DMOut);

    // 2ѡ1��·ѡ����ģ�飬����ѡ��DBData������Դ
    mux2to1 db(Result, DMOut, DBDataSrc, DB);

    // �ӳټĴ���ģ�飬����DB���ӳ�
    DR dbdr(CLK, DB, drDB);

    // ��������չģ��
    SignZeroExtend SZE(Immediate, ExtSel, Extout);
endmodule