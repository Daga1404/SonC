module top_level_sc_processor (
    input clk
);
    wire pc_src;
    wire [31:0]  pc_target, pc_plus_4, instruction;
    wire [31:0] pc_next = pc_src ? pc_target : pc_plus_4;
    reg [31:0] pc;
    wire reg_write;
    wire [31:0] result, src_a, rd2;
    wire alu_src;
    wire [31:0] imm_ext;
    wire src_b = alu_src ? imm_ext : rd2;
    wire [1:0] imm_src;
    wire [2:0] alu_control;
    wire [31:0] alu_result;
    wire zero;
    wire [31:0] pc_out;
    wire mem_write;
    wire [31:0] read_data;
    wire result_src;


    always @(posedge clk)
    begin
        pc <= pc_next;
    end

    decoder control_unit (
        .clk(clk),
        .zero(zero),
        .op(instruction[6:0]),
        .funct3(instruction[14:12]),
        .funct7_5(instruction[30]),
        .mem_write(mem_write),
        .alu_src(alu_src),
        .reg_write(reg_write),
        .result_src(result_src),
        .imm_src(imm_src),
        .alu_control(alu_control),
    );

        // Instruction Memory
    instruction_memory im_module (
        .clk(clk),
        .pc(pc),
        .instruction(instruction)
    );

    register_file rf_module (
		.clk(clk),
        .we3(reg_write), // Write enable
        .a1(instruction[19:15]), // rs1
        .a2(instruction[24:20]), // rs2
        .a3(instruction[11:7]),  // rd
        .wd3(result), // Write data
        .rd1(src_a), // Read data 1
        .rd2(rd2)  // Read data 2
	);

    extend ext_module(
        .clk(clk),
        .imm_src(instruction[31:7]), // Example immediate source from instruction
        .extend_in(imm_src), // Example immediate input from instruction
        .imm_ext(imm_ext) // Extended immediate output
    );

        // ALU
    alu alu_module (
        .src_a(src_a), // Example source A from instruction
        .src_b(src_b), // Example source B from instruction
        .alu_control(alu_control), // Example ALU control from instruction
        .alu_result(alu_result),
        .zero(zero)
    );

    data_memory dm_module (
        .a(alu_result), // Address from ALU result
        .wd(rd2), // Write data from instruction
        .clk(clk),
        .we(mem_write), // Memory write enable from instruction
        .rd(read_data) // Read data not used in this example
    );

    assign result = result_src ? read_data : alu_result; // Result selection based on source
    assign pc_plus_4 = pc + 4; // PC + 4 for next instruction
    assign pc_target = pc + imm_ext; // PC target calculation
    

    
endmodule