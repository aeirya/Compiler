package compiler;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.util.stream.Stream;

import ast.node.statement.Program;
import util.JsonTreeReader;

public class CompilerMain {
    
    private void run(String treePath, String assemblyPath)throws FileNotFoundException {
        Program program = new JsonTreeReader().readTree(treePath);
        try (var writer = new PrintWriter(new File(assemblyPath))) {
            compile(program).forEach(inst -> writer.write(inst.toString()));
        }
    }

    private Stream<String> compile(Program program) {
        return new Compiler().compile(program);
    }

    public static void main(String[] args)throws FileNotFoundException {
        String treePath = args[0];
        String assemblyPath = args[1];
        new CompilerMain().run(treePath, assemblyPath);
    }
}
