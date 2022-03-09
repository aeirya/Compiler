#include <string.h>

/*  scanner header
    exports: yylex 
    */
#include "lex.yy.h"

/* utility macros */
#define RC printf("checkout!\n");

/* config */
#define IS_PREPROCESS false 

int main(int argc, char* argv[])
{
    bool in_flag = false, out_flag = false;
    char *in_name, *out_name; /* input and output filepaths */

    /* parse input */
    for (int i=0; i<argc; ++i) 
    {
        if (strcmp(argv[i], "-i") == 0) 
        {
            in_flag = true;
            yyin = fopen((in_name=argv[++i]), "r");
        }
        
        if (strcmp(argv[i], "-o") == 0) 
        {
            out_flag = true;
            yyout = fopen((out_name=argv[++i]), "w");
        }
    }

    /* preproces */
    const char* temp_name = "temp.df";
    if (IS_PREPROCESS) 
    {
        if (in_flag) 
        {
            char precmd[100];
            sprintf(precmd, "./pre.out < %s > %s", in_name, temp_name);
            system(precmd);
            fclose(yyin);
            yyin = fopen(temp_name, "r");
        }
        else /* if in interactive mode, disable preprocess */;
    }

    /* start scanning and call the scanner */
    yylex();

    /* clean up */
    if (IS_PREPROCESS)
    {
        // delete dump file
        if (in_flag) remove(temp_name);
        // close streams
        fclose(yyout);
    }

    return 0;
}