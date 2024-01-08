// Instruction Memory
module ROM (
    input [17:0] Address,
    output reg [19:0] Data
);

// size of the memory is 2^18 = 262144
reg [19:0] mem [0:262143];

assign Data = mem[Address];

initial begin
    $readmemb("output.hex", mem);
end

endmodule
