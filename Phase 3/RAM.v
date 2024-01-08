// Data Memory
module RAM (
    input [9:0] Address,
    input Clock,
    input Clear,
    input Loud,
    input [19:0] DataIn,
    output reg [19:0] DataOut,
    output reg Write
);

assign Write = ~Loud;

// size of the memory is 2^10 = 1024
reg [19:0] mem [0:1023];

always @(posedge Clock)
begin
    if (Clear)
        mem[Address] <= 0;
    else if (Write)
        mem[Address] <= DataIn;
end

always @*
begin
    DataOut = (Loud) ? mem[Address] : 0;
end

initial begin
    $readmemh("DataMem", mem);
end

endmodule
