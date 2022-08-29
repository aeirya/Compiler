package ast.node.declaration;

import ast.node.Node;

public class VarDecl extends Node {
    private final String id;
    private final String type;

    public VarDecl(String id, String type) {
        super();
        this.id = id;
        this.type = type;
    }

    public void print() {
        System.out.println(type + " " + id);
    }
}
