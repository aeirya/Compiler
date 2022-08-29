package compiler;

import ast.node.statement.Program;

/** code generator interface */
public interface ICG {
    void cg(Program program);

}
