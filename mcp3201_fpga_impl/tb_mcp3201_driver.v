`timescale 1ns/ 1ps

module tb_mcp3201_driver();

reg clock_5Mhz;
wire spi_clk;
wire spi_ncs;
wire spi_data_in;
//reg sys_clk;
    initial begin
      clock_5Mhz <= 1'b0;
    end
    always @(*) #100 clock_5Mhz <= ~clock_5Mhz;

        top_mcp3201 inst_top_mcp3201(
            .in_sys_clk(clock_5Mhz),
            .in_sys_data(spi_data_in),
            .out_sys_clk(spi_clk),
            .out_sys_ncs(spi_ncs)
        );

        mcp_3201_behavior_model inst_model(
            .clk(spi_clk),
            .chip_select(spi_ncs),
            .data_adc_out(spi_data_in)
        );
endmodule

