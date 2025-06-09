module ex_mem(
    input clk,
    input reset,
    input [31:0] aluout_in,
    input [31:0] writedata_in,
    input [4:0]  writereg_in,
    output reg [31:0] aluout_out,
    output reg [31:0] writedata_out,
    output reg [4:0]  writereg_out
);

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      aluout_out <= 0;
      writedata_out <= 0;
      writereg_out <= 0;
    end else begin
      aluout_out <= aluout_in;
      writedata_out <= writedata_in;
      writereg_out <= writereg_in;
    end
  end

endmodule
