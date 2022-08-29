package ast.node;

import compiler.ICompiler;
import util.PascalToSnakeCase;

public abstract class Node {
    protected Type type;

    protected Node() {
        String name = getClass().getSimpleName();
        this.type = Type.valueOf(PascalToSnakeCase.convert(name).toUpperCase());
    }

    /**
     * compiler holds environmental variables
     * note that each node calling this method may change those vars
     */
    public abstract void toCode(ICompiler compiler);
}
