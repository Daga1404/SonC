module id_ex(input         clk, reset,
             input  [31:0] pc_in, rd1_in, rd2_in, immext_in,
             input  [4:0]  rs1_in, rs2_in, rd_in,
             input  [2:0]  alucontrol_in,
             input         alusrc_in, regwrite_in, memwrite_in,
             input  [1:0]  resultsrc_in,
             output reg [31:0] pc_out, rd1_out, rd2_out, immext_out,
             output reg [4:0]  rs1_out, rs2_out, rd_out,
             output reg [2:0]  alucontrol_out,
             output reg        alusrc_out, regwrite_out, memwrite_out,
             output reg [1:0]  resultsrc_out);

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      pc_out <= 0; rd1_out <= 0; rd2_out <= 0; immext_out <= 0;
      rs1_out <= 0; rs2_out <= 0; rd_out <= 0;
      alucontrol_out <= 0;
      alusrc_out <= 0; regwrite_out <= 0; memwrite_out <= 0; resultsrc_out <= 0;
    end else begin
      pc_out <= pc_in; rd1_out <= rd1_in; rd2_out <= rd2_in; immext_out <= immext_in;
      rs1_out <= rs1_in; rs2_out <= rs2_in; rd_out <= rd_in;
      alucontrol_out <= alucontrol_in;
      alusrc_out <= alusrc_in; regwrite_out <= regwrite_in;
      memwrite_out <= memwrite_in; resultsrc_out <= resultsrc_in;
    end
  end
endmodule