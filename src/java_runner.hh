#include <string>

void runJava(char* classpath, char* classname) {
    std::stringstream ss;
    ss << "java -cp " << classpath << " " << classname << std::endl;
    program(ss.str());
}

void runJavaCompiler() {
    runJava("../java/target/classes", "Main");
}
