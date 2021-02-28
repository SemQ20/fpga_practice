`timescale 1ns/1ns
`include "../main.v"

module tb_main();

reg clk;
reg [5:0] address;
reg enable;
wire [31:0] data;
wire [31:0] data_out;
wire keys_flag;

initial begin
    clk <= 1'b0;
    address <= 5'b00000;
    enable <= 1'b1;
end

always #125 clk = !clk;

always @(posedge clk) begin
    if(keys_flag) begin
        if(address == 31) begin
        address <= 5'b00000;
    end else begin
        address <= address + 1;
    end
    end
end

main dut(.clk(clk),.address(address),.enable(enable),.data(data),.data_out(data_out));
endmodule