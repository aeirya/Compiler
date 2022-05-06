/* main.cc */

#include <stdio.h>

// prototype of bison-generated parser function
int yyparse();

int main(int argc, char **argv)
{ 
    yyparse();
    
    printf("OK\n");

    return 0;
}
