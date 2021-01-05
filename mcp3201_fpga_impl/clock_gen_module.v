`timescale 1ns/1ps

module clock_gen_module(
    output sys_clk
);
    always
        #200;
        assign sys_clk = !sys_clk;
endmodule
