package ast.node.expression;

import ast.node.Node;
import compiler.ICompiler;
import tac.Code;

public class Expr extends Node {

    /** returs either int or addr to an object or variable */
    @Override
    public Code toCode(ICompiler compiler) {
        return new Code();
    }
}
