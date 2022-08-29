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

    public void print() {
        decls.forEach(VarDecl::print);
    }

    public static void main(String[] args) {
        System.out.println(new Program().nodeType);
    }
}
