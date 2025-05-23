module program_ctr #(parameter N=32)(

input clk,
input [N-1:0] pcNext,
output reg [N-1:0] pc

);

always @(posedge clk)
    begin
        pc <= pcNext;
    end

endmodule