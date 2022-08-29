import java.io.FileNotFoundException;
import java.util.stream.Stream;

import ast.node.statement.Program;
import tac.instruction.Instruction;
import util.JsonTreeReader;

public class Compiler {
    
    void run(String treePath, String assemblyPath)throws FileNotFoundException {
        Program program = new JsonTreeReader().readTree(treePath);
        program.print();
        // var writer = new PrintWriter(new File(assemblyPath));
        // compile(program).forEach(inst -> writer.write(inst.toString()));
        // writer.close();
    }

    Stream<Instruction> compile(Program program) {
        return Stream.empty();
    }

    public static void main(String[] args)throws FileNotFoundException {
        String treePath = args[0];
        String assemblyPath = args[1];
        new Compiler().run(treePath, assemblyPath);
    }
}