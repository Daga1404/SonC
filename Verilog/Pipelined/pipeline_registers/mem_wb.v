module mem_wb(
    input clk,
    input reset,
    input [31:0] aluout_in,
    input [31:0] readdata_in,
    input [4:0]  writereg_in,
    output reg [31:0] aluout_out,
    output reg [31:0] readdata_out,
    output reg [4:0]  writereg_out
);

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      aluout_out <= 0;
      readdata_out <= 0;
      writereg_out <= 0;
    end else begin
      aluout_out <= aluout_in;
      readdata_out <= readdata_in;
      writereg_out <= writereg_in;
    end
  end

endmodule
