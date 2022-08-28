import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;

import com.google.gson.Gson;

public class JsonReader {
    public static void main(String[] args) throws IOException {
        // tree.json
        String filename = args[0];
        var path = Paths.get(filename);

        Gson gson = new Gson();

        try (
            var reader = Files.newBufferedReader(
                path, StandardCharsets.UTF_8)
            ) {
                Data data = gson.fromJson(reader, Data.class);
                data.print();
        }
    }
}
