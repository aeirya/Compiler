package tac.instruction;

import java.util.StringJoiner;

import tac.OperationType;
import tac.register.Register;

public class TAC extends Instruction {
    private final OperationType opt;
    private final Register rs;
    private final Register rt;
    private final Register rd;
    
    /** args: register indices */
    public TAC(OperationType opt, int result, int first, int second) {
        this.opt = opt;
        rs = Register.fromIndex(result);
        rt = Register.fromIndex(first);
        rd = Register.fromIndex(second);
    }

    public String toString() {
        return opt.toString() + "\t" + 
            new StringJoiner(", ")
                .add(rs.toString())
                .add(rt.toString())
                .add(rd.toString())
                .toString();
    }

    public static void main(String[] args) {
        System.out.println(new TAC(OperationType.ADD, 0, 1, 2));
    }
}
