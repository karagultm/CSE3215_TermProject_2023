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
            FileReader fileReader = new FileReader("assambler/input.txt");
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

    public static ArrayList<String> parser(ArrayList<String> lines) {
        ArrayList<String> parsedLines = new ArrayList<String>();
        for (String line : lines) {
            String[] tokens = line.split(" ");
            // tokens ADD, AND, NAND, NOR, ADDI, ANDI, LD, ST, CMP, JUMP, JE, JA, JB, JAE,
            // JBE

            for (int i = 1; i < tokens.length; i++) {
                tokens[i] = tokens[i].replaceAll("R", "");
            }

            if (tokens[0].equals("ADD")) {
                String opcode = "0000";
                String dst = intToBinaryString(tokens[1], 4);
                String src1 = intToBinaryString(tokens[2], 4);
                String src2 = intToBinaryString(tokens[3], 4);
                String imm = "00";
                parsedLines.add(opcode + dst + src1 + imm + src2);

            } else if (tokens[0].equals("ADDI")) {
                // imm value
                String opcode = "0001";
                String dst = intToBinaryString(tokens[1], 4);
                String src1 = intToBinaryString(tokens[2], 4);
                String imm = twosComplement(tokens[3], 6);
                parsedLines.add(opcode + dst + src1 + imm);

            } else if (tokens[0].equals("AND")) {
                String opcode = "0010";
                String dst = intToBinaryString(tokens[1], 4);
                String src1 = intToBinaryString(tokens[2], 4);
                String src2 = intToBinaryString(tokens[3], 4);
                String imm = "00";
                parsedLines.add(opcode + dst + src1 + imm + src2);
            } else if (tokens[0].equals("ANDI")) {
                // imm value
                String opcode = "0011";
                String dst = intToBinaryString(tokens[1], 4);
                String src1 = intToBinaryString(tokens[2], 4);
                String imm = twosComplement(tokens[3], 6);
                parsedLines.add(opcode + dst + src1 + imm);

            } else if (tokens[0].equals("NAND")) {
                String opcode = "0100";
                String dst = intToBinaryString(tokens[1], 4);
                String src1 = intToBinaryString(tokens[2], 4);
                String src2 = intToBinaryString(tokens[3], 4);
                String imm = "00";
                parsedLines.add(opcode + dst + src1 + imm + src2);

            } else if (tokens[0].equals("NOR")) {
                String opcode = "0101";
                String dst = intToBinaryString(tokens[1], 4);
                String src1 = intToBinaryString(tokens[2], 4);
                String src2 = intToBinaryString(tokens[3], 4);
                String imm = "00";
                parsedLines.add(opcode + dst + src1 + imm + src2);
            } else if (tokens[0].equals("LD")) {
                String opcode = "0110";
                String dst = intToBinaryString(tokens[1], 4);
                String address = twosComplement(tokens[2], 10);
                parsedLines.add(opcode + dst + address);
            } else if (tokens[0].equals("ST")) {
                String opcode = "0111";
                String src = intToBinaryString(tokens[1], 4);
                String address = twosComplement(tokens[2], 10);
                parsedLines.add(opcode + src + address);
            } else if (tokens[0].equals("CMP")) {
                String opcode = "1001";
                String flag = "0000";
                String op1 = intToBinaryString(tokens[1], 4);
                String op2 = intToBinaryString(tokens[2], 4);
                String flag2 = "00";
                parsedLines.add(opcode + flag + op1 + flag2 + op2);

            } else if (tokens[0].equals("JUMP")) {
                String opcode = "1000";
                String address = twosComplement(tokens[1], 14);
                parsedLines.add(opcode + address);
            } else if (tokens[0].equals("JE")) {
                String opcode = "1010";
                String address = twosComplement(tokens[1], 14);
                parsedLines.add(opcode + address);
            } else if (tokens[0].equals("JA")) {
                String opcode = "1011";
                String address = twosComplement(tokens[1], 14);
                parsedLines.add(opcode + address);
            } else if (tokens[0].equals("JB")) {
                String opcode = "1100";
                String address = twosComplement(tokens[1], 14);
                parsedLines.add(opcode + address);
            } else if (tokens[0].equals("JAE")) {
                String opcode = "1101";
                String address = twosComplement(tokens[1], 14);
                parsedLines.add(opcode + address);
            } else if (tokens[0].equals("JBE")) {
                String opcode = "1110";
                String address = twosComplement(tokens[1], 14);
                parsedLines.add(opcode + address);
            } else
                System.out.println("Error: Invalid Instruction " + tokens[0]);
        }

        return parsedLines;
    }

    public static String intToBinaryString(String num, int length) {
        int maxNum = (int) Math.pow(2, length);
        int decimal = Integer.parseInt(num);
        if(decimal > maxNum) {
            System.out.println("Error: OVERFLOW " + num);
            System.exit(0);
        }
        if(decimal < 0) {
            System.out.println("Error: UNDERFLOW " + num);
            System.exit(0);
        }
        String binary = Integer.toBinaryString(decimal);
        int binaryLength = binary.length();
        String temp = "";
        if (binaryLength < length) {
            for (int i = 0; i < length - binaryLength; i++)
                temp = "0" + temp;
            binary = temp + binary;
        }
        return binary;
    }

    public static ArrayList<String> binaryToHex(ArrayList<String> binaryLines) {
        ArrayList<String> hexLines = new ArrayList<String>();
        for (int i = 0; i < binaryLines.size(); i++) {
            String binaryTemp = binaryLines.get(i);
            String binary = "00" + binaryTemp;
            String hex = new BigInteger(binary, 2).toString(16);
            hex = String.format("%" + (int) Math.ceil(binary.length() / 4.0) + "s", hex).replace(' ', '0');
            hexLines.add(hex);
        }
        return hexLines;
    }

    public static String twosComplement(String num, int length) {
        int decimal = Integer.parseInt(num);
        if (decimal >= 0) {
            String binary = intToBinaryString(num, length);
            return binary;
        }
        num = num.replace("-", "");
        String binary = intToBinaryString(num, length);
        String twos = "";
        for (int i = binary.length() - 1; i >= 0; i--) {
            if (binary.charAt(i) == '1') {
                twos = "1" + twos;
                for (int j = i - 1; j >= 0; j--) {
                    twos = (binary.charAt(j) == '1') ? "0" + twos : "1" + twos;

                }
                break;
            } else {
                twos = "0" + twos;
            }

        }
        return twos;
    }

    public static void writeToFile(ArrayList<String> hexLines) {
        try {
            FileWriter fileWriter = new FileWriter("./output.hex");
            BufferedWriter out = new BufferedWriter(fileWriter);
            out.write("v2.0 raw\n");
            for (String line : hexLines) {
                out.write(line + " ");
            }
            out.close();
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
        }
    }

    public static void main(String[] args) throws Exception {

        ArrayList<String> lines = new ArrayList<String>();
        lines = getLines();

        ArrayList<String> parsed = parser(lines);
        ArrayList<String> hex = binaryToHex(parsed);

        //terminal output
        for (String line : hex) {
            System.out.println(line);
        }

        writeToFile(hex);

    }
}
