module maindec(
    input  [6:0] op,
    output       RegWrite,
    output [1:0] ImmSrc,
    output       ALUSrc,
    output       MemWrite,
    output       ResultSrc,
    output [1:0] ALUOp);

  reg [8:0] controls;
  assign {RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, ALUOp} = controls;

  always @(*)
    case(op)
      7'b0000011: controls = 9'b1_00_1_0_1_00;
      7'b0100011: controls = 9'b0_01_1_1_0_00;
      7'b1100011: controls = 9'b0_10_0_0_0_01;
      7'b0010011: controls = 9'b1_00_1_0_0_00;
      7'b0110011: controls = 9'b1_00_0_0_0_10;
      default:    controls = 9'b0_00_0_0_0_00;
    endcase
endmodule