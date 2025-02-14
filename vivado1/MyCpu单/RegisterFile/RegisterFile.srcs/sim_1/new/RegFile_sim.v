`timescale 1ns / 1ps

module RegFile_sim();
    // 定义输入信号为寄存器类型
    reg CLK;                  // 时钟信号
    reg RegDst;               // 寄存器目标选择信号：为1时选择rd作为目标寄存器，为0时选择rt作为目标寄存器
    reg RegWre;               // 寄存器写使能信号：为1时允许写入寄存器
    reg DBDataSrc;            // 数据源选择信号：为1时从数据存储器读取，为0时从ALU读取
   // reg [5:0] Opcode;         // 指令操作码（目前在模块中未使用）
    reg [4:0] rs, rt, rd;     // 源寄存器和目标寄存器编号
  //  reg [10:0] im;            // 立即数
    reg [31:0] dataFromALU;   // 来自ALU的数据
    reg [31:0] dataFromRW;    // 来自数据存储器或其它源的数据

    // 定义输出信号为线网类型
    wire [31:0] Data1;        // ALU运算的第一个输入A
    wire [31:0] Data2;        // ALU运算的第二个输入B

    // 实例化 RegisterFile 模块，并连接端口
    RegisterFile uut (
        .CLK(CLK),
        .RegDst(RegDst),
        .RegWre(RegWre),
        .DBDataSrc(DBDataSrc),
      //  .Opcode(Opcode),      // 目前在模块中未使用
        .rs(rs),
        .rt(rt),
        .rd(rd),
       // .im(im),
        .dataFromALU(dataFromALU),
        .dataFromRW(dataFromRW),

        .Data1(Data1),
        .Data2(Data2)
    );

    // 生成时钟信号，每15个时间单位翻转一次
    always #15 CLK = !CLK;

    initial begin
        // 设置波形记录文件
        $dumpfile("RegisterFile.vcd"); // 波形文件名
        $dumpvars(0, RegFile_sim);     // 记录所有变量

        // 初始化
        CLK = 0;
        RegDst = 0;
        RegWre = 0;
        DBDataSrc = 0;
       // Opcode = 6'b000000; // 虽然目前在模块中未使用，但可以保留以备将来使用
        rs = 5'b00000;
        rt = 5'b00000;
        rd = 5'b00000;
       // im = 11'b0;
        dataFromALU = 32'd0;
        dataFromRW = 32'd0;

        // Test1: 处理R型指令，写入寄存器，使用来自ALU的输出
        #10;
        CLK = 0;
        RegDst = 1;           // 处理R型指令
        RegWre = 1;           // 允许写寄存器
        DBDataSrc = 0;        // 使用来自ALU的输出
     //   Opcode = 6'b000000;   // R型指令的操作码
        rs = 5'b00000;
        rt = 5'b00001;
        rd = 5'b00010;
      //  im = 11'b0;
        dataFromALU = 32'd1;  // 来自ALU的输出
        dataFromRW = 32'd2;   // 来自RW的输出

        // 提供一个完整的时钟周期
        #30;

        // Test2: 不处理R型指令，不允许写寄存器，使用来自数据存储器的输出
        RegDst = 0;           // 处理I型指令
        RegWre = 0;           // 不允许写寄存器
        DBDataSrc = 1;        // 使用来自数据存储器的输出
       // Opcode = 6'b000000;   // I型指令的操作码（假设无效）
        rs = 5'b00011;
        rt = 5'b00100;
        rd = 5'b00101;
      //  im = 11'd10;
        dataFromALU = 32'd3;  // 来自ALU的输出
        dataFromRW = 32'd4;   // 来自RW的输出

       #30;     
        // 结束仿真
        $stop;                // 停止仿真
    end
endmodule
