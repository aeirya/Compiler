%option noyywrap
%option yylineno
%option header-file="lex.yy.h"

%{
#include <iostream>
#define YY_DECL int yylex()
%}

%%

INTEGER [\+-]?[0-9]+
FLOAT   [\+-]?[0-9]+\.[0-9]+
SCI_FLOAT   {FLOAT}e{INTEGER}
ID      [A-Za-z][A-Za-z0-9]*

%%

{ID} { printf("ID Found! => %s", yytext); }
{INTEGER}|{FLOAT}|{SCI_FLOAT} { printf("number found! => %s", yytext); }
. /*ignore*/ ;
