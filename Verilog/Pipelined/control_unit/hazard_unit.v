module hazard_unit(input  [4:0] rs1D, rs2D, rdE,
                   input        memreadE,
                   output reg   stallF, stallD, flushE);

  always @(*) begin
    if (memreadE && ((rdE == rs1D) || (rdE == rs2D))) begin
      stallF = 1;
      stallD = 1;
      flushE = 1;
    end else begin
      stallF = 0;
      stallD = 0;
      flushE = 0;
    end
  end
endmodule