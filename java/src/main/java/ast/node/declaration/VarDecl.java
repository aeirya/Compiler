package ast.node.declaration;

import ast.node.Node;
import compiler.ICompiler;
import compiler.model.DataType;

public class VarDecl extends Node {
    private final String id;
    private final DataType dataType;

    /** called by gosn */
    public VarDecl(String id, String type) {
        super();
        this.id = id;
        this.dataType = DataType.valueOf(type.toUpperCase());
    }

    @Override
    public void toCode(ICompiler compiler) {
        compiler.declVar(id, dataType);
    }
}
