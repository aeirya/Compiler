%option noyywrap
%option header-file="lex.yy.h"

%{
#include <iostream>

#define YY_DECL int yylex()

%}

DIGIT    [0-9]
ID       [a-z][a-z0-9]*

%%

. /*ignore*/ ;

%% 