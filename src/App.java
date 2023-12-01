import java.io.BufferedReader;
import java.io.FileReader;
import java.util.ArrayList;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.math.BigInteger;


public class App {

    public static ArrayList<String> getLines() throws Exception {
        String line;
        ArrayList<String> lines = new ArrayList<String>();

        try {
            FileReader fileReader = new FileReader("src/input.txt");
            BufferedReader in = new BufferedReader(fileReader);
            while ((line = in.readLine()) != null) {
                lines.add(line);
            }
            in.close();
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
        }

        return lines;
    }

    public static String parser(ArrayList<String> lines) {
        String parsedLines = "";
        for(String line : lines) {
            String [] tokens = line.split(" ");
            //tokens ADD, AND, NAND, NOR, ADDI, ANDI, LD, ST, CMP, JUMP, JE, JA, JB, JAE,
            //JBE

            for(int i = 1; i < tokens.length; i++) {
                tokens[i] = tokens[i].replaceAll("R", "");
            }
            
            if(tokens[0].equals("ADD")) {
                String opcode = "0000";
                String dst = intToBinaryString(tokens[1], 4);
                String src1 = intToBinaryString(tokens[2], 4);
                String src2 = intToBinaryString(tokens[3], 4);
                String imm = "00";
                parsedLines += opcode + dst + src1 + imm + src2 ;
                
            }
            else if(tokens[0].equals("ADDI")) {
                //imm value
                String opcode = "0001";
                String dst = intToBinaryString(tokens[1], 4);
                String src1 = intToBinaryString(tokens[2], 4);
                String imm = intToBinaryString(tokens[3], 4);
                parsedLines += (opcode + dst + src1 + imm);

                
            }
            else if(tokens[0].equals("AND")) {
                String opcode = "0010";
                String dst = intToBinaryString(tokens[1], 4);
                String src1 = intToBinaryString(tokens[2], 4);
                String src2 = intToBinaryString(tokens[3], 4);
                String imm = "00";
                parsedLines += (opcode + dst + src1 + imm + src2);
            }
            else if(tokens[0].equals("ANDI")) {
                //imm value
                String opcode = "0011";
                String dst = intToBinaryString(tokens[1], 4);
                String src1 = intToBinaryString(tokens[2], 4);
                String imm = intToBinaryString(tokens[3], 4);
                parsedLines += (opcode + dst + src1 + imm);

            }
            else if(tokens[0].equals("NAND")) {
                String opcode = "0100";
                String dst = intToBinaryString(tokens[1], 4);
                String src1 = intToBinaryString(tokens[2], 4);
                String src2 = intToBinaryString(tokens[3], 4);
                String imm = "00";
                parsedLines += (opcode + dst + src1 + imm + src2);

            }
            else if(tokens[0].equals("NOR")) {
                String opcode = "0101";
                String dst = intToBinaryString(tokens[1], 4);
                String src1 = intToBinaryString(tokens[2], 4);
                String src2 = intToBinaryString(tokens[3], 4);
                String imm = "00";
                parsedLines += (opcode + dst + src1 + imm + src2);
            }
            else if(tokens[0].equals("LD")) {
                String opcode = "0110";
                String dst = intToBinaryString(tokens[1], 4);
                String address = intToBinaryString(tokens[2], 10);
                parsedLines += (opcode + dst + address);
            }
            else if(tokens[0].equals("ST")) {
                String opcode = "0111";
                String src = intToBinaryString(tokens[1], 4);
                String address = intToBinaryString(tokens[2], 10);
                parsedLines += (opcode + src + address);
            }
            else if(tokens[0].equals("CMP")) {
                String opcode = "1001";
                String flag = "000000";
                String op1 = intToBinaryString(tokens[1], 4);
                String op2 = intToBinaryString(tokens[2], 4);
                parsedLines += (opcode + flag + op1 + op2);

            }
            else if(tokens[0].equals("JUMP")) {
                String opcode = "1000";
                String address = twosComplement(tokens[1], 14);
                parsedLines += (opcode + address);
            }
            else if(tokens[0].equals("JE")) {
                String opcode = "1010";
                String address = intToBinaryString(tokens[1], 14);
                parsedLines += (opcode + address);
            }
            else if(tokens[0].equals("JA")) {
                String opcode = "1011";
                String address = intToBinaryString(tokens[1], 14);
                parsedLines += (opcode + address);
            }
            else if(tokens[0].equals("JB")) {
                String opcode = "1100";
                String address = intToBinaryString(tokens[1], 14);
                parsedLines += (opcode + address);
            }
            else if(tokens[0].equals("JAE")) {
                String opcode = "1101";
                String address = intToBinaryString(tokens[1], 14);
                parsedLines += (opcode + address);
            }
            else if(tokens[0].equals("JBE")) {
                String opcode = "1110";
                String address = intToBinaryString(tokens[1], 14);
                parsedLines += (opcode + address);
            }
            else
                System.out.println("Error: Invalid Instruction " + tokens[0]);
        }

        return parsedLines;
    }

    public static String intToBinaryString(String num, int length) {
        int decimal = Integer.parseInt(num);
        String binary = Integer.toBinaryString(decimal);
        int binaryLength = binary.length();
        String temp = "";
        if (binaryLength < length) {
            for (int i = 0; i < length - binaryLength ; i++)
                temp = "0" + temp;
            binary = temp + binary;
        }
        return binary;
    }

    public static String binaryToHex(String binary) {
        StringBuilder reversedBinary = new StringBuilder(binary).reverse();
        String [] reversedBinaryChunks = reversedBinary.toString().split("(?<=\\G.{4})");

        String hex = "";

        for (int i = 0; i < reversedBinaryChunks.length; i++) {
            StringBuilder r_binary = new StringBuilder(reversedBinaryChunks[i]).reverse();
            System.out.println(r_binary.toString());
            hex += Integer.toString(Integer.parseInt(r_binary.toString(), 2), 16);
        }

        hex = new StringBuilder(hex).reverse().toString();
        return hex;
    }

    public static String twosComplement(String num, int length) {
        // Negatif sayıları işlemek için int'in binary string temsilini alın
        String binaryString = intToBinaryString(num, length);
        StringBuilder twosComplement = new StringBuilder();
        boolean carry = true;

        for (int i = length - 1; i >= 0; i--) {
            char currentBit = binaryString.charAt(i);

            // Bitleri ters çevir ve carry'yi ekleyerek two's complement oluştur
            if (carry) {
                if (currentBit == '0') {
                    twosComplement.insert(0, '1');
                    carry = false;
                } else {
                    twosComplement.insert(0, '0');
                }
            } else {
                twosComplement.insert(0, currentBit);
            }
        }

        return twosComplement.toString();
    }

    public static void writeToFile(String hex) {
        try {
            FileWriter fileWriter = new FileWriter("src/output.hex");
            BufferedWriter out = new BufferedWriter(fileWriter);
            out.write("v2.0 raw\n");
            for (int i = 0; i < hex.length(); i++) {
                out.write(hex.charAt(i));
                if (i % 5 == 0 && i != 0)
                    out.write(" ");
            }
            out.close();
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
        }
    }

    public static void main(String[] args) throws Exception {
        
        ArrayList<String> lines = new ArrayList<String>();
        lines = getLines();

        String parsed = parser(lines);
        String hex = binaryToHex(parsed);
        writeToFile(hex);


        

    }
}
