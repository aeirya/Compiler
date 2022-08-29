package ast.node.statement;

import java.util.ArrayList;
import java.util.List;

import ast.node.Node;
import ast.node.declaration.VarDecl;

public class Program extends Node {
    private final List<VarDecl> decls;

    public Program() {
        super();
        decls = new ArrayList<>();
    }
}
