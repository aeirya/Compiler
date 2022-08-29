package ast.node.statement;

import java.util.ArrayList;
import java.util.List;

import ast.node.Node;
import ast.node.declaration.VarDecl;
import compiler.ICompiler;
import tac.Code;

public class Program extends Node {
    private final List<VarDecl> decls;

    public Program() {
        super();
        decls = new ArrayList<>();
    }

    public Code toCode(ICompiler compiler) {
        return decls.stream().map(n -> n.toCode(compiler)).reduce(
            new Code(), (c1, c2) -> c1.concat(c2)
        );
    }
}
