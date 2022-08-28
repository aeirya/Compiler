package tac.instruction;

/*
    MIPS instruction formats

    register format:
    opt rs rt rd shamt funct 
    
    immediate format:
    opt rs rt immediate(16)

    jump format:
    opt address(26)
*/
public abstract class Instruction {
    public abstract String toString();
}
