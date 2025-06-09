module pipelined_datapath(
    input         clk, reset,
    input  [31:0] instrF,
    input  [31:0] readdataM,
    input         pcsrcD, branchD, jumpD,
    input         memtoregE, memtoregM, memtoregW,
    input         alusrcE,
    input         regdstE,
    input         regwriteD, regwriteE, regwriteM, regwriteW,
    input  [2:0]  alucontrolE,
    input  [4:0]  rs1D, rs2D, rs1E, rs2E,
    input  [1:0]  forwardAE, forwardBE,
    output [31:0] pcF,
    output [31:0] aluoutM,
    output [31:0] writedataM,
    output [4:0]  writeregW,
    output [31:0] resultW
);

    // reg [31:0] pcF; // Removed redeclaration; already declared as output
    wire [31:0] pcplus4F, pcnextFD;
    wire [31:0] pcnextD, pcbranchD;
    wire [31:0] instrD;

    wire [31:0] rd1D, rd2D;
    wire [31:0] rd1E, rd2E;
    reg [31:0] srcaE, srcbE;
    wire [31:0] srca2E, srcb2E;
    wire [31:0] immextD, immextE;
    wire [4:0]  rs1E_id, rs2E_id;
    wire [4:0]  writeregE, writeregM;
    wire [31:0] aluoutE, aluoutW;
    wire [31:0] readdataW;
    wire [31:0] resultW_internal;

    // PC logic
    reg [31:0] pcF_reg;
always @(posedge clk or posedge reset)
    if (reset) pcF_reg <= 0;
    else       pcF_reg <= pcnextFD;

assign pcF = pcF_reg;

    assign pcplus4F = pcF + 4;

    // Instruction fetch and decode pipeline register
    flopenr #(32) if_id_instr(clk, reset, 1'b1, instrF, instrD);

    // Register file
    regfile rf(
        .clk(clk),
        .we3(regwriteW),
        .ra1(rs1D),
        .ra2(rs2D),
        .wa3(writeregW),
        .wd3(resultW_internal),
        .rd1(rd1D),
        .rd2(rd2D)
    );

    // Immediate generator
    extend ext(
        .instr(instrD),
        .immext(immextD)
    );

    // ID/EX pipeline register
    id_ex id_ex_reg(
        .clk(clk),
        .reset(reset),
        .rd1_in(rd1D),
        .rd2_in(rd2D),
        .immext_in(immextD),
        .rs1_in(rs1D),
        .rs2_in(rs2D),
        .rd1_out(rd1E),
        .rd2_out(rd2E),
        .immext_out(immextE),
        .rs1_out(rs1E_id),
        .rs2_out(rs2E_id)
    );

    // Forwarding logic
    always @(*) begin
        case (forwardAE)
            2'b00: srcaE = rd1E;
            2'b01: srcaE = resultW;
            2'b10: srcaE = aluoutM;
            default: srcaE = 32'bx;
        endcase
        case (forwardBE)
            2'b00: srcbE = rd2E;
            2'b01: srcbE = resultW;
            2'b10: srcbE = aluoutM;
            default: srcbE = 32'bx;
        endcase
    end

    assign srcb2E = alusrcE ? immextE : srcbE;

    alu alu_unit(
        .a(srcaE),
        .b(srcb2E),
        .alucontrol(alucontrolE),
        .result(aluoutE)
    );

    // EX/MEM pipeline register
    ex_mem ex_mem_reg(
        .clk(clk),
        .reset(reset),
        .aluout_in(aluoutE),
        .writedata_in(srcbE),
        .writereg_in(writeregE),
        .aluout_out(aluoutM),
        .writedata_out(writedataM),
        .writereg_out(writeregM)
    );

    // MEM/WB pipeline register
    mem_wb mem_wb_reg(
        .clk(clk),
        .reset(reset),
        .aluout_in(aluoutM),
        .readdata_in(readdataM),
        .writereg_in(writeregM),
        .aluout_out(aluoutW),
        .readdata_out(readdataW),
        .writereg_out(writeregW)
    );

    assign resultW_internal = memtoregW ? readdataW : aluoutW;
    assign resultW = resultW_internal;

endmodule
