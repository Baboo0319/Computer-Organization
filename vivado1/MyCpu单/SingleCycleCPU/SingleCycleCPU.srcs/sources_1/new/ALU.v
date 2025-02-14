module ALU(
    // 定义ALU模块的输入和输出端口
    input [31:0] ReadData1,      // 第一个操作数，来自寄存器文件
    input [31:0] ReadData2,      // 第二个操作数，来自寄存器文件
    input [31:0] Ext,            // 扩展后的立即数（用于某些指令）
    input [4:0] Sa,              // 移位量（通常由shamt字段提供）
    input [2:0] ALUop,           // 指定要执行的操作类型
    input ALUSrcA,               // 控制信号：选择InA的来源（ReadData1或Sa）
    input ALUSrcB,               // 控制信号：选择InB的来源（ReadData2或Ext）

    output  zero,            // 输出信号：当Result为0时置1
    output reg [31:0] Result,     // 运算结果输出
    output sign                  //blez
);

    // 内部连接线，用于表示实际参与运算的操作数
    wire [31:0] InA;             // 实际参与运算的第一个操作数
    wire [31:0] InB;             // 实际参与运算的第二个操作数

    // 根据控制信号ALUSrcA选择InA的来源：
    // 如果ALUSrcA为1，则InA = {27'b0, Sa}（即高27位为0，低5位为Sa）
    // 否则，InA = ReadData1
    assign InA = ALUSrcA ? {{27{1'b0}}, Sa} : ReadData1;

    // 根据控制信号ALUSrcB选择InB的来源：
    // 如果ALUSrcB为1，则InB = Ext（扩展后的立即数）
    // 否则，InB = ReadData2
    assign InB = ALUSrcB ? Ext : ReadData2;

    // 计算零标志位zero：如果Result为全0，则zero置1；否则为0
    assign zero = (Result == 32'b0) ? 1 : 0;
    
    assign sign=($signed(Result) <= 0) ? 1:0;
    // 组合逻辑块，当任何输入发生变化时自动重新计算Result
    always @(*) begin
        case(ALUop) // 根据ALUop的值选择执行不同的运算功能
            3'b000 : 
                Result = InA + InB;                    // 加法操作
            3'b001:
                Result = InA - InB;                    // 减法操作
            3'b010:
                Result = InB << InA[4:0];              // 左移逻辑操作（使用Sa的低5位作为移位数量）
            3'b011:
                Result = InA | InB;                    // 或运算
            3'b100:
                Result = InA & InB;                    // 与运算
            3'b101:
                Result = (InA < InB) ? 32'b1 : 32'b0; // 无符号小于比较（返回32位的1或0）
            3'b110: 
                Result = (((InA < InB) && (InA[31] == InB[31])) || 
                          ((InA[31] == 1'b1) && (InB[31] == 1'b0))) ? 32'b1 : 32'b0; // 带符号小于比较
            3'b111:
                Result = InA ^ InB;                    // 异或运算
            default:
                Result = 32'h00000000;                 // 默认情况，将Result清零
        endcase
    end

endmodule