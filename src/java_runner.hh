#include <stdlib.h>
#include <string>

void runJava(char* classpath, char* classname) {
    std::stringstream ss;
    ss << "java -cp " << classpath << " " << classname << std::endl;
    int status = system(ss.str().c_str());
    if (status == 0) {
        std::cout << "running java" << std::endl;
    }
}

void runJavaCompiler() {
    runJava("../java/target/classes", "Other");
}
