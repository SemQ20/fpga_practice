`timescale 1ns/1ns
/* for autocomplete: */
`include "../key.v"

module tb_key ();

    reg clk;
    reg enable;
    reg [5:0] address;
    wire [31:0] data;
    reg [31:0] key_storage[7:0];
    reg [31:0]data_in;
    reg [5:0]i;
    initial begin
        i <= 6'b000000;
        clk <= 1'b0;
        address <= 5'd0;
        enable <= 1'b1;
        key_storage[0] = 32'hFFEEDDCC;
        key_storage[1] = 32'hBBAA9988;
        key_storage[2] = 32'h77665544;
        key_storage[3] = 32'h33221100;
        key_storage[4] = 32'hF0F1F2F3;
        key_storage[5] = 32'hF4F5F6F7;
        key_storage[6] = 32'hF8F9FAFB;
        key_storage[7] = 32'hFCFDFEFF;
    end

    always #10 clk = ~clk;

    always @(posedge clk) begin
        data_in <= key_storage[i];
        if(i == 0) address <= 5'd0; else begin
          // enable <= 1'b1;
           address <= address + 1; 
        end
        i = i + 1;
    end
    
    always @(*) begin
        if(address == 32) begin
            address = 5'b00000;
        end

        if(i == 9) begin
           enable <= 1'b0;
           address <= 5'b11111;
        end
    end

    key dut(.clk(clk), .enable(enable), .address(address),.data_in(data_in), .data_out(data));

endmodule