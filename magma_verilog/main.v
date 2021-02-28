module main(
    input  clk,
    /* for tests */
    input  [5:0]address,
    //input  [3:0]address2,
    /* ****************** */
    input  enable,
    output reg [31:0]data,
    output reg [31:0]data_out
);

wire [31:0] replace;
wire [31:0] addmod32;
wire [31:0] shift11;

reg [31:0] mask;
reg [31:0] key_storage[7:0];
reg [63:0] inf_buf;
reg [3:0]  space[7:0][15:0];
reg [31:0] iteration_key[31:0];
reg [5:0]  i;
reg [3:0]  j;
reg [5:0]  kindex;
reg [1:0]  iteration_keys_flag;
reg [1:0]  RUN;
reg [1:0]  EN_CLK;

assign addmod32 = (iteration_key[kindex] + inf_buf[31:0]) & mask;
assign replace[31:24] = (space[0][addmod32[31:28]] << 4 | space[1][addmod32[27:24]]);
assign replace[23:16] = (space[2][addmod32[23:20]] << 4 | space[3][addmod32[19:16]]); 
assign replace[15:8]  = (space[4][addmod32[15:12]] << 4 | space[5][addmod32[11:8]]);
assign replace[7:0]   = (space[6][addmod32[7:4]]   << 4 | space[7][addmod32[3:0]]);
assign shift11 = {replace[20:0], replace[31:21]};

    initial begin
        iteration_keys_flag <= 1'b0;
        mask  <= 32'hffffffff;
        RUN <= 1'b0;
        kindex <= 0;
        EN_CLK <= 1'b0;
        inf_buf <= 64'hfedcba9876543210; // test info
        key_storage[0] = 32'hFFEEDDCC;
        key_storage[1] = 32'hBBAA9988;
        key_storage[2] = 32'h77665544;
        key_storage[3] = 32'h33221100;
        key_storage[4] = 32'hF0F1F2F3;
        key_storage[5] = 32'hF4F5F6F7;
        key_storage[6] = 32'hF8F9FAFB;
        key_storage[7] = 32'hFCFDFEFF;
        $readmemh("../table.txt",space);
    end
    
    always @(posedge clk) begin
        if(i == 32) begin 
            iteration_keys_flag <= 1'b1;
        end
        if(!iteration_keys_flag) begin
            j <= 4'b0000;
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

    always @(posedge clk) begin
        if(iteration_keys_flag && !EN_CLK) begin
            if(kindex == 31) begin
                {inf_buf[63:32]} <= {inf_buf[63:32]^shift11};
                kindex = 0;
                RUN <= 1'b1;
                EN_CLK <= 1'b1;
            end else begin
                {inf_buf[63:32], inf_buf[31:0]} <= {inf_buf[31:0],inf_buf[63:32]^shift11};
                kindex = kindex + 1;
            end
        end
    end
    
    always @(posedge clk) begin
        if(RUN) begin
            data <= inf_buf[31:0];
            data_out <= inf_buf[63:32];
            RUN <= 1'b0;
        end
    end

endmodule


