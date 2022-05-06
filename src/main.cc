/* main.cc */

// prototype of bison-generated parser function
int yyparse();
#include "parser.tab.h"

int main(int argc, char **argv)
{ 
  yyparse();

  return 0;
}
