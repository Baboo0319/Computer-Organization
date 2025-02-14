`timescale 1ns / 1ps

module Keyboard_CLK(
    input clk_sys,
    input reset,
    input key, //ԭʼ�����ź�
    output debkey  //������İ����ź�
);

reg key_rrr, key_rr, key_r;

always @(posedge clk_sys or negedge reset)
    if (!reset)
        begin
            key_rrr <= 1'b1;
            key_rr <= 1'b1;
            key_r <= 1'b1;
        end
    else
        begin
            key_rrr <= key_rr;
            key_rr <= key_r;
            key_r <= key;
        end

assign debkey = key_rrr & key_rr & key_r;//ֻ�е��������β����İ���״̬��Ϊ�ߵ�ƽʱ��debkey�Ż�Ϊ�ߵ�ƽ

endmodule
