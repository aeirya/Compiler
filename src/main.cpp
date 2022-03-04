#include <string.h>

#include "lex.yy.h"

#define RC printf("checkout!\n");


int main(int argc, char* argv[])
{
    bool in_flag = false, out_flag = false;
    char *in_name, *out_name; /* input and output filepaths */

    for (int i=0; i<argc; ++i) 
    {
        if (strcmp(argv[i], "-i") == 0) 
        {
            in_flag = true;
            yyin = fopen((in_name=argv[++i]), "r");
        }
        else yyin = stdin;
        
        if (strcmp(argv[i], "-o") == 0) 
        {
            out_flag = true;
            yyout = fopen((out_name=argv[++i]), "w");
        }
        else yyout = stdout;
    }

    /* preproces */
    const char* temp_name = "temp.df";
    if (in_flag) 
    {
        char precmd[100];
        sprintf(precmd, "./pre < %s > %s", in_name, temp_name);
        system(precmd);
        fclose(yyin);
        yyin = fopen(temp_name, "r");
    }
    else /* if in interactive mode, disable preprocess */;
    
    yylex();

    // delete dump file
    remove(temp_name);
    // close streams
    fclose(yyout);

    return 0;
}