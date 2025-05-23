module mainFSM (
    input clk, rst, start,
    input [6:0] opcode,

    output reg [11:0] state,

    output reg adr_src, ir_write, pc_update, reg_write, mem_write, branch,
    output reg [1:0] alu_src_a, alu_src_b, alu_op, result_src
);
    parameter IDLE = 1;
    parameter FETCH = 2;
    parameter DECODE = 3;
    parameter MEM_ADR = 4;
    parameter MEM_READ = 5;
    parameter MEM_WB = 6;
    parameter MEM_WRITE = 7;
    parameter EXECUTE_R = 8;
    parameter EXECUTE_I = 9;
    parameter ALU_WB = 10;
    parameter BEQ = 11;
    parameter JAL = 12;

    reg [3:0] current_state, next_state;

    always @(posedge clk ) begin
        if (rst)
        begin
            current_state <= IDLE;
        end 
        else
        begin
            current_state <= next_state;
        end
    end

    always @(current_state or start or opcode)
    begin
        case (current_state)
            IDLE:
                begin
                    if (start)
                    next_state <= FETCH;
                    else
                    next_state <= IDLE;
                end
            FETCH:
                begin
                    next_state <= DECODE;
                end
            DECODE:
                begin
                    case (opcode)
                        7'b0000011: // Load
                            next_state <= MEM_ADR;
                        7'b0100011: // Store
                            next_state <= MEM_ADR;
                        7'b0110011: // R-type
                            next_state <= EXECUTE_R;
                        7'b0010011: // I-type
                            next_state <= EXECUTE_I;
                        7'b1100011: // Branch
                            next_state <= BEQ;
                        7'b1101111: // JAL
                            next_state <= JAL;
                        default:
                            next_state <= IDLE;
                    endcase
                end
            MEM_ADR:
                begin
                    case (opcode)
                        7'b0000011: // Load
                            next_state <= MEM_READ;
                        7'b0100011: // Store
                            next_state <= MEM_WRITE;
                        default:
                            next_state <= IDLE;
                    endcase
                end
            MEM_READ:
                begin
                    next_state <= MEM_WB;
                end
            MEM_WB:
                begin
                    next_state <= FETCH;
                end
            MEM_WRITE:
                begin
                    next_state <= FETCH;
                end 
            EXECUTE_R:
                begin
                   next_state <= ALU_WB; 
                end
            EXECUTE_I:
                begin
                    next_state <= ALU_WB;
                end
            ALU_WB:
                begin
                    next_state <= FETCH;
                end
            BEQ:
                begin
                    next_state <= FETCH;
                end
            JAL:
                begin
                    next_state <= ALU_WB;
                end 
            default: 
                next_state <= IDLE;
        endcase             
    end 

    always @(current_state or start or opcode)
    begin
        case (current_state)
            IDLE:
                begin
                    adr_src <= 0;
                    ir_write <= 0;
                    pc_update <= 0;
                    reg_write <= 0;
                    mem_write <= 0;
                    branch <= 0;
                    alu_src_a <= 2'b00;
                    alu_src_b <= 2'b00;
                    alu_op <= 2'b00;
                    result_src <= 2'b00;
                end
            FETCH:
                begin
                    adr_src <= 0;
                    ir_write <= 1;
                    pc_update <= 1;
                    reg_write <= 0;
                    mem_write <= 0;
                    branch <= 0;
                    alu_src_a <= 2'b00;
                    alu_src_b <= 2'b10;
                    alu_op <= 2'b00;
                    result_src <= 2'b10;
                end
            DECODE:
                begin
                    adr_src <= 0;
                    ir_write <= 0;
                    pc_update <= 0;
                    reg_write <= 0;
                    mem_write <= 0;
                    branch <= 0;
                    alu_src_a <= 2'b00;
                    alu_src_b <= 2'b00;
                    alu_op <= 2'b00;
                    result_src <= 2'b00;
                end
            MEM_ADR:
                begin
                    adr_src <= 1;
                    ir_write <= 0;
                    pc_update <= 0;
                    reg_write <= 0;
                    mem_write <= 0;
                    branch <= 0;
                    alu_src_a <= 2'b00;
                    alu_src_b <= 2'b01;
                    alu_op <= 2'b00;
                    result_src <= 2'b00;
                end
            MEM_READ:
                begin
                    adr_src <= 0;
                    ir_write <= 0;
                    pc_update <= 0;
                    reg_write <= 1;
                    mem_write <= 0;
                    branch <= 0;
                    alu_src_a <= 2'b00;
                    alu_src_b <= 2'b00;
                    alu_op <= 2'b00;
                    result_src <= 2'b01;
                end
            MEM_WB:
                begin
                    adr_src <= 0;
                    ir_write <= 0;
                    pc_update <= 0;
                    reg_write <= 1;
                    mem_write <= 0;
                    branch <= 0;
                    alu_src_a <= 2'b00;
                    alu_src_b <= 2'b00;
                    alu_op <= 2'b00;
                    result_src <= 2'b01;
                end
            MEM_WRITE:
                begin
                    adr_src <= 0;
                    ir_write <= 0;
                    pc_update <= 0;
                    reg_write <= 0;
                    mem_write <= 1;
                    branch <= 0;
                    alu_src_a <= 2'b00;
                    alu_src_b <= 2'b01;
                    alu_op <= 2'b00;
                    result_src <= 2'b00;
                end
            EXECUTE_R:
                begin
                    adr_src <= 0;
                    ir_write <= 0;
                    pc_update <= 0;
                    reg_write <= 1;
                    mem_write <= 0;
                    branch <= 0;
                    alu_src_a <= 2'b00;
                    alu_src_b <= 2'b01;
                    alu_op <= 2'b10;
                    result_src <= 2'b00;
                end
            EXECUTE_I:
                begin
                    adr_src <= 0;
                    ir_write <= 0;
                    pc_update <= 0;
                    reg_write <= 1;
                    mem_write <= 0;
                    branch <= 0;
                    alu_src_a <= 2'b00;
                    alu_src_b <= 2'b01;
                    alu_op <= 2'b01;
                    result_src <= 2'b00;
                end
            ALU_WB:
                begin
                    adr_src <= 0;
                    ir_write <= 0;
                    pc_update <= 0;
                    reg_write <= 1;
                    mem_write <= 0;
                    branch <= 0;
                    alu_src_a <= 2'b00;
                    alu_src_b <= 2'b00;
                    alu_op <= 2'b00;
                    result_src <= 2'b00;
                end
            BEQ:
                begin
                    adr_src <= 0;
                    ir_write <= 0;
                    pc_update <= 0;
                    reg_write <= 0;
                    mem_write <= 0;
                    branch <= 1;
                    alu_src_a <= 2'b00;
                    alu_src_b <= 2'b01;
                    alu_op <= 2'b11;
                    result_src <= 2'b00;
                end 
            JAL:
                begin
                    adr_src <= 0;
                    ir_write <= 0;
                    pc_update <= 1;
                    reg_write <= 1;
                    mem_write <= 0;
                    branch <= 0;
                    alu_src_a <= 2'b00;
                    alu_src_b <= 2'b01;
                    alu_op <= 2'b00;
                    result_src <= 2'b10;
                end 
            default:
                begin
                    adr_src <= 0;
                    ir_write <= 0;
                    pc_update <= 0;
                    reg_write <= 0;
                    mem_write <= 0;
                    branch <= 0;
                    alu_src_a <= 2'b00;
                    alu_src_b <= 2'b00;
                    alu_op <= 2'b00;
                    result_src <= 2'b00;
                end 
        endcase 
    end

    
endmodule