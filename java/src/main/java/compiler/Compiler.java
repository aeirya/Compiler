package compiler;

import java.util.stream.Stream;

import ast.node.statement.Program;
import compiler.model.DataType;
import tac.Code;
import tac.PushImmediateToStack;
import tac.instruction.Instruction;
import tac.instruction.impl.psuedo.Addi;
import tac.instruction.impl.stack.PopStack;
import tac.instruction.impl.wordutil.LoadWord;
import tac.register.Register;

public class Compiler implements ICompiler {
    private final Code code;
    private final Stack stack;
    private final VarDeclerator varDeclerator;

    public Compiler() {
        code = new Code();
        stack = new Stack();
        varDeclerator = new VarDeclerator(stack);
    }

    public Stream<String> compile(Program program) {
        program.toCode(this);
        return code.stream();
    }

    @Override
    public int declVar(String id, DataType type) {
        insert(new Addi(Register.SP, -4));
        return varDeclerator.declVar(id, type, this);
    }

    @Override
    public int pushToStack(int value) {
        code.add(new PushImmediateToStack(value));
        return stack.reserve();
    }

    @Override
    public void popStack(Register r) {
        insertCode(new PopStack(r));
        stack.pop();
    }

    @Override
    public void assign() {
        // TODO Auto-generated method stub
        
    }

    @Override
    public Code insert(Instruction instruction) {
        return code.add(instruction);
    }

    @Override
    public Code insertCode(Code code) {
        return this.code.concat(code);
    }

    @Override
    public void readVar(String id, Register to) {
        varDeclerator.readVar(id, to, this);
    }   
}
