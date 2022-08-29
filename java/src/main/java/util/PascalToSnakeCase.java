package util;

public class PascalToSnakeCase {
    private PascalToSnakeCase() {}

    public static String convert(String input) {
        StringBuilder builder = new StringBuilder();
        boolean flag = false;
        for (Character c: input.toCharArray()) {
            if (flag && Character.isUpperCase(c)) {
                builder.append("_");
            }
            builder.append(Character.toLowerCase(c));
            flag = true;
        }
        return builder.toString();
    }
}
