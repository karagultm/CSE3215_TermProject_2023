
module d_latch(input D, input C, output Q);
    wire S1, R1, Q1, Q2;
    assign S1 = D & C;
    assign R1 = ~D & C;
    nor upperNOR(Q2, S1, Q1);
    nor lowerNOR(Q1, R1, Q2);
    assign Q = Q1;
endmodule


module d_flip_flop(input D, input C, output Q);
    wire Q1;
    always @(posedge C) begin
        d_latch dl1(D, ~C, Q1);
        d_latch dl2(Q1, C, Q);
    end
endmodule

module d_latch(input D, input C, output reg Q);
    always @(D or C)
        if (C = 1)
            Q <= D;
endmodule


module d_flip_flop(input D, input C, output Q);
    always @(posedge C) begin
        Q <= D;
    end
endmodule

module 1_bit_adder(input A, input B, input Cin, output Output, output Cout);
    assign Output = xor xorGate(A, B, Cin);
    assign Cout = A & B | A & Cin | B & Cin;
endmodule

module 18_bit_adder (
    input [17:0] A, 
    input [17:0] B, 
    input Cin, 
    output [17:0] Output, 
    output Cout);

    genvar i;
    generate
        for (i = 0; i < 18; i = i + 1) begin : gen_loop
        bit_adder_1 adder_inst (
            .A(A[i]),
            .B(B[i]),
            .Cin(i == 0 ? Cin : adder_inst.Cout),
            .Output(Output[i]),
            .Cout(adder_inst.Cout)
        );
        end
    endgenerate

endmodule

module ALU (
    input [17:0] A,
    input [17:0] B,
    input [1:0] ALUControl,
    output [17:0] Output,
);



endmodule

