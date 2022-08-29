package tac;

import tac.instruction.Instruction;
import tac.instruction.impl.psuedo.Addi;
import tac.instruction.impl.psuedo.LoadImmediate;
import tac.instruction.impl.wordutil.SaveWord;
import tac.register.Register;

public class PushImmediateToStack extends Instruction {
    private int value;

    public PushImmediateToStack(int value) {
        this.value = value;
    }

    @Override
    public String toString() {
        return new Code()
            .add(new LoadImmediate(Register.T0, value))
            .add(new SaveWord(Register.T0, Register.SP))
            .add(new Addi(Register.SP, -4))
            .toString();
    }

    public static void main(String[] args) {
        System.out.println(new PushImmediateToStack(10).toString());
    }
}
