module alu(
    input [31:0] a,
    input [31:0] b,
    input [2:0] alucontrol,
    output reg [31:0] result
);

  always @(*)
    case (alucontrol)
      3'b000:  result = a & b;            // AND
      3'b001:  result = a | b;            // OR
      3'b010:  result = a + b;            // ADD
      3'b110:  result = a - b;            // SUB
      3'b111:  result = (a < b) ? 32'b1 : 32'b0; // SLT
      default: result = 32'bx;
    endcase

endmodule
