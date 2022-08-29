package ast.node;

import compiler.ICompiler;
import tac.Code;
import util.PascalToSnakeCase;

public abstract class Node {
    protected Type nodeType;

    protected Node() {
        String name = getClass().getSimpleName();
        this.nodeType = Type.valueOf(PascalToSnakeCase.convert(name).toUpperCase());
    }

    /**
     * compiler holds environmental variables
     * note that each node calling this method may change those vars
     */
    public abstract Code toCode(ICompiler compiler);
}
