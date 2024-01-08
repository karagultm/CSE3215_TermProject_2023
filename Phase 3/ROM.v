//Instruction Memory
module ROM (
    input [17:0] Address,
    output [19:0] Data,
);

// size of the memory is 2^18 = 262144
reg [19:0] mem [0:262143];

output = mem[Address];

initial begin
    $readmemh("output.hex", mem);
end



endmodule