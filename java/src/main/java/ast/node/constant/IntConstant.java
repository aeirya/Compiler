package ast.node.constant;

import ast.node.Node;
import ast.node.expression.Expr;
import compiler.ICompiler;

public class IntConstant extends Expr {
    private final int value;

    public IntConstant(int x) {
        super();
        this.value = x;
    }

    @Override
    public void toCode(ICompiler compiler) {
        compiler.pushToStack(value);
    }
}
