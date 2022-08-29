package tac;

public enum OperationType {
    ADD,
    ADDI,
    SUB,
    MULT,
    LW,
    SW
    ;

    @Override
    public String toString() {
        switch (this) {
            default:
            return super.toString().toLowerCase();
        }
    }
}
