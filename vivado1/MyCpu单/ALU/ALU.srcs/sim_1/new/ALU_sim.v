`timescale 1ns / 1ps

module ALU_sim();

    // 定义输入信号为寄存器类型
    reg [31:0] ReadData1; // 第一个操作数
    reg [31:0] ReadData2; // 第二个操作数
    reg [31:0] Ext;       // 扩展后的立即数
    reg [4:0] Sa;         // 移位量（5位）
    reg [2:0] ALUop;      // 指定要执行的操作类型
    reg ALUSrcA, ALUSrcB; // 控制信号：选择操作数来源

    // 定义输出信号为线网类型
    wire zero;            // 零标志位
    wire [31:0] Result;   // 运算结果

    // 实例化ALU模块，并连接端口
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
        // 设置波形记录文件
        $dumpfile("ALU32.vcd"); // 波形文件名
        $dumpvars(0, ALU_sim);  // 记录所有变量

        // 测试序列开始

        // add1: 测试加法操作，ALUSrcA=0, ALUSrcB=0
        #0;
        ReadData1 = 0;
        ReadData2 = 0;
        Ext = 1;
        Sa = 5'b00001; 
        ALUop = 3'b000;
        ALUSrcA = 0;
        ALUSrcB = 0;

        // add2: 测试加法操作，ALUSrcA=1, ALUSrcB=0
        #50;
        ReadData1 = 0;
        ReadData2 = 0;
        Ext = 1;
        Sa = 5'b00001;
        ALUop = 3'b000;
        ALUSrcA = 1;
        ALUSrcB = 0;

        // add3: 测试加法操作，ALUSrcA=0, ALUSrcB=1
        #50;
        ReadData1 = 0;
        ReadData2 = 0;
        Ext = 1;
        Sa = 5'b00001;
        ALUop = 3'b000;
        ALUSrcA = 0;
        ALUSrcB = 1;

        // add4: 测试加法操作，ALUSrcA=1, ALUSrcB=1
        #50;
        ReadData1 = 0;
        ReadData2 = 0;
        Ext = 1;
        Sa = 5'b00001;
        ALUop = 3'b000;
        ALUSrcA = 1;
        ALUSrcB = 1;

        // sub1: 测试减法操作，ALUSrcA=0, ALUSrcB=0
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd3;
        Sa = 5'b00100;
        ALUop = 3'b001;
        ALUSrcA = 0;
        ALUSrcB = 0;

        // sub2: 测试减法操作，ALUSrcA=1, ALUSrcB=0
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd3;
        Sa = 5'b00100;
        ALUop = 3'b001;
        ALUSrcA = 1;
        ALUSrcB = 0;

        // sub3: 测试减法操作，ALUSrcA=0, ALUSrcB=1
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd3;
        Sa = 5'b00100;
        ALUop = 3'b001;
        ALUSrcA = 0;
        ALUSrcB = 1;

        // sub4: 测试减法操作，ALUSrcA=1, ALUSrcB=1
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd3;
        Sa = 5'b00100;
        ALUop = 3'b001;
        ALUSrcA = 1;
        ALUSrcB = 1;

        // left_shift1: 测试左移逻辑操作，ALUSrcA=0, ALUSrcB=0
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd2;
        Sa = 5'b00100;
        ALUop = 3'b010;
        ALUSrcA = 0;
        ALUSrcB = 0;

        // left_shift2: 测试左移逻辑操作，ALUSrcA=1, ALUSrcB=0
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd2;
        Sa = 5'b00100;
        ALUop = 3'b010;
        ALUSrcA = 1;
        ALUSrcB = 0;

        // left_shift3: 测试左移逻辑操作，ALUSrcA=0, ALUSrcB=1
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd2;
        Sa = 5'b00100;
        ALUop = 3'b010;
        ALUSrcA = 0;
        ALUSrcB = 1;

        // left_shift4: 测试左移逻辑操作，ALUSrcA=1, ALUSrcB=1
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd2;
        Sa = 5'b00100;
        ALUop = 3'b010;
        ALUSrcA = 1;
        ALUSrcB = 1;

        // or1: 测试或运算，ALUSrcA=0, ALUSrcB=0
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd2;
        Sa = 5'b00100;
        ALUop = 3'b011;
        ALUSrcA = 0;
        ALUSrcB = 0;

        // or2: 测试或运算，ALUSrcA=1, ALUSrcB=0
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd2;
        Sa = 5'b00100;
        ALUop = 3'b011;
        ALUSrcA = 1;
        ALUSrcB = 0;

        // or3: 测试或运算，ALUSrcA=0, ALUSrcB=1
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd2;
        Sa = 5'b00100;
        ALUop = 3'b011;
        ALUSrcA = 0;
        ALUSrcB = 1;

        // or4: 测试或运算，ALUSrcA=1, ALUSrcB=1
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd2;
        Sa = 5'b00100;
        ALUop = 3'b011;
        ALUSrcA = 1;
        ALUSrcB = 1;

        // and1: 测试与运算，ALUSrcA=0, ALUSrcB=0
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd2;
        Sa = 5'b00100;
        ALUop = 3'b100;
        ALUSrcA = 0;
        ALUSrcB = 0;

        // and2: 测试与运算，ALUSrcA=1, ALUSrcB=0
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd2;
        Sa = 5'b00100;
        ALUop = 3'b100;
        ALUSrcA = 1;
        ALUSrcB = 0;

        // and3: 测试与运算，ALUSrcA=0, ALUSrcB=1
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd2;
        Sa = 5'b00100;
        ALUop = 3'b100;
        ALUSrcA = 0;
        ALUSrcB = 1;

        // and4: 测试与运算，ALUSrcA=1, ALUSrcB=1
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd2;
        Sa = 5'b00100;
        ALUop = 3'b100;
        ALUSrcA = 1;
        ALUSrcB = 1;

        // 不带符号比较1: 测试无符号小于比较，ALUSrcA=0, ALUSrcB=0
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd2;
        Sa = 5'b00001;
        ALUop = 3'b101;
        ALUSrcA = 0;
        ALUSrcB = 0;

        // 不带符号比较2: 测试无符号小于比较，ALUSrcA=1, ALUSrcB=0
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd2;
        Sa = 5'b00001;
        ALUop = 3'b101;
        ALUSrcA = 1;
        ALUSrcB = 0;

        // 不带符号比较3: 测试无符号小于比较，ALUSrcA=0, ALUSrcB=1
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd2;
        Sa = 5'b00001;
        ALUop = 3'b101;
        ALUSrcA = 0;
        ALUSrcB = 1;

        // 不带符号比较4: 测试无符号小于比较，ALUSrcA=1, ALUSrcB=1
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd2;
        Sa = 5'b00001;
        ALUop = 3'b101;
        ALUSrcA = 1;
        ALUSrcB = 1;

        // 带符号比较1: 测试带符号小于比较，ALUSrcA=0, ALUSrcB=0
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd2;
        Sa = 5'b00001;
        ALUop = 3'b110;
        ALUSrcA = 0;
        ALUSrcB = 0;

        // 带符号比较2: 测试带符号小于比较，ALUSrcA=1, ALUSrcB=0
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd2;
        Sa = 5'b00001;
        ALUop = 3'b110;
        ALUSrcA = 1;
        ALUSrcB = 0;

        // 带符号比较3: 测试带符号小于比较，ALUSrcA=0, ALUSrcB=1
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd2;
        Sa = 5'b00001;
        ALUop = 3'b110;
        ALUSrcA = 0;
        ALUSrcB = 1;

        // 带符号比较4: 测试带符号小于比较，ALUSrcA=1, ALUSrcB=1
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd2;
        Sa = 5'b00001;
        ALUop = 3'b110;
        ALUSrcA = 1;
        ALUSrcB = 1;

        // nor1: 测试异或运算，ALUSrcA=0, ALUSrcB=0
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd2;
        Sa = 5'b00001;
        ALUop = 3'b111;
        ALUSrcA = 0;
        ALUSrcB = 0;

        // nor2: 测试异或运算，ALUSrcA=1, ALUSrcB=0
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd2;
        Sa = 5'b00001;
        ALUop = 3'b111;
        ALUSrcA = 1;
        ALUSrcB = 0;

        // nor3: 测试异或运算，ALUSrcA=0, ALUSrcB=1
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd2;
        Sa = 5'b00001;
        ALUop = 3'b111;
        ALUSrcA = 0;
        ALUSrcB = 1;

        // nor4: 测试异或运算，ALUSrcA=1, ALUSrcB=1
        #50;
        ReadData1 = 32'd1;
        ReadData2 = 32'd2;
        Ext = 32'd2;
        Sa = 5'b00001;
        ALUop = 3'b111;
        ALUSrcA = 1;
        ALUSrcB = 1;

        // 结束仿真
        #50;
        $stop; // 停止仿真
    end

endmodule