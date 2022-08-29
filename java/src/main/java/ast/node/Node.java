package ast.node;

import util.PascalToSnakeCase;

public abstract class Node {
    protected Type nodeType;

    protected Node() {
        String name = getClass().getSimpleName();
        this.nodeType = Type.valueOf(PascalToSnakeCase.convert(name).toUpperCase());
    }
}
