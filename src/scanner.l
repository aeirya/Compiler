%option noyywrap
%option yylineno
%option header-file="lex.yy.h"

%{

#define YY_DECL int yylex()

#include "tokens.h"

/*  TOKEN: token name   
    yytext: token lexeme    */
#define PRINT_TOKEN(TOKEN) fprintf(yyout, "%s %s\n", token_to_str(TOKEN), yytext)

#define PRINT_NEWLINE fprintf(yyout, "\n")

%}

INTEGER     [0-9]+
HEXADECIMAL 0(x|X)[0-9a-fA-F]*
FLOAT   (([0-9]*\.[0-9]+)|([0-9]+\.[0-9]*))
SCI_FLOAT   {FLOAT}(e|E){INTEGER}
ID      [A-Za-z_][A-Za-z0-9_]*
STRING  \"([^\"]|(\\\"))*\"
OPERATOR    \+|-|\*|<|<=|>|>=|!=|==|&&|(\|\|)|=|(\+=)|-=|(\*=)|(\/=)
SYMBOL  [\{\}\(\)\;\[\],-]
RSERVED_KEYWORD    void|int|double|bool|string|class|null|for|while|if|else|return|break|new|this|NewArray|Print|ReadInteger|ReadLine|__line__|__func__|import

%%

{RSERVED_KEYWORD}|{OPERATOR} {
    ECHO;
    PRINT_NEWLINE;
}
true|false {
    PRINT_TOKEN(T_BOOLEANLITERAL);
}
{INTEGER}|{HEXADECIMAL} {
    PRINT_TOKEN(T_INTLITERAL);
}
{FLOAT}|{SCI_FLOAT} {
    PRINT_TOKEN(T_DOUBLELITERAL);
}
{STRING} {
    PRINT_TOKEN(T_STRINGLITERAL);
}
{ID} { 
    PRINT_TOKEN(T_ID);
}

{SYMBOL} {
    ECHO;
    PRINT_NEWLINE;
}

[ \t\n] ;

. /*ignore*/ ;
