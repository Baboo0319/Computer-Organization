`timescale 1ns / 1ps

module change(
    input myCLK,
    input Reset,
    input [3:0] AN,//数码管显示的位置决定信号
    input [2:0] SW,//显示的数据内容决定信号
    input [31:0] aluResult,
    input [31:0] curPC,
    input [31:0] newPC,
    input [31:0] writeData,
    input [31:0] regRs,
    input [31:0] regRt,
    input [31:0] instruction,
    output reg [3:0] store
);

always@ (myCLK) begin
    if (!Reset)
        store <= 4'b0000;
    else begin
        case(AN)
            4'b1110 : begin // AN0
                case(SW)
                    2'b00: store <= newPC[3:0];
                    2'b01: store <= regRs[3:0];
                    2'b10: store <= regRt[3:0];
                    2'b11: store <= writeData[3:0];
                endcase
            end
            4'b1101 : begin // AN1
                case(SW)
                    2'b00: store <= newPC[7:4];
                    2'b01: store <= regRs[7:4];
                    2'b10: store <= regRt[7:4];
                    2'b11: store <= writeData[7:4];
                endcase
            end
            4'b1011 : begin // AN2
                case(SW)
                    2'b00: store <= curPC[3:0];
                    2'b01: store <= instruction[24:21];
                    2'b10: store <= instruction[19:16];
                    2'b11: store <= aluResult[3:0];
                endcase
            end
            4'b0111 : begin // AN3
                case(SW)
                    2'b00: store <= curPC[7:4];
                    2'b01: store <= { 3'b000,instruction[25] };
                    2'b10: store <= { 3'b000,instruction[20] };
                    2'b11: store <= aluResult[7:4];
                endcase
            end
        endcase
    end
end

endmodule
//SW_in = 00： 显示 当前 PC值:下条指令PC值
//SW_in = 01： 显示 RS寄存器地址:RS寄存器数据
//SW_in = 10： 显示 RT寄存器地址:RT寄存器数据
//SW_in = 11： 显示 ALU结果输出 :DB总线数据。
