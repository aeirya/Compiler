package tac.instruction.impl.psuedo;

import tac.OperationType;
import tac.instruction.Immediate;
import tac.register.Register;

public class Addi extends Immediate {
    public Addi(Register r, int im) {
        super(OperationType.ADDI, r, r, im);
    }
}
