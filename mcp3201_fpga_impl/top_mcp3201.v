module top_mcp3201(
    input in_sys_clk, // 5Mhz
    input in_sys_data,
    output out_sys_clk,
    output out_sys_ncs
);
    //wire spi_clk;
    wire ce;
    wire adc_data_valid;
    wire [11:0] adc_data;

    // need to generate 5 Mhz(period = 200 ns) clk for divide
    // frequency to 1.25 Mhz
    
    clk_div inst_clk_div(
        .in_sys_clk(in_sys_clk),
        .out_clock_ena(ce) // 1.25 Mhz
    );
    
    mcp3201_driver inst_mcp3201_driver(
        .sys_clk(in_sys_clk),
        .clock_ena(ce),
        .spi_chip_select(out_sys_ncs),
        .spi_in(in_sys_data),
        .spi_clk(out_sys_clk),
        .odata(adc_data),
        .out_data_valid(adc_data_valid)
    );

    //assign out_sys_clk = spi_clk;
endmodule
