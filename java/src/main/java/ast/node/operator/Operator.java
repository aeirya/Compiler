package ast.node.operator;

import ast.node.expression.Expr;

public abstract class Operator extends Expr {

    final String token;
    
    protected Operator(String token) {
        super();
        this.token = token;
    }
}
