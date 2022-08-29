package ast.node.expression;

import ast.node.operator.Operator;
import compiler.ICompiler;

public class AssignmentExpr extends BinaryExpr {

    public AssignmentExpr(Operator op, Expr left, Expr right) {
        super(op, left, right);
    }

    @Override
    public void toCode(ICompiler compiler) {
        right.toCode(compiler);
        left.toCode(compiler);
        
        // todo: pop and eval
        // Code c = new Code()
        //     .add(new )

        
    }
}
