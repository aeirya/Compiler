package tac;

import java.util.ArrayList;
import java.util.List;

import tac.instruction.Instruction;

public class Code {
    private final List<Instruction> instructions;

    public Code() {
        instructions = new ArrayList<>();
    }

    public Code add(Instruction instruction) {
        instructions.add(instruction);
        return this;
    }

    @Override
    public String toString() {
        return instructions.stream()   
            .map(Instruction::toString).reduce("", (s1, s2) -> s1 + "\n" + s2);
    }
}
