package ast.node.statement;

import java.util.ArrayList;
import java.util.List;

import ast.node.Node;
import ast.node.declaration.VarDecl;
import compiler.ICompiler;

public class Program extends Node {
    private final List<VarDecl> decls;
    private final List<Stmt> stmts;

    public Program() {
        super();
        decls = new ArrayList<>();
        stmts = new ArrayList<>();
    }

    public void toCode(ICompiler compiler) {
        decls.stream().forEach(n->n.toCode(compiler));
    }
}
