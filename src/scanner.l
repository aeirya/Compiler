%option noyywrap
%option yylineno
%option header-file="lex.yy.h"

%{
#include <iostream>
#define YY_DECL int yylex()
%}

<<<<<<< HEAD
DIGIT   [0-9]
INTEGER [\+-]?[0-9]+
FLOAT   [\+-]?[0-9]+\.[0-9]+
SCI_FLOAT   {FLOAT}e{INTEGER}
ID      [A-Za-z][A-Za-z0-9]*

%%

{INTEGER}|{FLOAT}|{SCI_FLOAT} {
    std::cout << "saw " << yytext << std::endl;
}

. /*ignore*/ ;

%% 
=======
DIGIT    [0-9]+
ID       [A-Za-z][a-z0-9]*

%%
{ID} {printf("ID Found! == %s", yytext);}
{DIGIT} {printf("DIGIT Found! == %s", yytext);}
%%
>>>>>>> 505c525 (edit : scanner.l edited.)
