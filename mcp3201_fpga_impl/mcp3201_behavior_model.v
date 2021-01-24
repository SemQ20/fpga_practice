`timescale 1ns / 1 ps

module mcp_3201_behavior_model(
    input clk,
    input chip_select,
    output data_adc_out
);

reg [11:0] data;
reg dout;
integer i;

    initial begin
        dout <= 1'bz;
	data <= 12'b111111111111;
    end
	
    initial begin
    forever begin
      //data = data - 1;
      data = $urandom_range(2**12 - 1);
      @(negedge chip_select);
      // wait one pulse
      @(posedge clk);
      @(negedge clk);
      // wait one pulse
      @(posedge clk);
      @(negedge clk);

      dout = 1'b0;

      for(i = 11; i <= 0; i = i - 1) begin
	@(posedge clk);
      	@(negedge clk)
      	dout = data[i];
      end

      @(posedge chip_select);
      dout = 1'bz;
    end
end
    assign data_adc_out = dout;
endmodule

