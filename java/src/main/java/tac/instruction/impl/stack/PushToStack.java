package tac.instruction.impl.stack;

import tac.Code;
import tac.instruction.impl.psuedo.Addi;
import tac.instruction.impl.wordutil.SaveWord;
import tac.register.Register;

public class PushToStack extends Code {
    public PushToStack(Register r) {
        super(new Code()
            .add(new SaveWord(r, Register.SP))
            .add(new Addi(Register.SP, -4))
        );
    }
}
