module riscvsingle(
    input         clk, reset,
    output [31:0] PC,
    input  [31:0] ReadData,
    output [31:0] ALUResult,
    output [31:0] WriteData,
    output        MemWrite);

  wire [31:0] Instr;
  wire [1:0]  ResultSrc;
  wire        PCSrc, ALUSrc, RegWrite, Jump;
  wire [2:0]  ALUControl;
  wire [1:0]  ImmSrc;
  wire        Zero;

  imem imem(PC, Instr);

  controller c(Instr[6:0], Instr[14:12], Instr[30], Zero,
               ResultSrc, MemWrite, PCSrc, ALUSrc,
               RegWrite, Jump, ImmSrc, ALUControl);

  datapath dp(clk, reset, ResultSrc, PCSrc, ALUSrc, RegWrite,
              ALUControl, ImmSrc, Zero, Instr, PC,
              ReadData, ALUResult, WriteData);
endmodule