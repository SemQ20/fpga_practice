module  ram_16x8(
    input clk,
    input write_en, /* if true - write, if false - read */
    input [3:0]address1,/* address of memory cell - ROW */
    input [3:0]address2,/* address of memory cell - CELL */
    input [7:0] data_in,
    output reg [7:0] data_out
);
/* placing table 128 bit, depth - 4 bit */
reg [3:0] space[7:0][15:0];
    initial begin
        $readmemh("../table.txt",space);
    end
   always @(posedge clk) begin
       if(write_en) begin
           space[address1][address2] <= data_in;
       end
   end

   always @(posedge clk) begin
       if(!write_en) begin
           assign data_out = space[address1][address2];
       end
   end
endmodule