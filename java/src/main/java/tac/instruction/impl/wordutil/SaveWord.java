package tac.instruction.impl.wordutil;

import tac.OperationType;
import tac.register.Register;

public class SaveWord extends WordUtil {
    public SaveWord(Register valReg, int offset, Register addrReg) {
        super(OperationType.SW, valReg, offset, addrReg);
    }

    public SaveWord(Register valReg, Register addrReg) {
        this(valReg, 0, addrReg);
    }
}
