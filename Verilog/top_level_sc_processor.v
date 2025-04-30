module top_level_sc_processor (
    input clk,
    input reset,
    output [31:0] pc_out,
    output [31:0] instruction_out,
    output [31:0] alu_result_out,
    output zero_out
);

    wire [31:0] pc, instruction, alu_result;
    wire zero;
    
    // Program Counter
    program_ctr pc_module (
        .clk(clk),
        .pcNext(pc),
        .pc(pc_out)
    );
    
    // Instruction Memory
    instruction_module im_module (
        .clk(clk),
        .pc(pc),
        .instruction(instruction)
    );
    
    // ALU
    alu alu_module (
        .src_a(instruction[15:0]), // Example source A from instruction
        .src_b(instruction[31:16]), // Example source B from instruction
        .alu_control(instruction[2:0]), // Example ALU control from instruction
        .alu_result(alu_result),
        .zero(zero)
    );
    
    // Data Memory (not used in this example, but included for completeness)
    data_memory dm_module (
        .a(alu_result), // Address from ALU result
        .wd(instruction[15:0]), // Write data from instruction (example)
        .clk(clk),
        .we(1'b1), // Write enable (example)
        .rd() // Read data not used in this example
    );
    
    assign instruction_out = instruction;
    assign alu_result_out = alu_result;
    assign zero_out = zero;
    
endmodule