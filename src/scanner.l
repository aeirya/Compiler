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

#include <string>
#include <map>

using std::string;
using std::map;
using std::pair;


/*
    definitions and utilities for define functionality
*/
#pragma region define

#define DEF_ID_SIZE 100
bool id_flag = false;
char def_id[DEF_ID_SIZE];

#define DEF_BODY_SIZE 350
char def_body[DEF_BODY_SIZE];
int dbp = 0;  /* def body pointer */

bool dmap_flag = false; /* dmap read mode flag */
/*
    maps id -> code to be replaced
    everything "define"ed will be stored here
*/
map<string, string> dmap;

inline bool is_macro(char* id) 
{
    map<string, string>::const_iterator it;
    return !((it = dmap.find(id)) == dmap.end());
}

inline string get_macro(char *id) 
{
    map<string, string>::const_iterator it;
    return dmap.find(id)->second;
}

#pragma endregion define


#include "tokens.h"

/*  TOKEN: token name   
    yytext: token lexeme    */
#define PRINT_TOKEN(TOKEN) fprintf(yyout, "%s %s\n", token_to_str(TOKEN), yytext); 

#define PRINT_NEWLINE fprintf(yyout, "\n")

YY_BUFFER_STATE main_buf_state;

%}

INTEGER     [0-9]+
HEXADECIMAL 0(x|X)[0-9a-fA-F]+
FLOAT   [0-9]+\.[0-9]*
SCI_FLOAT   {FLOAT}((e|E)(\+|-)?{INTEGER})
ID      [A-Za-z_][A-Za-z0-9_]*
STRING  \"([^\"]|(\\\"))*\"
SYMBOL  [\{\}\(\)\;\[\],-\.%\\!(\[\])]

OP_LOGIC        &&|(\|\|)
OP_ARITHMETIC   \+|-|\*|\/
OP_COMPARISON   <|<=|>|>=|!=|==   
OP_ASSIGN       =|(\+=)|-=|(\*=)|(\/=)
OPERATOR        {OP_LOGIC}|{OP_ARITHMETIC}|{OP_COMPARISON}|{OP_ASSIGN}

RK_TYPE         void|int|double|bool|string|class
RK_FLOW_CONTROL for|while|if|else|return|break|continue
RK_FUNCTIONS    btoi|dtoi|itob|itod|__line__|__func__|NewArray|Print|ReadInteger|ReadLine
RSERVED_KEYWORD {RK_TYPE}|{RK_FLOW_CONTROL}|{RK_FUNCTIONS}|null|new|this|import|private|public

%x IN_MULTILINE_COMMENT
%x IN_ONELINE_COMMENT
%x IN_DEFINE

%%

<INITIAL>{
    {}

    "/*"    {
        BEGIN(IN_MULTILINE_COMMENT);
    }

    "//"    {
        BEGIN(IN_ONELINE_COMMENT);
    }

    define {
        BEGIN(IN_DEFINE);
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
        if (!is_macro(yytext)) { PRINT_TOKEN(T_ID); }
        else /* check for macro definition */
        {
            main_buf_state = YY_CURRENT_BUFFER;
            dmap_flag = true;
            yy_scan_string(get_macro(yytext).c_str());
        }
    }

    {SYMBOL} {
        ECHO;
        PRINT_NEWLINE;
    }

    [ \t\n] ;

    . /*ignore*/ ;

    <<EOF>> {
        if (dmap_flag) {
            yy_switch_to_buffer(main_buf_state);
            dmap_flag = false;
        }
        else yyterminate();
    }
}

<IN_DEFINE>{
    {}

    {ID}    {
        if (!id_flag) strcpy(def_id, yytext);
        else
        {
            for (int i=0; i<yyleng; ++i)
                def_body[dbp+i] = yytext[i];
            dbp += yyleng;
        }

        id_flag = true;
    }

    "\n"    {
        /* adding two ascii nulls to string ending */
        def_body[dbp] = def_body[dbp+1] = 0;
        dmap.insert(pair<string, string>(def_id, def_body));

        /* reset vars */
        for (int i=0; i<DEF_ID_SIZE; ++i) def_id[i] = 0;
        for (int i=0; i<dbp && def_body[i]!=0; ++i) def_body[i] = 0;
        dbp = 0;
        id_flag = false;

        BEGIN(INITIAL);
    }

    .       {
        for (int i=0; i<yyleng; ++i)
            def_body[dbp+i] = yytext[i];
        dbp += yyleng;
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


