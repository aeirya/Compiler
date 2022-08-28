import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;

public class Compiler {
    public static void main(String[] args) throws FileNotFoundException {
        String treePath = args[0];
        String assemblyPath = args[1];
        var writer = new PrintWriter(new File(assemblyPath));
        writer.println("HI");
        writer.close();
    }
}
