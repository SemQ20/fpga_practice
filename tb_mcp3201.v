`timescale 1ns / 1ps

module tb_mcp3201();
    reg clk;
    reg ncs;
    wire dout;

    initial begin
      forever begin
        ncs = 1'b1;
        #10; // 10 ns
        ncs <= 1'b0;
        clk <= 1'b0;
        #10; // 10 ns
        // period = 20 ns = 50 Mhz
        clk <= 1'b1;
        #10;
        clk <= 1'b0;
        #10;

        clk <= 1'b1;
        #10;
        clk <= 1'b0;
        #10;

        clk <= 1'b1;
        #10;
        clk <= 1'b0;
        #10;

        clk <= 1'b1;
        #10;
        clk <= 1'b0;
        #10;

        clk <= 1'b1;
        #10;
        clk <= 1'b0;
        #10;

        clk <= 1'b1;
        #10;
        clk <= 1'b0;
        #10;

        clk <= 1'b1;
        #10;
        clk <= 1'b0;
        #10;

        clk <= 1'b1;
        #10;
        clk <= 1'b0;
        #10;

        clk <= 1'b1;
        #10;
        clk <= 1'b0;
        #10;

        clk <= 1'b1;
        #10;
        clk <= 1'b0;
        #10;

        clk <= 1'b1;
        #10;
        clk <= 1'b0;
        #10;

        clk <= 1'b1;
        #10;
        clk <= 1'b0;
        #10;

        clk <= 1'b1;
        #10;
        clk <= 1'b0;
        #10;

        clk <= 1'b1;
        #10;
        clk <= 1'b0;
        #10;

        clk <= 1'b1;
        #10;
        clk <= 1'b0;
        #10;
      end

    end

    mcp_3201_behavior_model dut(
        .clk(clk), 
        .chip_select(ncs),
        .data_adc_out(dout)
    );


endmodule

