module extend(
    input  [31:7] instr,
    input  [1:0]  immsrc,
    output [31:0] immext
    );

  reg [31:0] imm;
  assign immext = imm;

  wire [31:0] imm_i = {{21{instr[31]}}, instr[30:25], instr[24:20]};
  wire [31:0] imm_s = {{21{instr[31]}}, instr[30:25], instr[11:7]};
  wire [31:0] imm_b = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};

  always @(*)
    case(immsrc)
      2'b00: imm = imm_i;
      2'b01: imm = imm_s;
      2'b10: imm = imm_b;
      default: imm = 32'bx;
    endcase
endmodule