package tac;

import tac.instruction.Instruction;
import tac.instruction.impl.psuedo.Add;
import tac.instruction.impl.psuedo.LoadImmediate;
import tac.instruction.impl.wordutil.SaveWord;
import tac.register.Register;

public class PushToStack extends Instruction {
    private int value;

    public PushToStack(int value) {
        this.value = value;
    }

    @Override
    public String toString() {
        return new Code()
            .add(new LoadImmediate(Register.T0, value))
            .add(new SaveWord(Register.T0, Register.SP))
            .add(new Add(Register.SP, -4))
            .toString();
    }

    public static void main(String[] args) {
        System.out.println(new PushToStack(10).toString());
    }
}
