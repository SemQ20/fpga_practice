`timescale 1ns/1ns
/* for autocomplete: */
`include "../ram_16x8.v" 

module tb_ram ();

reg clk;
reg write;
reg [3:0]address[1:0];
reg [7:0]data;
wire [7:0]data_out;

    initial begin
        clk   <= 1'b0;
        write <= 1'b0;
        address[0] <= 4'b0000;
        address[1] <= 4'b0001;
        data <= 8'b11100001;
    end
    always @(*) begin
    forever begin
        #10;
        clk   <= !clk;
        //write <= !write;
        //#10;
    end
    end
    ram_16x8 dut(.clk(clk), .write_en(write),.address1(address[0]),.address2(address[1]),.data_in(data),.data_out(data_out));
endmodule
