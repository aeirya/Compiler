package compiler;

public class Stack {
    /** relative stack pointer  */
    private int sp;

    public Stack() {
        sp = 0;
    }
    
    /* reserves sapce in stack and return addr to that space */
    public int reserve(int bytes) {
        int oldSP = sp;
        sp -= bytes;
        return oldSP;
    }

    public void free(int bytes) {
        sp += bytes;
    }

    public void pop() {
        free(4);
    }
    
    /* reserves 4 bytes */
    public int reserve() {
        return reserve(4);
    }
}
