package tac.instruction.impl.psuedo;

import tac.OperationType;
import tac.instruction.Immediate;
import tac.register.Register;

public class Add extends Immediate {
    public Add(Register r, int im) {
        super(OperationType.ADDI, r, r, im);
    }
}
