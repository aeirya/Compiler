package ast.node.declaration;

import ast.node.Node;
import compiler.ICompiler;
import compiler.model.DataType;
import tac.Code;

public class VarDecl extends Node {
    private final String id;
    private final DataType type;

    /** called by gosn */
    public VarDecl(String id, String type) {
        super();
        this.id = id;
        this.type = DataType.valueOf(type.toUpperCase());
    }

    @Override
    public Code toCode(ICompiler compiler) {
        compiler.declVar(id, type);
        return new Code();
    }
}
