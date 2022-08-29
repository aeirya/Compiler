package compiler;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import ast.node.declaration.VarDecl;
import compiler.model.DataType;
import tac.instruction.impl.psuedo.Addi;
import tac.instruction.impl.wordutil.LoadWord;
import tac.register.Register;

/**
 */
public class VarDeclerator {
    private final Stack stack;

    /* var id -> addr */
    private final Map<String, Integer> map;

    public VarDeclerator(Stack stack) {
        this.stack = stack;
        map = new HashMap<>();
    }

    public int declVar(String id, DataType type, ICompiler comp) {
        return map.put(id, stack.reserve(type.getSize()));
    }

    /* returns the offset of var from sp */
    private int getVarAddr(String id) {
        return map.get(id);
    }

    public void readVar(String id, Register to, ICompiler comp) {
        comp.insert(new LoadWord(to, getVarAddr(id), Register.FP));
    }

    // public void assignVar(String id, )
}
