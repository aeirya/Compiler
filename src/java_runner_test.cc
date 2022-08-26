#include <iostream>
#include "java_runner.hh"

using namespace std;

int main() {
    runJavaWithArgs("../java/target/classes", "Other", 2, "21", "Aeirya");

    return 0;
}