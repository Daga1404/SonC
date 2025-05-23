module data_memory(
    input [31:0] a, wd,
    input clk, we,

    output reg [31:0] rd
);
    reg [31:0] data_mem [10000:0]; // 10000 words of 32 bits each

    always @(posedge clk)
        begin
            if (we == 1)
                data_mem[a] <= wd; // Write data
            else
                rd <= data_mem[a]; // Read data
        end
endmodule