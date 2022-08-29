package util;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;

import com.google.gson.Gson;

import ast.node.statement.Program;

public class JsonTreeReader {

    public Program readTree(String filename) {
        var path = Paths.get(filename);
    
        Gson gson = new Gson();
    
        try (
            var reader = Files.newBufferedReader(
                path, StandardCharsets.UTF_8)
            ) {
                return gson.fromJson(reader, Program.class);
        } catch (IOException e) {
            return null;
        }
    }
}
