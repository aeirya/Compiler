package tac;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Stream;

import tac.instruction.Instruction;

public class Code {
    private final List<Instruction> instructions;

    public Code() {
        instructions = new ArrayList<>();
    }

    public Code(Code code) {
        this();
        concat(code);
    }

    public Code(Instruction inst) {
        this();
        add(inst);
    }

    public Code add(Instruction instruction) {
        instructions.add(instruction);
        return this;
    }

    public Code concat(Code extension) {
        extension.instructions.forEach(this::add);
        return this;
    }

    @Override
    public String toString() {
        return instructions.stream()   
            .map(Instruction::toString).reduce("", (s1, s2) -> s1 + "\n" + s2);
    }

    public Stream<String> stream() {
        return instructions.stream()   
            .map(Instruction::toString);
    }
}
