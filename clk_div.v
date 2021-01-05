module clk_div(
    input in_sys_clk,
    output out_clock_ena
);

reg [1:0] cnt;
reg ce;
    initial begin
      cnt <= 1'b0;
      ce  <= 1'b0;
    end
    always @(posedge in_sys_clk) begin
      if(cnt == 1) begin
          ce <= 1'b1;
          cnt <= 0;
      end  else begin
          ce <= 1'b0;
	  cnt <= cnt + 1'b1;
      end
          //cnt <= cnt + 1'b1;
    end

    assign out_clock_ena = ce;
endmodule

