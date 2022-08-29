package compiler;

import compiler.model.DataType;

public interface ICompiler {
    void declVar(String id, DataType type);

    void assign()
}
