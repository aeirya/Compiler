
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
%token T_PUBLIC
%token T_PRIVATE

%token T_OPERATOR
%token T_OPERATOR_ASSIGN
%token T_ARRAY

%token T_THIS
%token T_NULL

%%

program: decl program                                   //  Decl+
    |   { printf("OK"); }                               //  EOF
    ;
    //  TODO

decl:   variable_decl                                   //  VariableDecl
    |   function_decl                                   //  FunctionDecl
    |   class_decl                                      //  ClassDecl

variable_decl:  variable ';'                            //  Variable;

class_decl:  T_CLASS T_ID '{' class_body '}'            //  class ident { Field* }

//  DESCRIPTION: class_body :==: Field*
class_body:/* epsilon */                
    |   access_mode variable_decl class_body            //  AccessMode VariableDecl
    |   access_mode function_decl class_body            //  AccessMode FunctionDecl

access_mode:/* epsilon */
    |   T_PUBLIC                                        //  public
    |   T_PRIVATE                                       //  private

variable:   type T_ID                                   //  Type ident

function_decl:  type T_ID '(' formals ')' stmt_block    //  Type ident (Formals) StmtBlock
    |         T_VOID T_ID '(' formals ')' stmt_block    //  void ident (Formals) StmtBlock

//  TODO: **Left-recursion?!**

formals: /* epsilon */
    |   formals_nonempty

formals_nonempty: variable
    |   formals_nonempty ',' variable                   //  Variable+ ,

//  TODO: **Left-recursion?!**
type:   T_INT                                           //  int
    |   T_DOUBLE                                        //  double
    |   T_BOOLEAN                                       //  bool
    |   T_STRING                                        //  string
    |   T_ID                                            //  ident
    |   type T_ARRAY                                    //  Type[]

stmt_block: '{' stmt_body '}'                           //  {VariableDecl∗ Stmt∗}

//  DESCRIPTION: stmt_body :==: VariableDecl∗ Stmt∗
//      A more powerfull version (order-agnostic)
stmt_body:/* epsilon */
    |   variable_decl stmt_body
    |   stmt stmt_body

stmt:   ';' |   expr ';'                                //  < Expr >;
    //  TODO

expr:   l_value T_OPERATOR_ASSIGN expr                  //  LValue = Expr | LValue [+*/-]= Expr
    |   constant                                        //  Constant
    //  TODO

l_value:    T_ID                                        //  ident
    //  TODO

constant:   T_INT_LITERAL                               //  intConstant
    |       T_DOUBLE_LITERAL                            //  doubleConstant
    |       T_BOOLEAN_LITERAL                           //  boolConstant
    |       T_STRING_LITERAL                            //  stringConstant
    |       T_NULL
    //  TODO
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