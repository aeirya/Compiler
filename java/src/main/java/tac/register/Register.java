package tac.register;

public class Register {
    private final int index;
    protected final RegisterType type;

    public Register(RegisterType type, int index) {
        this.index = index;
        this.type = type;
    }

    @Override
    public String toString() {
        return "$" + type.toString() + index;
    }

    public static Register fromIndex(int r) {
        switch (r) {
            case 0:
            return ZERO;
            case 1:
            return AT;
            case 2:
            case 3:
            return new Register(RegisterType.VAL, r - 2);
            case 29:
            return SP;
            case 30:
            return FP;
            case 31:
            return RA;
            case 24:
            case 25:
            return new Register(RegisterType.TEMP, r - 16);
            default:
            if (r >= 8) {
                if (r < 16) return new Register(RegisterType.TEMP, r - 8);
                else {
                    if (r < 24) return new Register(RegisterType.SAVE, r - 16);
                }
            }
            return null;
        }
    }

    public static final Register ZERO = new SpecialRegister(RegisterType.ZERO);
    public static final Register AT = new SpecialRegister(RegisterType.AT);
    public static final Register SP = new SpecialRegister(RegisterType.SP);
    public static final Register FP = new SpecialRegister(RegisterType.FP);
    public static final Register RA = new SpecialRegister(RegisterType.RA);
    public static final Register T0 = new Register(RegisterType.TEMP, 0);
    public static final Register T1 = new Register(RegisterType.TEMP, 1);
    public static final Register T2 = new Register(RegisterType.TEMP, 2);
    public static final Register S0 = new Register(RegisterType.SAVE, 0);
}
