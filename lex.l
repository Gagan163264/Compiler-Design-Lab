%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"
%}

id [a-zA-Z_][a-zA-Z0-9_]*
cnst [0-9]*\.[0-9]+|[0-9]+|\'.\'
newlin \n+
space " "
str \".*\"
pp_token #.*\n
comment \/\/.*\n|\/\*(.|\n)*\*\/

%%
"auto" {  return AUTO;  }
"break"    { return BREAK;  }
"case"    { return CASE;  }
"char"    { return CHAR;  }
"const"    { return CONST;  }
"continue"    { return CONTINUE;  }
"default"    { return DEFAULT;  }
"do"    { return DO;  }
"double"    { return DOUBLE;  }
"else"    { return ELSE;  }
"enum"    { return ENUM;  }
"extern"    { return EXTERN;  }
"float"    { return FLOAT;  }
"for"    { return FOR;  }
"goto"    { return GOTO;  }
"if"    { return IF;  }
"inline"    { return INLINE;  }
"int"    { return INT;  }
"long"    { return LONG;  }
"register"    { return REGISTER;  }
"restrict"    { return RESTRICT;  }
"return"    { return RETURN;  }
"short"    { return SHORT;  }
"signed"    { return SIGNED;  }
"sizeof"    { return SIZEOF;  }
"static"    { return STATIC;  }
"struct"    { return STRUCT;  }
"switch"    { return SWITCH;  }
"typedef"    { return TYPEDEF;  }
"union"    { return UNION;  }
"unsigned"    { return UNSIGNED;  }
"void"    { return VOID;  }
"volatile"    { return VOLATILE;  }
"while"    { return WHILE;  }
"_Bool"    { return BOOL;  }
"_Complex"    { return CMPLX;  }
"_Imaginary"    { return IMGRY;  }


{id}    { return ID;  }
{cnst} {  return CONSTANT;  }

{newlin}     { yylineno++;  }
{space}     { ;  }
{str}      { return STRING; }
{pp_token}      { yylineno++; }
{comment}      { yylineno++;  }

"+"     { return PLUS; }
"-"     { return MINUS; }
"*"     { return TIMES; }
"/"     { return DIVIDE; }
"%"     { return MOD; }
"\|"    { return OR; }
"&"     { return AND; }
"~"     { return NOT; }
"\^"    { return XOR; }
"<<"    { return LSHIFT; }
">>"    { return RSHIFT; }
"\|\|"    { return LOR; }
"&&"    { return LAND; }
"!"    { return LNOT; }
"<"    { return LT; }
">"    { return GT; }
"<="    { return LE; }
">="    { return GE; }
"=="    { return EQ; }
"!="    { return NE; }
"="    { return EQUALS; }
"*="    { return TIMESEQUAL; }
"/="    { return DIVEQUAL; }
"%="    { return MODEQUAL; }
"+="    { return PLUSEQUAL; }
"-="    { return MINUSEQUAL; }
"<<="    { return LSHIFTEQUAL; }
">>="    { return RSHIFTEQUAL; }
"&="    { return ANDEQUAL; }
"\|="    { return OREQUAL; }
"\^="    { return XOREQUAL; }
"\+\+"    { return PLUSPLUS; }
"--"    { return MINUSMINUS; }
"->"    { return ARROW; }
"\?"    { return CONDOP; }
"\("    { return LPAREN; }
"\)"    { return RPAREN; }
"\[|<:"    { return LBRACKET; }
"\]|:>"    { return RBRACKET; }
","    { return COMMA; }
"\."    { return PERIOD; }
";"    { return SEMI; }
":"    { return COLON; }
"\.\.\."    { return ELLIPSIS; }
"\#\#|%:%:"    { return DHASH; }
"\{"    { return LBRACE; }
"\}"    { return RBRACE; }
%%
int yywrap()
{

}
