package ast.node.operator;

import compiler.ICompiler;
import tac.OperationType;
import tac.instruction.TAC;
import tac.instruction.impl.stack.PushToStack;
import tac.register.Register;

public class BinaryOperator extends Operator {
    BinaryOperator(String token) {
        super(token);
    }

    @Override
    public void toCode(ICompiler compiler) {
        // right
        compiler.popStack(Register.T2);
        // left
        compiler.popStack(Register.T1);

        compiler.insert(
            new TAC(getOperationType(), Register.T0, Register.T1, Register.T2)
        ).concat(
            new PushToStack(Register.T0)
        );
    }

    private OperationType getOperationType() {
        switch (token) {
            case "add":
            return OperationType.ADD;
            case "sub":
            return OperationType.SUB;
        }
        return null;
    }
}
