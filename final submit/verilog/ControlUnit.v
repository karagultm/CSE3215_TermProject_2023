module ControlUnit(
    input [17:0] Instruction,
    input below,
    input equal,
    input above,
    input Clock,
    output reg WritePC,
    output reg Clear,
    output reg isJump,
    output reg [13:0] JumpAddress,
    output reg isImm,
    output reg [5:0] Imm,
    output reg [1:0] ALUControl,
    output reg [3:0] Src1,
    output reg [3:0] Src2,
    output reg [3:0] Dst,
    output reg writeRegEnable,
    output reg memToReg,
    output reg writeMemEnable
);

always @* begin
    Clear = 0;
    WritePC = 1;
    isJump = 0;
    JumpAddress = 0;
    isImm = 0;
    Imm = 0;
    ALUControl = 2'b00;
    Src1 = 0;
    Src2 = 0;
    Dst = 0;
    writeRegEnable = 0;
    memToReg = 0;
    writeMemEnable = 0;

    case (Instruction[17:15])
        // ADD
        3'b000: begin
            Src1 = Instruction[9:6];
            Src2 = Instruction[3:0];
            Dst = Instruction[13:10];
            writeRegEnable = 1;
            memToReg = 0;
            writeMemEnable = 1;
        end
        // ADDI
        3'b001: begin
            isImm = 1;
            Imm = Instruction[5:0];
            Src1 = Instruction[9:6];
            Dst = Instruction[13:10];
            writeRegEnable = 1;
            memToReg = 0;
            writeMemEnable = 1;
        end
        // AND
        3'b010: begin
            Src1 = Instruction[9:6];
            Src2 = Instruction[3:0];
            Dst = Instruction[13:10];
            writeRegEnable = 1;
            memToReg = 0;
            writeMemEnable = 1;
        end

        // Default case
        default: begin
            Clear = 0;
            WritePC = 0;
            isJump = 0;
            JumpAddress = 0;
            isImm = 0;
            Imm = 0;
            ALUControl = 2'b00;
            Src1 = 0;
            Src2 = 0;
            Dst = 0;
            writeRegEnable = 0;
            memToReg = 0;
            writeMemEnable = 1;
        end
    endcase
end

endmodule

