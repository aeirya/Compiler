package ast.node.expression;

import ast.node.operator.Operator;
import compiler.ICompiler;

public class BinaryExpr extends Expr {
    protected final Operator op;
    protected final Expr left;
    protected final Expr right;

    public BinaryExpr(Operator op, Expr left, Expr right) {
        super();
        this.op = op;
        this.left = left;
        this.right = right;
    }

    @Override
    public void toCode(ICompiler compiler) {
        left.toCode(compiler);
        right.toCode(compiler);
        op.toCode(compiler);
    }
}
