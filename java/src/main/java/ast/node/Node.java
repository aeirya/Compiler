package ast.node;

public abstract class Node {
    protected Type type;

    protected Node(Type type) {
        this.type = type;
    }
}
