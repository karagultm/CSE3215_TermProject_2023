module bitComperator(
    input [17:0] A,
    input [17:0] B,
    output above,
    output equal,
    output below
);
    always @*
    begin
        if (A > B) begin
            above = 1;
            equal = 0;
            below = 0;
        end
        else if (A == B) begin
            above = 0;
            equal = 1;
            below = 0;
        end
        else if (A < B) begin
            above = 0;
            equal = 0;
            below = 1;
        end
        else begin
            above = 0;
            equal = 0;
            below = 0;
        end
    end
endmodule
