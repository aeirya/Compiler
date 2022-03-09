typedef enum Token
{
    T_ID,
    T_INTLITERAL,
    T_DOUBLELITERAL,
    T_STRINGLITERAL,
    T_BOOLEANLITERAL,

    T_OR,
    T_Dims,
} Token;

const char* token_to_str(Token token) 
{
    switch (token)
    {
    case T_ID:
        return "T_ID";
    case T_INTLITERAL:
        return "T_INTLITERAL";
    case T_DOUBLELITERAL:
        return "T_DOUBLELITERAL";
    case T_STRINGLITERAL:
        return "T_STRINGLITERAL";
    case T_BOOLEANLITERAL:
        return "T_BOOLEANLITERAL";  
    default:
        return "InvalidToken";
    }
}