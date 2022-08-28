package ast.node.constant;

import ast.node.Node;
import ast.node.Type;

public class IntConstant extends Node {
    public IntConstant() {
        super(Type.INT_CONSTANT);
    }
}
