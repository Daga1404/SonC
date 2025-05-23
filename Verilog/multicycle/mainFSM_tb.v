module mainFSM_tb ();
    // Testbench for mainFSM module
    reg clk, rst, start,
    reg [6:0] opcode,

    wire [11:0] state,
    wire adr_src, ir_write, pc_update, reg_write, mem_write, branch,
    wire [1:0] alu_src_a, alu_src_b, alu_op, result_src

    // Instantiate the mainFSM module
    mainFSM DUT (clk, rst, start, opcode,
        state, adr_src, ir_write, pc_update, reg_write, mem_write, branch,
        alu_src_a, alu_src_b, alu_op, result_src);

    reg [2:0] counter = 0;

    always @(posedge pc_update or posedge rst)
    begin
        if (rst == 1) begin
            counter <= 0
        end
        else
        counter <= counter + 1;
    end

    always @(counter) begin
        case (counter)
            0: begin
                opcode <= 7'b0110011; // R-type
            end
            1: begin
                opcode <= 7'b0010011; // I-type
            end
            2: begin
                opcode <= 7'b0000000; // Undefined
            end
            3: begin
                opcode <= 7'b0000011; // Load word 
            end
            4: begin
                opcode <= 7'b0100011; // Store word
            end
            5: begin
                opcode <= 7'b1101111; // JAL
            end
            6: begin
                opcode <= 7'b1100011; // BEQ
            end
            7: begin
                opcode <= 7'b0000000;
            end

            default: begin
                clk <= 0;
                start <= 0;
            end
            : 
            default: 
        endcase
    end


    
endmodule