module aludec(
    input  [1:0] ALUOp,
    input funct7b5,
    input  [2:0] funct3,
    output [2:0] ALUControl
    );

  reg [2:0] control;
  assign ALUControl = control;

  always @(*)
    case (ALUOp)
      2'b00:  control = 3'b010;
      2'b01:  control = 3'b110;
      default:
        case(funct3)
          3'b000: control = (funct7b5 ? 3'b110 : 3'b010);
          3'b010: control = 3'b111;
          3'b110: control = 3'b001;
          3'b111: control = 3'b000;
          default: control = 3'bxxx;
        endcase
    endcase
endmodule