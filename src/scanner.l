%option noyywrap
%option yylineno
%option header-file="lex.yy.h"

%{
/*
    references:

    http://westes.github.io/flex/manual/How-can-I-match-C_002dstyle-comments_003f.html
    http://westes.github.io/flex/manual/Multiple-Input-Buffers.html
*/

#define YY_DECL int yylex()

#include "tokens.h"

/*  TOKEN: token name   
    yytext: token lexeme    */
#define PRINT_TOKEN(TOKEN) fprintf(yyout, "%s %s\n", token_to_str(TOKEN), yytext); 

#define PRINT_NEWLINE fprintf(yyout, "\n")

%}

INTEGER         [0-9]+
HEXADECIMAL     0(x|X)[0-9a-fA-F]+
FLOAT           [0-9]+\.[0-9]*
SCI_FLOAT       {FLOAT}((e|E)(\+|-)?{INTEGER})
ID              [A-Za-z_][A-Za-z0-9_]*
STRING          \"([^\"]|(\\\"))*\"
SYMBOL          [\{\}\(\)\;\[\],-\.%\\!(\[\])]

OP_LOGIC        &&|(\|\|)
OP_ARITHMETIC   \+|-|\*|\/
OP_COMPARISON   <|<=|>|>=|!=|==   
OP_ASSIGN       =|(\+=)|-=|(\*=)|(\/=)
OPERATOR        {OP_LOGIC}|{OP_ARITHMETIC}|{OP_COMPARISON}|{OP_ASSIGN}

RK_TYPE         void|int|double|bool|string|class
RK_FLOW_CONTROL for|while|if|else|return|break|continue
RK_FUNCTIONS    btoi|dtoi|itob|itod|__line__|__func__|NewArray|Print|ReadInteger|ReadLine
RSERVED_KEYWORD {RK_TYPE}|{RK_FLOW_CONTROL}|{RK_FUNCTIONS}|null|new|this|import|private|public|define

%x IN_MULTILINE_COMMENT
%x IN_ONELINE_COMMENT

%%

<INITIAL>{
    {}

    "/*"    {
        BEGIN(IN_MULTILINE_COMMENT);
    }

    "//"    {
        BEGIN(IN_ONELINE_COMMENT);
    }

    true|false {
        PRINT_TOKEN(T_BOOLEANLITERAL);
    }

    {RSERVED_KEYWORD}|{OPERATOR} {
        ECHO;
        PRINT_NEWLINE;
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

    <<EOF>> {
        yyterminate();
    }
}

<IN_MULTILINE_COMMENT>{
    {}

    "*/"    BEGIN(INITIAL);
    .       ;
}

<IN_ONELINE_COMMENT>{
    {}

    "\n"    BEGIN(INITIAL);
    .       ;
}


