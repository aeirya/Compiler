package tac.instruction.impl.wordutil;

import java.util.StringJoiner;

import tac.OperationType;
import tac.instruction.Immediate;
import tac.register.Register;

public class WordUtil extends Immediate {    
    public WordUtil(OperationType opt, Register valReg, int offset, Register addrReg) {
        super(opt, addrReg, valReg, offset);
    }

    private Register getValRegister() {
        return rt;
    }

    private Register getAddrRegister() {
        return rs;
    }

    @Override
    public String toString() {
        return opt.toString() + "\t" + 
            new StringJoiner(", ")
                .add(getValRegister().toString())
                .add(immediate + "(" + getAddrRegister() + ")")
                .toString();
    }
}
