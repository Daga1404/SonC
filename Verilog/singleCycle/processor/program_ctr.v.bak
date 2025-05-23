module program_ctr #(parameter N=32)(

input clk,
input [N-1:0] pcNext,
output [N-1:0] pc

);

always @(posedge clk)
    begin
        pc<=pcNext;
    end

endmodule