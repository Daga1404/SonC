`timescale 1ns / 1ps

module riscvpipeline_tb;

  reg clk, reset;
  wire [31:0] PC, ALUResult, WriteData;
  wire MemWrite_out;

  reg [31:0] imem [0:63];  // Simulated instruction memory
  reg [31:0] dmem [0:63];  // Simulated data memory

  wire [31:0] Instr = imem[PC[31:2]];
  wire [31:0] ReadData = dmem[ALUResult[31:2]];

  riscvpipeline uut(
    .clk(clk),
    .reset(reset),
    .PC(PC),
    .Instr(Instr),
    .ReadData(ReadData),
    .ALUResult(ALUResult),
    .WriteData(WriteData),
    .MemWrite_out(MemWrite_out)
  );

  // Clock generation: 10 ns period
  always #5 clk = ~clk;

  // Monitor memory writes
  always @(posedge clk) begin
    if (MemWrite_out) begin
      dmem[ALUResult[31:2]] <= WriteData;
      $display("MEM[%0d] <- %h @ time %0t", ALUResult >> 2, WriteData, $time);
    end
  end

  initial begin
    // Initialize memories
    $readmemh("riscvtest.txt", imem);
    $display("Instruction memory loaded.");

    clk = 0;
    reset = 1;
    #10;
    reset = 0;

    // Simulation duration
    #1000;

    // Dump memory for inspection
    $display("\n--- Data Memory ---");
    $display("Address   Data");
    for (int i = 0; i < 16; i = i + 1)
      $display("  %2d     %h", i, dmem[i]);

    $finish;
  end

endmodule
