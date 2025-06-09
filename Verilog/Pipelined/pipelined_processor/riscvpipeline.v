module riscvpipeline(input         clk, reset,
                     output [31:0] PC,
                     input  [31:0] Instr,
                     input  [31:0] ReadData,
                     output [31:0] ALUResult,
                     output [31:0] WriteData,
                     output        MemWrite_out);

  wire [1:0] ResultSrc;
  wire       PCSrc, ALUSrc, RegWrite, Jump;
  wire [2:0] ALUControl;
  wire [1:0] ImmSrc;
  wire       Zero;
  wire       memwrite_ctrl;

  // Controller
  controller c(
    .op(Instr[6:0]),
    .funct3(Instr[14:12]),
    .funct7b5(Instr[30]),
    .Zero(Zero),
    .ResultSrc(ResultSrc),
    .MemWrite(memwrite_ctrl),
    .PCSrc(PCSrc),
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite),
    .Jump(Jump),
    .ImmSrc(ImmSrc),
    .ALUControl(ALUControl)
  );

  assign MemWrite_out = memwrite_ctrl;

  // Pipelined Datapath
  pipelined_datapath dp(
    .clk(clk), .reset(reset),
    .instrF(Instr), .readdataM(ReadData),
    .pcF(PC), .aluoutM(ALUResult), .writedataM(WriteData)
  );
endmodule
