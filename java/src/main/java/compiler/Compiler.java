package compiler;

import java.util.stream.Stream;

import ast.node.statement.Program;

public class Compiler implements ICompiler {

    public Stream<String> compile(Program program) {
        return program.toCode(this).stream();
    }
}
