%option noyywrap
%option header-file="lex.yy.h"

%{
#include <iostream>

#define YY_DECL int yylex()

%}

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