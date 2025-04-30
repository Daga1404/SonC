module instruction_memory (
    input clk,
    input [31:0] pc,

    output reg [31:0] instruction
);
    reg [31:0] instruction_memory [0:10000]; // 10000 words of 32 bits each

    always @(posedge clk)
    begin
        instruction <= instruction_memory[pc]; // Read instruction
    end

    initial begin
        $readmemh("instructions.txt", instruction_memory); // Load instructions from file
    end
    
endmodule