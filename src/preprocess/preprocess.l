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

    map<string, string> my_map;

    void remember(char* def_val) 
    {
        my_map.insert(pair<string, string>(def_id, def_val));
    }


%}

INTEGER   [0-9]*
FLOAT   [0-9]+\.[0-9]*
STRING  \"[^\"]*\"
ID      [a-zA-Z][a-zA-Z0-9]*

%%

[(//)]  {
    ignore_line = true;
}

^define  {
    ignore_line = true;
    def_flag = true;
}

{ID}  {
    if (!ignore_line) 
    {
        /* check if id is a definition */
        map<string, string>::const_iterator it;
        if ((it = my_map.find(yytext)) == my_map.end()) 
            ECHO;
        else std::cout << it->second;
    }
    if (def_flag) 
    {
        /* store define id */
        id_flag = true;
        strcpy(def_id, yytext);
    }
}

{STRING}|{INTEGER}|{FLOAT}   {
    if (!ignore_line) ECHO;
    if (def_flag && id_flag) remember(yytext);
}

\n  {
    if (!ignore_line) ECHO;

    ignore_line = false;

    def_flag = false;
    id_flag = false;
}

.   {
    if (!ignore_line) ECHO;
}

%% 

int main(int argc, char** argv) {
    yylex();
    return 0;
}