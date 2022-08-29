package ast.node.statement;

import ast.node.Node;
import compiler.ICompiler;
import tac.Code;

public class Stmt extends Node {

    @Override
    public Code toCode(ICompiler compiler) {
        return new Code();
    }
}
