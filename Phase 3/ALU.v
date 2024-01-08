module ALU (
    input [17:0] A,
    input [17:0] B,
    input [1:0] ALUControl,
    output reg [17:0] Output
);
    always @*
    begin
        case (ALUControl)
            2'b00: Output = A + B; // DD status
            2'b01: Output = A & B; // AND status
            2'b10: Output = ~(A & B); // NAND status
            2'b11: Output = ~(A | B); // NOR status
            default: Output = 0;
        endcase
    end
endmodule
