module forwarding_unit(input  [4:0] rs1E, rs2E,
                       input  [4:0] rdM, rdW,
                       input        regwriteM, regwriteW,
                       output reg [1:0] forwardAE, forwardBE);

  always @(*) begin
    // ForwardA
    if (regwriteM && (rdM != 0) && (rdM == rs1E)) forwardAE = 2'b10;
    else if (regwriteW && (rdW != 0) && (rdW == rs1E)) forwardAE = 2'b01;
    else forwardAE = 2'b00;

    // ForwardB
    if (regwriteM && (rdM != 0) && (rdM == rs2E)) forwardBE = 2'b10;
    else if (regwriteW && (rdW != 0) && (rdW == rs2E)) forwardBE = 2'b01;
    else forwardBE = 2'b00;
  end
endmodule