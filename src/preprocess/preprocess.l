%option noyywrap

%{
    #include <iostream>
    #include <string>
    #include <map>
    
    using std::string;
    using std::map;
    using std::pair;

    bool ignore_line = false;

    bool def_flag = false;
    bool id_flag = false;
    char def_id[50];
    char def_body[100];
    char* dbp = 0;    // define body pointer

    map<string, string> my_map;

    void inline check_def_body() {
        if (def_flag && id_flag) 
        {
            strcpy(dbp, yytext);
            dbp += yyleng;
        }
    }

    void inline remember() 
    {
        my_map.insert(pair<string, string>(def_id, def_body));
        // todo: replace on redefinition
    }


%}

ID      [a-zA-Z][a-zA-Z0-9]*

%%

\/\/  {
    ignore_line = true;
}

^define  {
    ignore_line = true;
    def_flag = true;
}

{ID}  {
    if (!ignore_line) 
    {
        /* check if id is a macro */
        map<string, string>::const_iterator it;
        if ((it = my_map.find(yytext)) == my_map.end()) 
            ECHO;
        /* then replace */
        else std::cout << it->second;
    }
    if (def_flag) 
    {
        if (!id_flag) 
        {
            /* store define id */
            id_flag = true;
            strcpy(def_id, yytext);
        }
        else check_def_body();
    }
}

\n  {
    if (!ignore_line) ECHO;

    if (def_flag) 
    {
        if (id_flag) remember();
        else /* define body missing */;
    }
    ignore_line = false;

    def_flag = false;
    id_flag = false;
    dbp = 0;
}

[ \t]*    {
    if (!ignore_line) ECHO;
    
    /* this skips the whitespace after macro id and before body */ 
    if (dbp) check_def_body();
    else if (id_flag) dbp = def_body; 
}

.   {
    if (!ignore_line) ECHO;
    check_def_body();
}

%% 

int main(int argc, char** argv) {
    yylex();
    return 0;
}