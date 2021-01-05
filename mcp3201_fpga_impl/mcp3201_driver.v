`timescale 1 ns/ 1ps;

module mcp3201_driver(
    input sys_clk,
    input clock_ena,
    input spi_in,
    output spi_chip_select,
    output spi_clk,
    output [11:0] odata,
    output reg out_data_valid
);
    reg [32:0] sr;
    reg [11:0] sr_data_in;
    reg [11:0] data;
    reg [32:0] sr_chip_select;
    reg spi_clk_tmp;
    reg spi_ncs;
    reg spi_clk_dff;
    reg spi_ncs_dff;
    wire data_valid;
    wire odata_valid;
    
    initial begin
      sr_chip_select <= 33'b111_0000_0000_0000_0000_0000_0000_0000_00;
      sr             <= 33'b000_0101_0101_0101_0101_0101_0101_0101_01;
    end
    always @(posedge sys_clk) begin
      if(clock_ena) begin
        sr <= {sr[31:0], sr[32]};
      end
        spi_clk_tmp <= sr[32];
    end
//shift register
    always @(posedge sys_clk) begin
      if(clock_ena) begin
        sr_chip_select <= {sr_chip_select[31:0], sr_chip_select[32]};
      end
        spi_ncs <= sr_chip_select[32];
    end
// pause for 200ns (one pulse sys clock) for synchronus geting data
	always @(posedge sys_clk) begin
    	  spi_clk_dff <= spi_clk;
      if((spi_clk == 1'b1) && (spi_clk_dff == 1'b0)) begin
        out_data_valid <= 1'b1;
      end else begin
        out_data_valid <= 1'b0;
      end
	end

	always @(posedge sys_clk) begin
     if(data_valid) begin
        sr_data_in <= {sr_data_in[10:0], spi_in};
     end
    	 end
// combinatorical variant (sync off)			
	assign data_valid = ((spi_clk == 1'b1) && (spi_clk_dff == 1'b0)) ?  1'b1 : 1'b0;
//sync off
	always @(posedge sys_clk) begin
		spi_ncs_dff <= spi_ncs;
	end

  	assign odata_valid = ((spi_ncs == 1'b1) && (spi_ncs_dff == 1'b0)) ?  1'b1 : 1'b0;

	always @(posedge sys_clk) begin
	  if(odata_valid) begin
		  data <= sr_data_in;
	 end
	end

	assign odata = data;
	
        assign spi_chip_select = spi_ncs;
        assign spi_clk         = spi_clk_tmp;

endmodule
