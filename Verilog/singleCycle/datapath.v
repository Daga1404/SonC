module datapath(
    input         clk, reset,
    input  [1:0]  ResultSrc,
    input         PCSrc, ALUSrc, RegWrite,
    input  [2:0]  ALUControl,
    input  [1:0]  ImmSrc,
    output        Zero,
    input  [31:0] Instr,
    output [31:0] PC,
    input  [31:0] ReadData,
    output [31:0] ALUResult,
    output [31:0] WriteData);

  wire [31:0] PCNext, PCTarget, PCPlus4;
  wire [31:0] ImmExt;
  wire [31:0] SrcA, SrcB;
  reg  [31:0] Result;

  assign PCPlus4  = PC + 4;
  assign PCTarget = PC + ImmExt;
  assign PCNext   = PCSrc ? PCTarget : PCPlus4;

  flopr #(32) pcreg(clk, reset, PCNext, PC);

  regfile rf(clk, RegWrite, Instr[19:15], Instr[24:20], Instr[11:7],
             Result, SrcA, WriteData);

  extend ext(Instr[31:7], ImmSrc, ImmExt);

  assign SrcB = ALUSrc ? ImmExt : WriteData;
  alu alu(SrcA, SrcB, ALUControl, ALUResult, Zero);

  always @(*)
    case (ResultSrc)
      2'b00: Result = ALUResult;
      2'b01: Result = ReadData;
      2'b10: Result = PCPlus4;
      default: Result = 32'bx;
    endcase
endmodule