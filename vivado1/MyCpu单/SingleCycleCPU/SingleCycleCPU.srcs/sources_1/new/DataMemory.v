`timescale 1ns / 1ps
module DataMemory(
    input CLK, // 时钟信号
    input wire [31:0] DAddr,  // 地址输入，用于指定访问的内存位置
    input wire [31:0] DataIn, // 数据输入，当进行写操作时，此为要写入的数据
    input RD,                 // 读使能信号：为1时允许读操作，为0时不进行读操作（或高阻态）
    input WR,                 // 写使能信号：为0时允许写操作，为1时禁止写操作或输出高阻态
    output wire [31:0] DataOut // 数据输出，当进行读操作时，从此输出读取的数据
);

// 定义一个8位宽、128个地址空间的内存数组
reg [7:0] Memory [0:127]; // 每个存储单元为8位，共有128个这样的存储单元

// 因为一条指令由四个存储单元存储，所以地址需要左移两位以乘以4
wire [31:0] address;
assign address = (DAddr << 2); // 将输入地址左移两位，相当于乘以4，得到实际的字节地址

// 读操作：如果RD为0，则从内存中读取数据；否则输出高阻态（'z')
assign DataOut[7:0]  = (RD == 0) ? Memory[address + 3] : 8'bz; // 最低字节
assign DataOut[15:8] = (RD == 0) ? Memory[address + 2] : 8'bz; // 第二个字节
assign DataOut[23:16] = (RD == 0) ? Memory[address + 1] : 8'bz; // 第三个字节
assign DataOut[31:24] = (RD == 0) ? Memory[address] : 8'bz; // 最高字节

// 写操作：在CLK的下降沿触发，如果WR为0，则将DataIn中的数据写入内存
always @ (negedge CLK) begin
    if(WR == 0) begin // 如果写使能信号为0，则执行写操作
        Memory[address] <= DataIn[31:24];   // 写入最高字节
        Memory[address + 1] <= DataIn[23:16]; // 写入第三个字节
        Memory[address + 2] <= DataIn[15:8];  // 写入第二个字节
        Memory[address + 3] <= DataIn[7:0];   // 写入最低字节
    end
end
 
endmodule
