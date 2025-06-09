module controller(
    input  [6:0] op,    
    input  [2:0] funct3,
    input        funct7b5, Zero,
    output [1:0] ResultSrc,
    output       MemWrite, PCSrc,
    output       ALUSrc, RegWrite,
    output       Jump,
    output [1:0] ImmSrc,
    output [2:0] ALUControl
    );

  wire [1:0] ALUOp;
  wire       Branch;

  maindec md(op, RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, ALUOp);
  aludec  ad(ALUOp, funct7b5, funct3, ALUControl);

  assign Branch = (op == 7'b1100011);
  assign PCSrc = Branch & Zero;
  assign Jump  = 1'b0;
endmodule