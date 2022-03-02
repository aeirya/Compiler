%option noyywrap
%option yylineno
%option header-file="lex.yy.h"

%{
#include <iostream>
#define YY_DECL int yylex()
%}

%%

INTEGER [\+-]?[0-9]+
HEXADECIMAL 0(x|X)[0-9a-fA-F]*
FLOAT   [\+-]?(([0-9]*\.[0-9]+)|([0-9]+\.[0-9]*))
SCI_FLOAT   {FLOAT}(e|E){INTEGER}
ID      [A-Za-z_][A-Za-z0-9_]*
STRING  \"[^\"]*\"

%%

{ID} { printf("ID Found! => %s", yytext); }
{INTEGER}|{FLOAT}|{SCI_FLOAT} { printf("number found! => %s", yytext); }
. /*ignore*/ ;
