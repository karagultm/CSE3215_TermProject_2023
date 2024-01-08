//Data Memory
module RAM (
    input [9:0] Address,
    input Clock,
    input Clear,
    input Loud,
    input [19:0] DataIn,
    output [19:0] DataOut,
);

assign Write = ~Loud;

//size of the memory is 2^10 = 1024
reg [19:0] mem [0:1023];

DataOut = (Loud) ? mem[Address] : 0;

initial begin
        $readmemh("DataMem", mem);
end


always @(posedge Clock)
begin
    if (Clear)
        mem[Address] = 0;
    else if (Write)
        mem[Address] = DataIn;
end


endmodule