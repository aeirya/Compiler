/* File: parser.y
 * --------------
 * Bison input file to generate the parser for the compiler.
 *
 * pp3: add parser rules and tree cons\truction from your pp2. You should
 *      not need to make any significant changes in the parser itself. After
 *      parsing completes, if no syntax errors were found, the parser calls
 *      program->Check() to kick off the semantic analyzer pass. The
 *      interesting work happens during the tree traversal.
 */

%{

#include "scanner.h" // for yylex
#include "parser.h"
#include "errors.h"

#include <typeinfo>


void yyerror(const char *msg); // standard error-handling routine

%}


/* Tokens
 * ------
 */
%token   T_Void T_Bool T_Int T_Double T_String T_Class 
%token   T_LessEqual T_GreaterEqual T_Equal T_NotEqual T_Dims
%token   T_And T_Or T_Null T_Extends T_This T_Interface T_Implements
%token   T_While T_For T_If T_Else T_Return T_Break
%token   T_New T_NewArray T_Print T_ReadInteger T_ReadLine

%token   <identifier> T_ID
%token   <stringConstant> T_StringConstant 
%token   <integerConstant> T_IntConstant
%token   <doubleConstant> T_DoubleConstant
%token   <boolConstant> T_BoolConstant

 
/* yylval 
 * ------
 */
%union {
    int integerConstant;
    bool boolConstant;
    char *stringConstant;
    double doubleConstant;
    char identifier[MaxIdentLen+1]; // +1 for terminating null
    
    Decl *decl;
    List<Decl*> *declList;

    Type *type;
    struct VariableStruct *var;

    VarDecl *varDecl;
    List<VarDecl*> *varDeclList;

    Stmt *stmt;
    List<Stmt*> *stmtList;

    Expr *expr;

    LValue *lvalue;

    Operator *op;

    Identifier *id;

    FnDecl *fnDecl;
}


/* Non-terminal types
 * ------------------
 * In order for yacc to assign/access the correct field of $$, $1, we
 * must to declare which field is appropriate for the non-terminal.
 * As an example, this first type declaration establishes that the DeclList
 * non-terminal uses the field named "declList" in the yylval union. This
 * means that when we are setting $$ for a reduction for DeclList ore reading
 * $n which corresponds to a DeclList nonterminal we are accessing the field
 * of the union named "declList" which is of type List<Decl*>.
 * pp2: You'll need to add many of these of your own.
 */
%type <declList>  DeclList 
%type <decl>      Decl

%type <type>      Type
%type <var>       Variable

%type <varDeclList>  VarDeclList 
%type <varDecl>      VarDecl

%type <stmt> StmtBlock
%type <stmtList>  StmtBody
%type <stmt>      Statement

%type <expr>      expr expr_
%type <expr>      constant assignment
%type <expr>      logic_expr logic_comp arith_expr
%type <lvalue>    l_value

%type <op>        logic_op logic_comp_op arith_op

%type <id>        ID

%type <varDeclList>  formals formals_nonempty
%type <fnDecl>       FunctionDecl

%%
/* Rules
 * -----
	 
 */
Program   :     DeclList            {
                                      @1;
                                      Program *program = new Program($1);
                                      // if no errors, advance to next phase
                                      if (ReportError::NumErrors() == 0) 
                                          program->Check(); 
                                    }
          |     StmtBody            // gimmick
          ;

DeclList  :     DeclList Decl       { ($$=$1)->Append($2); }
          |     Decl                { ($$ = new List<Decl*>)->Append($1); }
          ;

Decl      :     VarDecl             { $$ = $1; }           
          |     FunctionDecl        { $$ = $1; }
          ;

FunctionDecl:   Type ID '(' formals ')' StmtBlock 
                { $$ = new FnDecl($2, $1, $4);
                  $$->SetFunctionBody($6); }   
                //  Type ident (Formals) StmtBlock
            |   T_Void ID '(' formals ')' StmtBlock
                { $$ = new FnDecl($2, Type::voidType, $4);
                 $$->SetFunctionBody($6); }   
                //  void ident (Formals) StmtBlock
            ;

formals   :     formals_nonempty
          |     /* epsilon */       { $$ = new List<VarDecl*>; }
          ;

// TODO: remove variable struct
formals_nonempty:   Variable                            { ($$ = new List<VarDecl*>)->Append(new VarDecl($1->id, $1->type)); }
                |   formals_nonempty ',' Variable       { ($$ = $1)->Append(new VarDecl($3->id, $3->type)); }   //  Variable+ ,
                ;

VarDecl   :     Variable ';'        { $$ = new VarDecl($1->id, $1->type); }
          ;

Variable  :     Type ID             { 
                                        $$ = new VariableStruct; 
                                        $$->type = $1;
                                        $$->id = $2;
                                    }
          ;

ID        :     T_ID                { $$ = new Identifier(yyloc, $1); }
          ;

Type      :     T_Int               { $$ = Type::intType; }
          |     T_Double            { $$ = Type::doubleType; }
          ;

StmtBlock :     '{' VarDeclList StmtBody '}'    { $$ = new StmtBlock($2, $3); }
          |     '{' StmtBody '}'                { $$ = new StmtBlock(new List<VarDecl*>, $2); }
          ;

