#include <iostream>
using std::cerr;
using std::endl;

#include <fstream>
using std::ofstream;

class Program;

void saveTree(Program* program, const char* path) {
    ofstream outdata; // outdata is like cin

    outdata.open(path); // opens the file
    if(!outdata) { // file couldn't be opened
      cerr << "Error: file could not be opened" << endl;
    } else {
        outdata << program->toJson() << endl;
    }
    outdata.close();
}