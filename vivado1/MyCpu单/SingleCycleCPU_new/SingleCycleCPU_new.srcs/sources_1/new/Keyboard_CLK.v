`timescale 1ns / 1ps

module Keyboard_CLK(
    input clk_sys,
    input reset,
    input key, //原始按键信号
    output debkey  //消抖后的按键信号
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

assign debkey = key_rrr & key_rr & key_r;//只有当连续三次采样的按键状态都为高电平时，debkey才会为高电平

endmodule
