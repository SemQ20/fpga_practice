module key(
    input clk,
    input enable,
    input [5:0]address,
    input [31:0]data_in,
    output reg [31:0]data_out
);
reg [31:0] key_storage[7:0];
reg [31:0] iteration_key[31:0];

reg [5:0]i;
reg [3:0]j;

    initial begin
        j <= 0;
        /* key_storage[0] = 32'hFFEEDDCC;
        key_storage[1] = 32'hBBAA9988;
        key_storage[2] = 32'h77665544;
        key_storage[3] = 32'h33221100;
        key_storage[4] = 32'hF0F1F2F3;
        key_storage[5] = 32'hF4F5F6F7;
        key_storage[6] = 32'hF8F9FAFB;
        key_storage[7] = 32'hFCFDFEFF; */
    end
    /* for tests: */
    always @(posedge clk) begin
        if(enable) begin
            key_storage[address] <= data_in;
        end
    end

    always @(negedge clk) begin
        if(!enable) begin
            data_out <= iteration_key[address];
        end
    end

    always @(*) begin
        if(key_storage[7])begin
            for(i = 0; i <= 31; i = i + 1) begin
            if(i == 24) j = 7;
            if(i <= 23) begin
                if(j == 8) j = 0;
                iteration_key[i] = key_storage[j];
                j = j + 1;
            end else begin
                iteration_key[i] = key_storage[j];
                j = j - 1;
            end
        end
        end
    end

endmodule