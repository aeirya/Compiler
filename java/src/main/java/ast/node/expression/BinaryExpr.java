package ast.node.expression;

import ast.node.operator.Operator;

public class BinaryExpr extends Expr {
    protected final Operator op;
    protected final Expr left;
    protected final Expr right;

    public BinaryExpr(Operator op, Expr left, Expr right) {
        this.op = op;
        this.left = left;
        this.right = right;
    }
}
