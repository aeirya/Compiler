package tac.register;

enum RegisterType {
    TEMP,
    SAVE,
    ARG,
    VAL,
    
    ZERO,
    RA,
    SP,
    FP,
    AT
    ;

    public String toString() {
        switch (this) {
            case TEMP:
            return "t";
            case SAVE:
            return "s";
            case ARG:
            return "a";
            case VAL:
            return "v";
            default:
            return super.toString().toLowerCase();
        }
    }
}