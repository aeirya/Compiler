/* main.cc */

#include <stdio.h>

// prototype of bison-generated parser function
int yyparse();

int main(int argc, char **argv)
{ 
    int x = yyparse();
    
    printf("OK\n");

    return 0;
}
