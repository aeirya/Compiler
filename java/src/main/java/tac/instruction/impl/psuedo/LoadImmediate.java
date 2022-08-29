package tac.instruction.impl.psuedo;

import tac.OperationType;
import tac.instruction.Immediate;
import tac.register.Register;

public class LoadImmediate extends Immediate {
    public LoadImmediate(Register reg, int immediate) {
        super(OperationType.ADDI, reg, Register.ZERO, immediate);
    }
}
