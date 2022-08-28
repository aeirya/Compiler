package tac;

public enum OperationType {
    ADD,
    ADDI,
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
