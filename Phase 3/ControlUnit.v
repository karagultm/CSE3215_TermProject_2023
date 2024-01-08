
module ControlUnit(
    input [17:0] Instruction,
    input below,
    input equal,
    input above,
    input Clock,
    output Clear,
    output WritePC,
    output isJump,
    output [13:0] JumpAddress,
    output isImm,
    output [5:0] Imm,
    output [1:0] ALUControl,
    output [3:0] Src1,
    output [3:0] Src2,
    output [3:0] Dst,
    output writeRegEnable,
    output memToReg,
    output [9:0] MemAddress,
    output writeMemEnable,
);

always@(Instruction)
begin

    case (Instruction[17:15])
        //ADD
        4'b0000:begin
            Clear = 0;
            WritePC = 0;
            isJump = 0;
            JumpAddress = 0;
            isImm = 0;
            Imm = 0;
            ALUControl = 2'b00;
            Src1 = Instruction[9:6];
            Src2 = Instruction[3:0];
            Dst = Instruction[13:10];
            writeRegEnable = 1;
            memToReg = 0;
            MemAddress = 0;
            writeMemEnable = 1;
            end 
        //ADDI
        4'b0001:
        begin
            Clear = 0;
            WritePC = 0;
            isJump = 0;
            JumpAddress = 0;
            isImm = 1;
            Imm = Instruction[5:0];
            ALUControl = 2'b00;
            Src1 = Instruction[9:6];
            Src2 = 0;
            Dst = Instruction[13:10];
            writeRegEnable = 1;
            memToReg = 0;
            MemAddress = 0;
            writeMemEnable = 1;
        end
        //AND
        4'b0010:
        begin
            Clear = 0;
            WritePC = 0;
            isJump = 0;
            JumpAddress = 0;
            isImm = 0;
            Imm = 0;
            ALUControl = 2'b01;
            Src1 = Instruction[9:6];
            Src2 = Instruction[3:0];
            Dst = Instruction[13:10];
            writeRegEnable = 1;
            memToReg = 0;
            MemAddress = 0;
            writeMemEnable = 1;
        end
        //ANDI
        4'b0011:
        begin
            Clear = 0;
            WritePC = 0;
            isJump = 0;
            JumpAddress = 0;
            isImm = 1;
            Imm = Instruction[5:0];
            ALUControl = 2'b01;
            Src1 = Instruction[9:6];
            Src2 = 0;
            Dst = Instruction[13:10];
            writeRegEnable = 1;
            memToReg = 0;
            MemAddress = 0;
            writeMemEnable = 1;
        end
        //NAND
        4'b0100:
        begin
            Clear = 0;
            WritePC = 0;
            isJump = 0;
            JumpAddress = 0;
            isImm = 0;
            Imm = 0;
            ALUControl = 2'b10;
            Src1 = Instruction[9:6];
            Src2 = Instruction[3:0];
            Dst = Instruction[13:10];
            writeRegEnable = 1;
            memToReg = 0;
            MemAddress = 0;
            writeMemEnable = 1;
        end
        //NOR
        4'b0101:
        begin
            Clear = 0;
            WritePC = 0;
            isJump = 0;
            JumpAddress = 0;
            isImm = 0;
            Imm = 0;
            ALUControl = 2'b11;
            Src1 = Instruction[9:6];
            Src2 = Instruction[3:0];
            Dst = Instruction[13:10];
            writeRegEnable = 1;
            memToReg = 0;
            MemAddress = 0;
            writeMemEnable = 1;
        end
        //LD
        4'b0110:
        begin
            Clear = 0;
            WritePC = 0;
            isJump = 0;
            JumpAddress = 0;
            isImm = 0;
            Imm = 0;
            ALUControl = 2'b00;
            Src1 = 0;
            Src2 = 0;
            Dst = Instruction[13:10];
            writeRegEnable = 1;
            memToReg = 1;
            MemAddress = Instruction[9:0];
            writeMemEnable = 1;
        end
        //ST
        4'b0111:
        begin
            Clear = 0;
            WritePC = 0;
            isJump = 0;
            JumpAddress = 0;
            isImm = 0;
            Imm = 0;
            ALUControl = 2'b00;
            Src1 = Instruction[13:10];
            Src2 = 0;
            Dst = 0;
            writeRegEnable = 0;
            memToReg = 0;
            MemAddress = Instruction[9:0];
            writeMemEnable = 0;
        end
        //JMP
        4'b1000:
        begin
            Clear = 0;
            WritePC = 1;
            isJump = 1;
            JumpAddress = Instruction[13:0];
            isImm = 0;
            Imm = 0;
            ALUControl = 2'b00;
            Src1 = 0;
            Src2 = 0;
            Dst = 0;
            writeRegEnable = 0;
            memToReg = 0;
            MemAddress = 0;
            writeMemEnable = 1;
        end
        //CMP
        4'b1001:
        begin
            Clear = 0;
            WritePC = 0;
            isJump = 0;
            JumpAddress = 0;
            isImm = 0;
            Imm = 0;
            ALUControl = 2'b00;
            Src1 = Instruction[9:6];
            Src2 = Instruction[3:0];
            Dst = 0;
            writeRegEnable = 0;
            memToReg = 0;
            MemAddress = 0;
            writeMemEnable = 1;
        end
        //JE
        4'b1010:
        begin
            if(equal)
            begin
                Clear = 0;
                WritePC = 1;
                isJump = 1;
                JumpAddress = Instruction[13:0];
                isImm = 0;
                Imm = 0;
                ALUControl = 2'b00;
                Src1 = 0;
                Src2 = 0;
                Dst = 0;
                writeRegEnable = 0;
                memToReg = 0;
                MemAddress = 0;
                writeMemEnable = 1;
            end
            else begin
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
                MemAddress = 0;
                writeMemEnable = 1;
            end
        end

        //JA
        4'b1011:
        begin
            if(above)
            begin
                Clear = 0;
                WritePC = 1;
                isJump = 1;
                JumpAddress = Instruction[13:0];
                isImm = 0;
                Imm = 0;
                ALUControl = 2'b00;
                Src1 = 0;
                Src2 = 0;
                Dst = 0;
                writeRegEnable = 0;
                memToReg = 0;
                MemAddress = 0;
                writeMemEnable = 1;
            end
            else begin
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
                MemAddress = 0;
                writeMemEnable = 1;
            end
        end
        //JB
        4'b1100:
        begin
            if(below)
            begin
                Clear = 0;
                WritePC = 1;
                isJump = 1;
                JumpAddress = Instruction[13:0];
                isImm = 0;
                Imm = 0;
                ALUControl = 2'b00;
                Src1 = 0;
                Src2 = 0;
                Dst = 0;
                writeRegEnable = 0;
                memToReg = 0;
                MemAddress = 0;
                writeMemEnable = 1;
            end
            else begin
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
                MemAddress = 0;
                writeMemEnable = 1;
            end
        end
        //JAE
        4'b1101:
        begin
            if(above || equal)
            begin
                Clear = 0;
                WritePC = 1;
                isJump = 1;
                JumpAddress = Instruction[13:0];
                isImm = 0;
                Imm = 0;
                ALUControl = 2'b00;
                Src1 = 0;
                Src2 = 0;
                Dst = 0;
                writeRegEnable = 0;
                memToReg = 0;
                MemAddress = 0;
                writeMemEnable = 1;
            end
            else begin
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
                MemAddress = 0;
                writeMemEnable = 1;
            end
        end
        //JBE
        4'b1110:
        begin
            if(below || equal)
            begin
                Clear = 0;
                WritePC = 1;
                isJump = 1;
                JumpAddress = Instruction[13:0];
                isImm = 0;
                Imm = 0;
                ALUControl = 2'b00;
                Src1 = 0;
                Src2 = 0;
                Dst = 0;
                writeRegEnable = 0;
                memToReg = 0;
                MemAddress = 0;
                writeMemEnable = 1;
            end
            else begin
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
                MemAddress = 0;
                writeMemEnable = 1;
            end
        end
    endcase
end

endmodule