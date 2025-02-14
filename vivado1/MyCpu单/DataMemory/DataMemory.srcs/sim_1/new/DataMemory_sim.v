`timescale 1ns / 1ps

module DataMemory_sim;

    // input
    reg CLK;
    reg [31:0] DAddr;
    reg [31:0] DataIn;
    reg RD;
    reg WR;

    //otput
    wire [31:0] DataOut;

    DataMemory uut(
        .CLK(CLK),
        .DAddr(DAddr),
        .DataIn(DataIn),
        .RD(RD),
        .WR(WR),
        .DataOut(DataOut)
    );

    always #15 CLK = !CLK;

    initial begin
        //record
        $dumpfile("DataMemory.vcd");
        $dumpvars(0, DataMemory_sim);

        //初始化
        CLK = 0;
        DAddr = 0;
        DataIn = 0;
        RD = 0;    //为1，正常读；为0，输出高阻态（相当于开路）
        WR = 0;   //为1，写；为0，无操作

        #30;//30ns后，CLK下降沿写
            DAddr = 1;
            DataIn = 8;
            RD = 0;
            WR = 1;

        #30;//60ns后，CLK下降沿写
            DAddr = 2;
            DataIn = 12;
            RD = 0;
            WR = 1;

        #30;//90ns后开始读
            DAddr = 1;
            RD = 1;
            WR = 0;

        #30;//120ns后开始读
            DAddr = 2;
            RD = 1;
            WR = 0;

        #30;
            $stop;//150ns后停

    end

endmodule