VarDeclList :   VarDeclList VarDecl { ($$=$1)->Append($2); }
            |   VarDecl             { ($$ = new List<VarDecl*>)->Append($1); }
            ;

StmtBody  :     Statement StmtBody  { ($$=$2)->Append($1); }
          |     StmtBlock StmtBody  { $$ = $2; }                // TODO: handle this
          |     /* epsilon */       { $$ = new List<Stmt*>; }
          ;

Statement :     ';'                 { $$ = new Stmt; }
          |     expr ';'            { $$ = $1; }
          ;

expr      :     assignment          //  LValue = Expr
          |     logic_expr
          |     arith_expr
          |     expr_
          ;

logic_op  :     T_And               { $$ = new Operator(yylloc, "and"); }
          |     T_Or                { $$ = new Operator(yylloc, "or"); }
          ;

logic_expr:     logic_comp logic_op logic_expr  { $$ = new LogicalExpr($1, $2, $3); }
          |     logic_comp
          ;

logic_comp:     expr_ logic_comp_op logic_comp  { $$ = new RelationalExpr($1, $2, $3); }
          |     '!' expr_                       { $$ = new LogicalExpr(new Operator(yylloc, "not"), $2); }
          |     expr_
          ;

arith_expr:     expr_ arith_op arith_expr       { $$ = new ArithmeticExpr($1, $2, $3); 
                                                  
                                                  // TODO: only for test
                                                  IntConstant *l = dynamic_cast<IntConstant*>($1);
                                                  IntConstant *r = dynamic_cast<IntConstant*>($3);
                                                  Operator *op = dynamic_cast<Operator*>($2);
                                                  IntConstant* merged = l->merge(r, op);

                                                  std::cout << merged->toCode() << std::endl;

                                                  $$ = merged;
                                                }
          |     '-' expr_                       { $$ = new ArithmeticExpr(new Operator(yylloc, "neg"), $2); } 
          |     expr_                           
          ;

arith_op  :     '+'                 { $$ = new Operator(yylloc, "sum"); }
          |     '-'                 { $$ = new Operator(yylloc, "sub"); }
          |     '*'                 { $$ = new Operator(yylloc, "mul"); }
          |     '/'                 { $$ = new Operator(yylloc, "div"); }
          |     '%'                 { $$ = new Operator(yylloc, "mod"); }
          ;

logic_comp_op:  T_LessEqual         { $$ = new Operator(yylloc, "le"); }
             |  T_GreaterEqual      { $$ = new Operator(yylloc, "ge"); }
             |  T_Equal             { $$ = new Operator(yylloc, "eq"); }
             |  T_NotEqual          { $$ = new Operator(yylloc, "neq"); }
             |  '<'                 { $$ = new Operator(yylloc, "lt"); }
             |  '>'                 { $$ = new Operator(yylloc, "gt"); }
             ;

expr_     :     '(' expr ')'        { $$ = $2; }        //  (Expr)
          |     constant                                //  Constant
          |     l_value             { $$ = $1; }        //  LValue
          ;

//  DESCRIPTION: Added because of a shift reduce error (assignment <--> Expr.ident)
assignment:     l_value '=' expr    { $$ = new AssignExpr($1, new Operator(yylloc, "eq"), $3); }    //  LValue [ */+-]= Expr
          ;

l_value   :     l_value_            { $$ = new LValue(yylloc); }   
          |     expr_ '.' ID        { $$ = new FieldAccess($1, $3); }               //  Expr.ident  [Error in documents]
          |     expr_ '[' expr ']'  { $$ = new ArrayAccess(yylloc, $1, $3); }       //  Expr[Expr]  [Error in documents]
          ;
//  TODO

l_value_  :     T_ID                //  ident

constant  :     T_IntConstant       { 
                                        $$ = new IntConstant(yylloc, yylval.integerConstant); 
                                        // printf("integer is %d\n", yylval.integerConstant);
                                    }      //  intConstant
          |     T_DoubleConstant    { $$ = new DoubleConstant(yylloc, yylval.doubleConstant); }    //  doubleConstant
          |     T_BoolConstant      { $$ = new BoolConstant(yylloc, yylval.boolConstant); }        //  boolConstant
          |     T_StringConstant    { $$ = new StringConstant(yylloc, yylval.stringConstant); }    //  stringConstant
          |     T_Null              { $$ = new NullConstant(yyloc); }                              //  null
          ;
%%

/* The closing %% above marks the end of the Rules section and the beginning
 * of the User Subroutines section. All text from here to the end of the
 * file is copied verbatim to the end of the generated y.tab.c file.
 * This section is where you put definitions of helper functions.
 */


/* Function: InitParser
 * --------------------
 * This function will be called before any calls to yyparse().  It is designed
 * to give you an opportunity to do anything that must be done to initialize
 * the parser (set global variables, configure starting state, etc.). One
 * thing it already does for you is assign the value of the global variable
 * yydebug that controls whether yacc prints debugging information about
 * parser actions (shift/reduce) and contents of state stack during parser.
 * If set to false, no information is printed. Setting it to true will give
 * you a running trail that might be helpful when debugging your parser.
 * Please be sure the variable is set to false when submitting your final
 * version.
 */
void InitParser()
{
   PrintDebug("parser", "Initializing parser");
   yydebug = false;
}
