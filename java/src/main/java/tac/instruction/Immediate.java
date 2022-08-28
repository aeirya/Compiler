package tac.instruction;

import java.util.StringJoiner;

import tac.OperationType;
import tac.register.Register;

public class Immediate extends Instruction {
    protected final OperationType opt;
    protected final Register rs; 
    protected final Register rt; 
    protected final int immediate;

    public Immediate(OperationType opt, Register rs, Register rt, int immediate) {
        this.opt = opt;
        this.rs = rs;
        this.rt = rt;
        this.immediate = immediate;
    }

    @Override
    public String toString() {
        return 
            opt.toString() + "\t" + 
            new StringJoiner(", ")
                .add(rs.toString())
                .add(rt.toString())
                .add(String.valueOf(immediate))
                .toString();
    }
}
