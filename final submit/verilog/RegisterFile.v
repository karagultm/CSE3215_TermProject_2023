module RegisterFile(
    input [3:0] ReadSelect1,
    input [3:0] ReadSelect2,
    input [3:0] WriteSelect,
    input [17:0] WriteData,
    input WriteEnable,
    input Clock,
    input Clear,
    output reg [17:0] ReadData1,
    output reg [17:0] ReadData2
);

    // 16-bit registers
    reg [15:0] reg0, reg1, reg2, reg3,
              reg4, reg5, reg6, reg7,
              reg8, reg9, reg10, reg11,
              reg12, reg13, reg14, reg15;

    // Temporary register for clear operation
    reg [15:0] reg_temp;

    // Read Part of the Register File
    // Read Data 1
    always @(*)
    begin
        case (ReadSelect1)
            4'b0000: ReadData1 = reg0;
            4'b0001: ReadData1 = reg1;
            4'b0010: ReadData1 = reg2;
            4'b0011: ReadData1 = reg3;
            4'b0100: ReadData1 = reg4;
            4'b0101: ReadData1 = reg5;
            4'b0110: ReadData1 = reg6;
            4'b0111: ReadData1 = reg7;
            4'b1000: ReadData1 = reg8;
            4'b1001: ReadData1 = reg9;
            4'b1010: ReadData1 = reg10;
            4'b1011: ReadData1 = reg11;
            4'b1100: ReadData1 = reg12;
            4'b1101: ReadData1 = reg13;
            4'b1110: ReadData1 = reg14;
            4'b1111: ReadData1 = reg15;
        endcase
    end

    // Read Data 2
    always @(*)
    begin
        case (ReadSelect2)
            4'b0000: ReadData2 = reg0;
            4'b0001: ReadData2 = reg1;
            4'b0010: ReadData2 = reg2;
            4'b0011: ReadData2 = reg3;
            4'b0100: ReadData2 = reg4;
            4'b0101: ReadData2 = reg5;
            4'b0110: ReadData2 = reg6;
            4'b0111: ReadData2 = reg7;
            4'b1000: ReadData2 = reg8;
            4'b1001: ReadData2 = reg9;
            4'b1010: ReadData2 = reg10;
            4'b1011: ReadData2 = reg11;
            4'b1100: ReadData2 = reg12;
            4'b1101: ReadData2 = reg13;
            4'b1110: ReadData2 = reg14;
            4'b1111: ReadData2 = reg15;
        endcase
    end

    // Write Part of the Register File
    always @(posedge Clock)
    begin
        if (WriteEnable)
        begin
            case (WriteSelect)
                4'b0000: reg0 <= WriteData;
                4'b0001: reg1 <= WriteData;
                4'b0010: reg2 <= WriteData;
                4'b0011: reg3 <= WriteData;
                4'b0100: reg4 <= WriteData;
                4'b0101: reg5 <= WriteData;
                4'b0110: reg6 <= WriteData;
                4'b0111: reg7 <= WriteData;
                4'b1000: reg8 <= WriteData;
                4'b1001: reg9 <= WriteData;
                4'b1010: reg10 <= WriteData;
                4'b1011: reg11 <= WriteData;
                4'b1100: reg12 <= WriteData;
                4'b1101: reg13 <= WriteData;
                4'b1110: reg14 <= WriteData;
                4'b1111: reg15 <= WriteData;
            endcase
        end
    end

    // Clear Part of the Register File
    always @(posedge Clock or posedge Clear)
    begin
        if (Clear)
        begin
            reg_temp = 0;
            reg0 <= reg_temp;
            reg1 <= reg_temp;
            reg2 <= reg_temp;
            reg3 <= reg_temp;
            reg4 <= reg_temp;
            reg5 <= reg_temp;
            reg6 <= reg_temp;
            reg7 <= reg_temp;
            reg8 <= reg_temp;
            reg9 <= reg_temp;
            reg10 <= reg_temp;
            reg11 <= reg_temp;
            reg12 <= reg_temp;
            reg13 <= reg_temp;
            reg14 <= reg_temp;
            reg15 <= reg_temp;
        end
    end

endmodule
