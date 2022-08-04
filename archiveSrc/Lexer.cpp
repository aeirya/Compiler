/*  scanner header
    exports: yylex 
    */
# include "heading.h"
# include "lex.yy.h"

int main(int argc, char* argv[])
{
    bool in_flag = false;
    bool out_flag = false;
    char* in_name;  /* input filepaths */
    char* out_name; /* output filepaths */

    /* parse input */
    for (int i = 0; i < argc; ++i) 
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

    /* start scanning and call the scanner */
    yylex();

    /* closing the input and output stream */
    fclose(yyout);
    fclose(yyin);

    return 0;
}