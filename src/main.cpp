#include <iostream>
#include <fstream>
#include <vector>
#include <string>

#include "lex.yy.h"

using namespace std ;

int main(int argc, char* argv[]){
    while (1)
    {
        yylex();
    }
    return 0;
    

    // if (argc < 5){
    //     cerr<< "Usage: " << argv[0] << " -i <input> -o <output>" << endl ;
    //     return 1;
    // }

    // string input_file_path = argv[2];
    // string output_file_path = argv[4];

    // ofstream output_file(output_file_path) ;
    // output_file << "class" << endl ;
    // output_file << "T_ID Program" << endl ;
    // output_file << "{" << endl ;
    // output_file << "void" << endl ;
    // output_file << "T_ID main" << endl ;
    // output_file << "(" << endl ;
    // output_file << ")" << endl ;
    // output_file << "{" << endl ;
    // output_file << "}" << endl ;
    // output_file << "}";
}