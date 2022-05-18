
%{
    // #include <string>
    #include <stdio.h>
    #include <iostream>
    #define YYDEBUG 0

    using namespace std;

    int yyerror(char *s);
    int yylex(void);
    #define TRACE printf("reduce at line %d\n", __LINE__);
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
%token <strval>     T_OP_LOGIC
%token <strval>     T_OP_COMPARISON
%token <strval>     T_OP_ASSIGN
%token <boolval>    T_BOOLEAN_LITERAL

%token T_VOID
%token T_INT
%token T_DOUBLE
%token T_BOOLEAN
%token T_STRING

%token T_CLASS
%token T_INTERFACE

%token T_FOR
%token T_WHILE
%token T_IF
%token T_ELSE
%token T_RETURN
%token T_BREAK
%token T_CONTINUE

%token T_BTOI
%token T_DTOI
%token T_ITOB
%token T_ITOD
%token T_LINE
%token T_FUNC
%token T_NEW_ARRAY
%token T_PRINT
%token T_READ_LINE
%token T_READ_INTEGER

%token T_NULL
%token T_THIS
%token T_IMPORT
%token T_NEW
%token T_PROTECTED
%token T_PRIVATE
%token T_PUBLIC
%token T_EXTENDS
%token T_IMPLEMENTS

%token T_ARRAY

%nonassoc THEN
%nonassoc T_ELSE
%%

program: 
        T_IMPORT T_STRING_LITERAL program               //  import stringConstant 
    |   decl main_program                               //  Decl+
    ;

//  [Error in documents - possible] Decl+ is nonesense
main_program:
        decl main_program
    |   /* epsilon */                                   //  EOF
    //  TODO

decl:
        variable_decl                                   //  VariableDecl
    |   function_decl                                   //  FunctionDecl
    |   class_decl                                      //  ClassDecl
    |   interface_decl                                  //  IntefaceDecl

variable_decl:
        variable ';'                                    //  Variable;

class_decl:                                             //  class ident <extends ident> <implements ident+,> {F ield∗}
        T_CLASS T_ID extends_optional implement_optional '{' class_body '}'

extends_optional:
        /* epsilon */
    |   T_EXTENDS T_ID                                  //  <extends ident>

implement_optional:
        /* epsilon */
    |   T_IMPLEMENTS implement_nonempty                 //  <implements ident+,>

implement_nonempty:                                     //  ident+,
        T_ID
    |   implement_nonempty ',' T_ID

//  DESCRIPTION: class_body :==: Field*
class_body:
        /* epsilon */                
    |   access_mode variable_decl class_body            //  AccessMode VariableDecl
    |   access_mode function_decl class_body            //  AccessMode FunctionDecl

access_mode:
        /* epsilon */
    |   T_PUBLIC                                        //  public
    |   T_PRIVATE                                       //  private
    |   T_PROTECTED                                     //  protected

interface_decl:
    T_INTERFACE T_ID '{' prototype '}'

prototype:
        /* epsilon */
    |   type T_ID '(' formals ')' ';' prototype         // Type ident (Formals);
    |   T_VOID T_ID '(' formals ')' ';' prototype       // void ident (Formals);

variable:
        type T_ID                                       //  Type ident

function_decl:
        type T_ID '(' formals ')' stmt_block            //  Type ident (Formals) StmtBlock
    |   T_VOID T_ID '(' formals ')' stmt_block          //  void ident (Formals) StmtBlock

formals:
        /* epsilon */
    |   formals_nonempty

formals_nonempty:
        variable
    |   formals_nonempty ',' variable                   //  Variable+ ,

type:
        T_INT                                           //  int
    |   T_DOUBLE                                        //  double
    |   T_BOOLEAN                                       //  bool
    |   T_STRING                                        //  string
    |   T_ID                                            //  ident
    |   type T_ARRAY                                    //  Type[]

//  DESCRIPTION: bug in documents, this is the right way
stmt_block_optional:
        stmt_block
    |   stmt

stmt_block:
        '{' stmt_body_var_decl '}'                      //  {VariableDecl∗ Stmt∗}

//  DESCRIPTION: stmt_body :==: VariableDecl∗ Stmt∗
stmt_body_var_decl:
        variable_decl stmt_body_var_decl
    |   stmt_body

stmt_body:
        /* epsilon */
    |   stmt stmt_body
    |   stmt_block stmt_body

stmt:   
        ';' |   expr ';'                                //  < Expr >;
    |   return_stmt                                     //  ReturnStmt
    |   print_stmt                                      //  PrintStmt
    |   while_stmt                                      //  WhileStmt
    |   for_stmt                                        //  ForStmt
    |   if_stmt                                         //  IfStmt
    |   break_stmt                                      //  BreakStmt
    |   continue_stmt                                   //  ContinueStmt

return_stmt:    
        T_RETURN expr_optional ';'                      //  return < Expr >;

print_stmt:
        T_PRINT '(' print_stmt_in ')' ';'               //  Print (Expr+ , );

print_stmt_in:
        expr
    |   print_stmt_in ',' expr

while_stmt:
        T_WHILE '(' expr ')' stmt_block_optional

for_stmt:                                               //  for (< Expr >; Expr; < Expr >) Stmt
        T_FOR '(' expr_optional ';' expr ';' expr_optional ')' stmt_block_optional

//  Solving if S/R using [https://stackoverflow.com/questions/12731922/reforming-the-grammar-to-remove-shift-reduce-conflict-in-if-then-else]
//      Probable [Error in documents] here in Stmt declaration
if_stmt:                                                //  if (Expr) Stmt < else Stmt >
        T_IF '(' expr ')' stmt_block_optional %prec THEN
    |   T_IF '(' expr ')' stmt_block_optional T_ELSE stmt_block_optional

break_stmt:
        T_BREAK ';'                                     //  break;

continue_stmt:
        T_CONTINUE ';'                                  //  continue;

//  Expression Part (Rules would add in revrese order - b.c bottom-up parsing):
expr_optional:                                          //  < Expr >
        /* epsilon */
    |   expr

expr:
        assignment                                      //  LValue = Expr
    |   expr_op_logic

expr_op_logic:
        expr_op_logic T_OP_LOGIC expr_op_comp           //  Expr [&&|(||)] Expr
    |   expr_op_comp

expr_op_comp:
        expr_op_comp T_OP_COMPARISON expr_plus          //  Expr [<|<=|>|>=|!=|==] Expr
    |   expr_plus

expr_plus:
        expr_plus '+' expr_minus                        //  Expr + Expr
    |   expr_minus

expr_minus:
        expr_minus '-' expr_mod                         //  Expr - Expr
    |   expr_mod

expr_mod:
        expr_mod '%' expr_mult                          //  Exprt % Expr
    |   expr_mult

expr_mult:
        expr_mult '*' expr_div                          //  Expr * Expr
    |   expr_div

expr_div:
        expr_div '/' expr_neg                           //  Expr / Expr
    |   expr_neg

expr_neg:
        '-' expr_neg                                    //  - Expr  [Error in documents - possible]
    |   expr_not

expr_not:
        '!' expr_not                                    //  ! Expr  [Error in documents - possible]
    |   expr_

//  DESCRIPTION: Added because of a shift reduce error (assignment <--> Expr.ident)
expr_:
        '(' expr ')'                                    //  (Expr)
    |   constant                                        //  Constant
    |   l_value                                         //  LValue
    |   T_THIS                                          //  this
    |   call                                            //  Call
    |   T_READ_LINE '(' ')'                             //  ReadLine ? readLine
    |   T_READ_INTEGER '(' ')'                          //  ReadInteger
    |   T_NEW T_ID                                      //  new ident
    |   T_NEW_ARRAY '(' expr ',' type ')'               //  NewArray(Expr, Type)
    |   T_ITOD '(' expr ')'                             //  itod(Expr)
    |   T_ITOB '(' expr ')'                             //  itob(Expr)
    |   T_DTOI '(' expr ')'                             //  dtoi(Expr)
    |   T_BTOI '(' expr ')'                             //  btoi(Expr)
    |   T_LINE                                          //  __line__
    |   T_FUNC                                          //  __func__

//  DESCRIPTION: Added because of a shift reduce error (assignment <--> Expr.ident)
assignment:
        l_value T_OP_ASSIGN expr                        //  LValue [ */+-]= Expr

call:
        T_ID '(' actuals ')'                            //  ident(Actuals)
    |   expr_ '.' T_ID '(' actuals ')'                  //  Expr.ident (Actuals) [TODO : expr_ --> exp without SR errors]

actuals:
        /* epsilon */
    |   actuals_nonempty

actuals_nonempty:
        expr
    |   actuals_nonempty ',' expr                       //  Actuals+ ,

l_value:
        T_ID                                            //  ident
    |   expr_ '.' T_ID                                  //  Expr.ident  [Error in documents]
    |   expr_ '[' expr ']'                              //  Expr[Expr]  [Error in documents]
    //  TODO

constant:
        T_INT_LITERAL                                   //  intConstant
    |   T_DOUBLE_LITERAL                                //  doubleConstant
    |   T_BOOLEAN_LITERAL                               //  boolConstant
    |   T_STRING_LITERAL                                //  stringConstant
    |   T_NULL                                          //  null
    //  TODO
%%

int yyerror(string s)
{
    extern int yylineno;	// defined and maintained in lex.c
    extern char *yytext;	// defined and maintained in lex.c
    
    #if YYDEBUG
        cerr << "ERROR: " << s << " at symbol \"" << yytext;
        cerr << "\" on line " << yylineno << endl;
    #else
        cout << "Syntax Error";
    #endif
    exit(1);
}

int yyerror(char *s)
{
    return yyerror(string(s));
}
