package tac.register;

public class SpecialRegister extends Register {
    public SpecialRegister(RegisterType type) {
        super(type, 0);
    }

    @Override
    public String toString() {
        return "$" + type.toString();
    }
}
