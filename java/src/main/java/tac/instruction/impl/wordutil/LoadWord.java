package tac.instruction.impl.wordutil;

import tac.OperationType;
import tac.register.Register;

public class LoadWord extends WordUtil {
    public LoadWord(Register valReg, int offset, Register addrReg) {
        super(OperationType.LW, valReg, offset, addrReg);
    }
}
