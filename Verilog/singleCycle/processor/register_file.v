module register_file (
    input clk, we3,
    input [4:0] a1, a2, a3, 
    input [31:0] wd3,

    output reg [31:0] rd1, rd2
);
    reg [31:0] REG [31:0]; // 32 registers of 32 bits each

    always @(*)
    begin
        rd1 = REG[a1]; // Read data 1
        rd2 = REG[a2]; // Read data 2
    end

    always @(posedge clk)
    begin
        if (we3 == 1)
        begin
            REG[a3] <= wd3; // Write data
        end
    end
    
endmodule