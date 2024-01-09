module PC (
    input [17:0] JumpData,
    input Clock,
    input isJump,
    input Clear,
    input Write,
    output reg [17:0] PC
);
//PC sıfırlandı
initial
begin
    PC = 18'b0;
end
always@(posedge Clock)
begin 
if (!isJump)
    begin
        if (Write)
            begin
                PC = PC + 18'b1;
            end
    end
else
    begin
        PC = PC + JumpData;
    end
end


endmodule