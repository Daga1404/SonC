module alu (
    input [31:0] src_a, src_b,
    input [2:0] alu_control,

    output reg [31:0] alu_result,
    output reg zero
);

always @(*)
    begin
        case (alu_control)
            3'b000: // add
                alu_result = src_a + src_b;
            3'b001: // sub
                alu_result = src_b - src_a;
            3'b010: // and
                alu_result = src_a & src_b;
            3'b011: // or
                alu_result = src_a | src_b;
            3'b101: // slt
                alu_result = (src_a < src_b) ? 1 : 0;
            3'b110: // mul
                alu_result = src_a * src_b;
            default: // default to add
                alu_result = src_a + src_b;
            
        endcase
    end
    
endmodule