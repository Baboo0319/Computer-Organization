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

        //��ʼ��
        CLK = 0;
        DAddr = 0;
        DataIn = 0;
        RD = 0;    //Ϊ1����������Ϊ0���������̬���൱�ڿ�·��
        WR = 0;   //Ϊ1��д��Ϊ0���޲���

        #30;//30ns��CLK�½���д
            DAddr = 1;
            DataIn = 8;
            RD = 0;
            WR = 1;

        #30;//60ns��CLK�½���д
            DAddr = 2;
            DataIn = 12;
            RD = 0;
            WR = 1;

        #30;//90ns��ʼ��
            DAddr = 1;
            RD = 1;
            WR = 0;

        #30;//120ns��ʼ��
            DAddr = 2;
            RD = 1;
            WR = 0;

        #30;
            $stop;//150ns��ͣ

    end

endmodule

