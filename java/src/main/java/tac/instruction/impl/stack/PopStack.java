package tac.instruction.impl.stack;

import tac.Code;
import tac.instruction.impl.psuedo.Addi;
import tac.instruction.impl.wordutil.LoadWord;
import tac.register.Register;

public class PopStack extends Code {
    public PopStack(Register r) {
        super(new Code()
            .add(new LoadWord(r, Register.SP))
            .add(new Addi(Register.SP, 4))
        );
    }
}
