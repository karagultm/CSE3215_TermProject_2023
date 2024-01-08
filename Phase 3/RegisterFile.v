
//register file için `timescale 1ns / 1ns tarz? bir ?ey yapaca??m unutma yada cpu.v de yapaca??z idk
module RegisterFile(
    input [3:0] ReadSelect1,
    input [3:0] ReadSelect2,
    input [3:0] WriteSelect,
    input [17:0] WriteData,
    input WriteEnable,
    input Clock,
    input Clear,
    output [17:0] ReadData1,
    output [17:0] ReadData2,
);

//our 16 bit register 
reg [15:0]  reg0,reg1,reg2,reg3,
            reg4,reg5,reg6,reg7,
            reg8,reg9,reg10,reg11,
            reg12,reg13,reg14,reg15; 
        

//Read Part of the Register File
//Read Data 1
always@(*)
    begin
        case
            ReadSelect1 == 4'b0000: ReadData1 = reg0;
            ReadSelect1 == 4'b0001: ReadData1 = reg1;
            ReadSelect1 == 4'b0010: ReadData1 = reg2;
            ReadSelect1 == 4'b0011: ReadData1 = reg3;
            ReadSelect1 == 4'b0100: ReadData1 = reg4;
            ReadSelect1 == 4'b0101: ReadData1 = reg5;
            ReadSelect1 == 4'b0110: ReadData1 = reg6;
            ReadSelect1 == 4'b0111: ReadData1 = reg7;
            ReadSelect1 == 4'b1000: ReadData1 = reg8;
            ReadSelect1 == 4'b1001: ReadData1 = reg9;
            ReadSelect1 == 4'b1010: ReadData1 = reg10;
            ReadSelect1 == 4'b1011: ReadData1 = reg11;
            ReadSelect1 == 4'b1100: ReadData1 = reg12;
            ReadSelect1 == 4'b1101: ReadData1 = reg13;
            ReadSelect1 == 4'b1110: ReadData1 = reg14;
            ReadSelect1 == 4'b1111: ReadData1 = reg15;
            //default: ReadData1 = 0; san?r?m bizim böyle bir default?m?z yok
        endcase
    end
//Read Data 2
always @(*)
begin
    case
        ReadSelect2 == 4'b0000: ReadData2 = reg0;
        ReadSelect2 == 4'b0001: ReadData2 = reg1;
        ReadSelect2 == 4'b0010: ReadData2 = reg2;
        ReadSelect2 == 4'b0011: ReadData2 = reg3;
        ReadSelect2 == 4'b0100: ReadData2 = reg4;
        ReadSelect2 == 4'b0101: ReadData2 = reg5;
        ReadSelect2 == 4'b0110: ReadData2 = reg6;
        ReadSelect2 == 4'b0111: ReadData2 = reg7;
        ReadSelect2 == 4'b1000: ReadData2 = reg8;
        ReadSelect2 == 4'b1001: ReadData2 = reg9;
        ReadSelect2 == 4'b1010: ReadData2 = reg10;
        ReadSelect2 == 4'b1011: ReadData2 = reg11;
        ReadSelect2 == 4'b1100: ReadData2 = reg12;
        ReadSelect2 == 4'b1101: ReadData2 = reg13;
        ReadSelect2 == 4'b1110: ReadData2 = reg14;
        ReadSelect2 == 4'b1111: ReadData2 = reg15;
        //default: ReadData2 = 0; san?r?m bizim böyle bir default?m?z yok
    endcase
end

//Write Part of the Register File
always @(posedge Clock and WriteEnable) 
begin
    case
        WriteSelect == 4'b0000: reg0 = WriteData;
        WriteSelect == 4'b0001: reg1 = WriteData;
        WriteSelect == 4'b0010: reg2 = WriteData;
        WriteSelect == 4'b0011: reg3 = WriteData;
        WriteSelect == 4'b0100: reg4 = WriteData;
        WriteSelect == 4'b0101: reg5 = WriteData;
        WriteSelect == 4'b0110: reg6 = WriteData;
        WriteSelect == 4'b0111: reg7 = WriteData;
        WriteSelect == 4'b1000: reg8 = WriteData;
        WriteSelect == 4'b1001: reg9 = WriteData;
        WriteSelect == 4'b1010: reg10 = WriteData;
        WriteSelect == 4'b1011: reg11 = WriteData;
        WriteSelect == 4'b1100: reg12 = WriteData;
        WriteSelect == 4'b1101: reg13 = WriteData;
        WriteSelect == 4'b1110: reg14 = WriteData;
        WriteSelect == 4'b1111: reg15 = WriteData;
        //default: reg0 = 0; san?r?m bizim böyle bir default?m?z yok
    endcase
end

//Clear Part of the Register File
always @(posedge Clock and Clear)
begin
    reg0 = 0;
    reg1 = 0;
    reg2 = 0;
    reg3 = 0;
    reg4 = 0;
    reg5 = 0;
    reg6 = 0;
    reg7 = 0;
    reg8 = 0;
    reg9 = 0;
    reg10 = 0;
    reg11 = 0;
    reg12 = 0;
    reg13 = 0;
    reg14 = 0;
    reg15 = 0;
end

endmodule