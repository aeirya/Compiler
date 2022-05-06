%option noyywrap
%option yylineno
/* %option header-file="lex.yy.h" */

%{

#include <string>

/*
    references:

    http://westes.github.io/flex/manual/How-can-I-match-C_002dstyle-comments_003f.html
    http://westes.github.io/flex/manual/Multiple-Input-Buffers.html
*/

#include "parser.tab.h"

%}

INTEGER         [0-9]+
HEXADECIMAL     0(x|X)[0-9a-fA-F]+
FLOAT           [0-9]+\.[0-9]*
SCI_FLOAT       {FLOAT}((e|E)(\+|-)?{INTEGER})
ID              [A-Za-z_][A-Za-z0-9_]*
STRING          \"([^\"]|(\\\"))*\"
SYMBOL          [\{\}\(\)\;\[\],-\.%\\!]
ARRAY_SYMBOL    (\[\])

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

    void    { return T_VOID; }
    int     { return T_INT; }
    double  { return T_DOUBLE; }
    string  { return T_STRING; }
    bool    { return T_BOOLEAN; }
    class   { return T_CLASS; }
    public  { return T_PUBLIC; }
    private { return T_PRIVATE; }
    null    { return T_NULL; }

    true {
        yylval.boolval = true;
        return T_BOOLEAN_LITERAL;
    }
    
    false {
        yylval.boolval = false;
        return T_BOOLEAN_LITERAL;
    }

    {RSERVED_KEYWORD} {
        // TODO: write all    
    }
        
    {OP_ASSIGN} {
        return T_OPERATOR_ASSIGN;
    }

    {OPERATOR} {
        // TODO: save operator in data type
        return T_OPERATOR;
    }

    {INTEGER} {
        yylval.intval = atoi(yytext);
        return T_INT_LITERAL;
    }

    {HEXADECIMAL} {
        // TODO: set intval
        return T_INT_LITERAL;
    }

    {FLOAT} {
        yylval.doubleval = strtod(yytext, 0);
        return T_DOUBLE_LITERAL;
    }

    {SCI_FLOAT} {
        // TODO: set doubleval
        return T_DOUBLE_LITERAL;
    }

    {STRING} {
        yylval.strval = yytext;
        return T_STRING_LITERAL;
    }

    {ID} {
        yylval.strval = yytext;
        return T_ID;
    }

    {ARRAY_SYMBOL} {
        return T_ARRAY;
    }

    {SYMBOL} {
        return yytext[0];
    }

    [ \t\n] ;

    . /*ignore*/ ;

    <<EOF>> {
        yyterminate();
        return 0;
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


