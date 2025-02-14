`timescale 1ns / 1ps

// 定义多周期CPU模块
module multiCycleCPU(
    input CLK, // 时钟信号
    input Reset, // 复位信号
    output [4:0] rs, rt, // 读取寄存器的地址
    output wire [5:0] OpCode, // 操作码
    output wire [31:0] Out1, Out2, // 寄存器文件输出
    output wire [31:0] curPC, nextPC, // 当前和下一个程序计数器的值
    output wire [31:0] Result, // ALU运算结果
    output wire [31:0] DBData, // 数据总线输出
    output wire [31:0] Instruction // 指令存储器输出
);

    // 定义内部信号
    wire [2:0] ALUOp; // ALU操作码
    wire [5:0] func; // 函数码
    wire [2:0] state; // 状态码
    wire [31:0] Extout, DMOut; // 扩展输出和数据存储器输出
    wire [15:0] Immediate; // 立即数
    wire [4:0] rd, sa; // 写入寄存器地址和移位量
    wire [31:0] JumpPC; // 跳转程序计数器的值
    wire zero, sign; // ALU零标志和符号标志
    wire PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, IRWre, WrRegDSrc; // 控制信号
    wire InsMemRW, RD, WR, ExtSel; // 内存读写信号和扩展选择信号
    wire [1:0] RegDst, PCSrc; // 寄存器目标选择信号和程序计数器源选择信号
    wire [3:0] PC4; // 程序计数器加4的值
    wire [31:0] PC_add_4, drPC_add_4; // 程序计数器加4的值和其延迟版本
    wire [31:0] drOut1, drOut2; // 寄存器文件输出的延迟版本
    wire [31:0] DAddr; // 数据地址
    wire [31:0] DB, drDB; // 数据总线和其延迟版本

    // 状态机模块，用于改变状态
    ChangeState ST(OpCode, func, Reset, CLK, state);

    // 控制单元模块，用于生成控制信号
    ControlUnit CU(state, OpCode, func, zero, sign, IRWre, PCWre, ALUSrcA, ALUSrcB, DBDataSrc, WrRegDSrc, InsMemRW, RD, WR, ExtSel, RegDst, PCSrc, ALUOp, RegWre);

    // 程序计数器模块
    PC pc(CLK, Reset, PCWre, PCSrc, Immediate, Out1, JumpPC, curPC, nextPC, PC_add_4, PC4);

    // 指令存储器模块
    InstructionMemory IM(curPC, InsMemRW, Instruction);

    // 指令寄存器模块
    IR ir(CLK, IRWre, Instruction, PC4, OpCode, func, rs, rt, rd, Immediate, sa, JumpPC);

    // 寄存器文件模块
    RegisterFile RF(CLK, WrRegDSrc, drPC_add_4, RegDst, RegWre, rs, rt, rd, drDB, Out1, Out2, DBData);

    // 延迟寄存器模块，用于程序计数器加4的值
    DR pcadd(CLK, PC_add_4, drPC_add_4); // 这个模块的必要性在于，如果没有它，在仿真时jal指令能够正常在$31号寄存器写入PC+4，但是在实际硬件上该指令却不能正常执行

    // 延迟寄存器模块，用于Out1的延迟
    DR Adr(CLK, Out1, drOut1);

    // 延迟寄存器模块，用于Out2的延迟
    DR Bdr(CLK, Out2, drOut2);

    // 算术逻辑单元模块
    ALU alu(drOut1, drOut2, Extout, sa, ALUOp, ALUSrcA, ALUSrcB, zero, Result, sign);

    // 延迟寄存器模块，用于ALU结果的延迟
    DR aluOutDr(CLK, Result, DAddr);

    // 数据存储器模块
    DataMemory DM(DAddr, drOut2, RD, WR, DMOut);

    // 2选1多路选择器模块，用于选择DBData的数据源
    mux2to1 db(Result, DMOut, DBDataSrc, DB);

    // 延迟寄存器模块，用于DB的延迟
    DR dbdr(CLK, DB, drDB);

    // 符号零扩展模块
    SignZeroExtend SZE(Immediate, ExtSel, Extout);
endmodule