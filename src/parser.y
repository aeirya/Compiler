
%{
    // #include <string>
    #include <stdio.h>
    #include <iostream>

    using namespace std;

    int yyerror(char *s);
    int yylex(void);
%}

%union {
    int intval;
    bool boolval;
    double doubleval;
    char* strval;
}

%start program 

%token T_ID

%token <intval>     T_INT_LITERAL
%token <doubleval>  T_DOUBLE_LITERAL
%token <strval>     T_STRING_LITERAL
%token <boolval>    T_BOOLEAN_LITERAL

%token T_VOID
%token T_INT
%token T_DOUBLE
%token T_STRING
%token T_BOOLEAN
%token T_CLASS

%token T_OPERATOR
%token T_ARRAY


%%

program: decl program
    |   { printf("OK"); }
    ;

decl:   function_decl
    |   variable_decl

variable_decl:  variable ';'

variable:   type T_ID

function_decl:  type T_ID '(' formals ')' stmt_block
    |         T_VOID T_ID '(' formals ')' stmt_block

formals: /* epsilon */
    |   formals_nonempty

formals_nonempty: variable
    |   formals_nonempty ',' variable

type:   T_INT
    |   T_DOUBLE
    |   T_STRING
    |   T_BOOLEAN

stmt_block: '{' stmt_block_in '}'

stmt_block_in: /* epsilon */
    |   variable_decl stmt_block_in
    |   stmt_block_in_2

stmt_block_in_2: /* epsilon */
    |   stmt stmt_block_in_2

stmt: ';'

%%

int yyerror(string s)
{
    extern int yylineno;	// defined and maintained in lex.c
    extern char *yytext;	// defined and maintained in lex.c
    
    cerr << "ERROR: " << s << " at symbol \"" << yytext;
    cerr << "\" on line " << yylineno << endl;
    exit(1);
}

int yyerror(char *s)
{
    return yyerror(string(s));
}