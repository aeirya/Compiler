package compiler.model;

public enum DataType {
    INT,
    DOUBLE(8),
    VOID(0);

    private int size;

    private DataType() { size = 4; }
    private DataType(int size) { this.size = size; }

    public int getSize() {
        return size;
    }
}
