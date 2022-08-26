#include <stdlib.h>
#include <string>
#include <iostream>
#include <sstream>

void runJava(char* classpath, char* classname) {
    std::stringstream ss;
    ss << "java -cp " << classpath << " " << classname << std::endl;
    int status = system(ss.str().c_str());
    if (status == 0) {
        std::cout << "running java" << std::endl;
    }
}

void runJavaWithArgs(char* classpath, char* classname, int nArgs, ...) {
    std::stringstream ss;
    ss << "java -cp " << classpath << " " << classname << " ";

    va_list ptr;
    va_start(ptr, nArgs);

    for (int i=0; i < nArgs; ++i) {
        ss << va_arg(ptr, char*) << " ";
    }

    va_end(ptr);

    ss << std::endl;
    int status = system(ss.str().c_str());
    if (status == 0) {
        std::cout << "running java" << std::endl;
    }
}

void runJavaCompiler() {
    runJava("../java/target/classes", "Other");
}
