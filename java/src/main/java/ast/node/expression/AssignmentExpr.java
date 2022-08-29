package ast.node.expression;

import ast.node.operator.Operator;
import compiler.ICompiler;
import tac.Code;

public class AssignmentExpr extends BinaryExpr {

    public AssignmentExpr(Operator op, Expr left, Expr right) {
        super(op, left, right);
    }

    @Override
    public Code toCode(ICompiler compiler) {
        Code a = right.toCode(compiler);
        Code b = left.toCode(compiler);
        
        // todo: pop and eval
        // Code c = new Code()
        //     .add(new )

        return a.concat(b);
    }
}
