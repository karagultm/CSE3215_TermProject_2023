import java.io.BufferedReader;
import java.io.FileReader;
import java.util.ArrayList;
import java.io.BufferedWriter;
import java.io.FileWriter;


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

    public static ArrayList<String> parser(ArrayList<String> lines) {
        ArrayList<String> parsedLines = new ArrayList<String>();
        for(String line : lines) {
            String [] tokens = line.split(" ");
            //tokens ADD, AND, NAND, NOR, ADDI, ANDI, LD, ST, CMP, JUMP, JE, JA, JB, JAE,
            //JBE

            for(int i = 1; i < tokens.length; i++) {
                tokens[i] = tokens[i].replaceAll("R", "");
            }
            
            if(tokens[0].equals("ADD")) {
                String src2 = intToHex(tokens[3], 4);
                String src1 = intToHex(tokens[2], 4);
                String dest = intToHex(tokens[1], 4);
                parsedLines.add("0000" + dest + src1 +  "00" + src2);
            }
            else if(tokens[0].equals("ADDI")) {
                //imm value
                String imm = intToHex(tokens[3], 6);
                String src1 = intToHex(tokens[2], 4);
                String dest = intToHex(tokens[1], 4);
                parsedLines.add("0001" + dest + src1 + imm);
            }
            else if(tokens[0].equals("AND")) {
                String src2 = intToHex(tokens[3], 4);
                String src1 = intToHex(tokens[2], 4);
                String dest = intToHex(tokens[1], 4);
                parsedLines.add("0010" + dest + src1 +  "00" + src2);
            }
            else if(tokens[0].equals("ANDI")) {
                //imm value
                String imm = intToHex(tokens[3], 6);
                String src1 = intToHex(tokens[2], 4);
                String dest = intToHex(tokens[1], 4);
                parsedLines.add("0011" + dest + src1 + imm);
            }
            else if(tokens[0].equals("NAND")) {
                String src2 = intToHex(tokens[3], 4);
                String src1 = intToHex(tokens[2], 4);
                String dest = intToHex(tokens[1], 4);
                parsedLines.add("0100" + dest + src1 +  "00" + src2);
            }
            else if(tokens[0].equals("NOR")) {
                String src2 = intToHex(tokens[3], 4);
                String src1 = intToHex(tokens[2], 4);
                String dest = intToHex(tokens[1], 4);
                parsedLines.add("0101" + dest + src1 +  "00" + src2);
            }
            else if(tokens[0].equals("LD")) {
                String address = intToHex(tokens[2], 10);
                String dest = intToHex(tokens[1], 4);
                parsedLines.add("0110" + dest + address);
            }
            else if(tokens[0].equals("ST")) {
                String address = intToHex(tokens[2], 10);
                String dest = intToHex(tokens[1], 4);
                parsedLines.add("0111" + dest + address);
            }
            else if(tokens[0].equals("CMP")) {
                String op1 = intToHex(tokens[1], 7);
                String op2 = intToHex(tokens[2], 7);
                parsedLines.add("1001" + op1 + op2);
            }
            else if(tokens[0].equals("JUMP")) {
                String address = intToHex(tokens[1], 14);
                parsedLines.add("1000" + address);
            }
            else if(tokens[0].equals("JE")) {
                String address = intToHex(tokens[1], 14);
                parsedLines.add("1010" + address);
            }
            else if(tokens[0].equals("JA")) {
                String address = intToHex(tokens[1], 14);
                parsedLines.add("1011" + address);
            }
            else if(tokens[0].equals("JB")) {
                String address = intToHex(tokens[1], 14);
                parsedLines.add("1100" + address);
            }
            else if(tokens[0].equals("JAE")) {
                String address = intToHex(tokens[1], 14);
                parsedLines.add("1101" + address);
            }
            else if(tokens[0].equals("JBE")) {
                String address = intToHex(tokens[1], 14);
                parsedLines.add("1110" + address);
            }
            // maybe add JRA ????
            else
                System.out.println("Error: Invalid Instruction " + tokens[0]);
        }

        return parsedLines;
    }

    public static String intToHex(String num, int length) {
        //4 bit hex
        int decimal = Integer.parseInt(num);
        String hex = Integer.toHexString(decimal);
        int hexLength = hex.length();
        String temp = "";
        if (hexLength < length) {
            for (int i = 0; i < length - hexLength ; i++)
                temp = "0" + temp;
            hex = temp.substring(hex.length() - 1) + hex;
        }

        return hex;
    }

    public static void writeToFile(ArrayList<String> parsedLines) {
        try {
            FileWriter fileWriter = new FileWriter("src/output.hex");
            BufferedWriter out = new BufferedWriter(fileWriter);
            out.write("v2.0 raw \n");
            for(String line : parsedLines) {
                out.write(line);
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

        ArrayList<String> parsed = parser(lines);
        writeToFile(parsed);
        

    }
}
