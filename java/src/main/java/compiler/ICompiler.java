package compiler;

import compiler.model.DataType;
import tac.Code;
import tac.instruction.Instruction;
import tac.register.Register;

public interface ICompiler {
    int declVar(String id, DataType type);

    /* poushes value on top of stack and sets sp and returns addr of pushed value */
    int pushToStack(int value);
    
    /* reads value on top of stack and saves it in register r and reverts sp */
    void popStack(Register r);

    void assign();

    /** returns current code body of compiler */
    Code insert(Instruction in);
    
    /** returns current code body of compiler */
    Code insertCode(Code code);

    void readVar(String id, Register to);
}
