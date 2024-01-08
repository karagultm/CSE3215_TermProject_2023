module cpu (
    input Clock,
);

wire Clear,
wire WritePC,
wire isJump,
wire [13:0] JumpAddress,
wire isImm,
wire [5:0] Imm,
wire [1:0] ALUControl,
wire [17:0] Instruction,
wire above,
wire equal,
wire below,

wire [17:0] ReadData1,
wire [17:0] ReadData2,
wire [17:0] WriteData,
wire WriteEnable,
wire [3:0] ReadSelect1,
wire [3:0] ReadSelect2,
wire [3:0] WriteSelect,
wire [17:0] PCoutput,
wire [19:0] Data; // Değişiklik burada

PC pc (
    .Clock(Clock),
    .isJump(isJump),
    .Clear(Clear),
    .Write(WritePC),
    .JumpAddress(JumpAddress),
    .PC(PCoutput)
);
ROM rom (
    .Address(PCoutput),
    .Data(Data) // Değişiklik burada
);


ControlUnit controlunit (
    .Instruction(Data), // Değişiklik burada
    .above(above),
    .equal(equal),
    .below(below),
    .clock(Clock),
    .Clear(Clear),
    .WritePC(WritePC),
    .isJump(isJump),
    .JumpAddress(JumpAddress),
    .isImm(isImm),
    .Imm(Imm),
    .ALUControl(ALUControl),
    .Src1(ReadSelect1),
    .Src2(ReadSelect2),
    .Dest(WriteSelect),
    .writeRegEnable(WriteEnable),
    .memToReg(memToReg),
    .regWrite(regWrite),
);
RegisterFile registerfile (
    .ReadSelect1(ReadSelect1),
    .ReadSelect2(ReadSelect2),
    .WriteSelect(WriteSelect),
    .WriteData(WriteData),
    .WriteEnable(WriteEnable),
    .Clock(Clock),
    .Clear(Clear),
    .ReadData1(ReadData1),
    .ReadData2(ReadData2),
);
Comperator comperator (
    .A(ReadData1),
    .B(ReadData2),
    .above(above),
    .equal(equal),
    .below(below)
);

ALU alu (
    .A(ReadData1),
    .B(ReadData2),
    .ALUControl(ALUControl),
    .Output(WriteData)
);
RAM ram (
    .Address(WriteData),
    .Clock(Clock),
    .Clear(Clear),
    .Loud(memToReg),
    .DataIn(ReadData2),
    .DataOut(WriteData),
    .Write(WriteEnable)
);

always @(posedge Clock)
begin
        if (isImm)
            begin
                ReadData2 = Imm + 18'b0;
            end
end

endmodule
