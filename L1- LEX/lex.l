%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
%}

id [a-zA-Z_][a-zA-Z0-9_]*
cnst [0-9]*\.[0-9]+|[0-9]+|\'.\'
newlin \n+
space " "
str \".*\"
pp_token #.*\n
comment \/\/.*\n|\/\*(.|\n)*\*\/

%%
"auto" {  printf("AUTO\n");  }
"break"    { printf("BREAK\n");  }
"case"    { printf("CASE\n");  }
"char"    { printf("CHAR\n");  }
"const"    { printf("CONST\n");  }
"continue"    { printf("CONTINUE\n");  }
"default"    { printf("DEFAULT\n");  }
"do"    { printf("DO\n");  }
"double"    { printf("DOUBLE\n");  }
"else"    { printf("ELSE\n");  }
"enum"    { printf("ENUM\n");  }
"extern"    { printf("EXTERN\n");  }
"float"    { printf("FLOAT\n");  }
"for"    { printf("FOR\n");  }
"goto"    { printf("GOTO\n");  }
"if"    { printf("IF\n");  }
"inline"    { printf("INLINE\n");  }
"int"    { printf("INT\n");  }
"long"    { printf("LONG\n");  }
"register"    { printf("REGISTER\n");  }
"restrict"    { printf("RESTRICT\n");  }
"return"    { printf("RETURN\n");  }
"short"    { printf("SHORT\n");  }
"signed"    { printf("SIGNED\n");  }
"sizeof"    { printf("SIZEOF\n");  }
"static"    { printf("STATIC\n");  }
"struct"    { printf("STRUCT\n");  }
"switch"    { printf("SWITCH\n");  }
"typedef"    { printf("TYPEDEF\n");  }
"union"    { printf("UNION\n");  }
"unsigned"    { printf("UNSIGNED\n");  }
"void"    { printf("VOID\n");  }
"volatile"    { printf("VOLATILE\n");  }
"while"    { printf("WHILE\n");  }
"_Bool"    { printf("BOOL\n");  }
"_Complex"    { printf("CMPLX\n");  }
"_Imaginary"    { printf("IMGRY\n");  }


{id}    { printf("ID : %s\n", yytext);  }
{cnst} {  printf("CONSTANT : %s\n", yytext);  }

{newlin}     { yylineno++;  }
{space}     { ;  }
{str}      { printf("STRING\n"); }
{pp_token}      { yylineno++; }
{comment}      { yylineno++;  }

"+"     { printf("PLUS\n"); }
"-"     { printf("MINUS\n"); }
"*"     { printf("TIMES\n"); }
"/"     { printf("DIVIDE\n"); }
"%"     { printf("MOD\n"); }
"\|"    { printf("OR\n"); }
"&"     { printf("AND\n"); }
"~"     { printf("NOT\n"); }
"\^"    { printf("XOR\n"); }
"<<"    { printf("LSHIFT\n"); }
">>"    { printf("RSHIFT\n"); }
"\|\|"    { printf("LOR\n"); }
"&&"    { printf("LAND\n"); }
"!"    { printf("LNOT\n"); }
"<"    { printf("LT\n"); }
">"    { printf("GT\n"); }
"<="    { printf("LE\n"); }
">="    { printf("GE\n"); }
"=="    { printf("EQ\n"); }
"!="    { printf("NE\n"); }
"="    { printf("EQUALS\n"); }
"*="    { printf("TIMESEQUAL\n"); }
"/="    { printf("DIVEQUAL\n"); }
"%="    { printf("MODEQUAL\n"); }
"+="    { printf("PLUSEQUAL\n"); }
"-="    { printf("MINUSEQUAL\n"); }
"<<="    { printf("LSHIFTEQUAL\n"); }
">>="    { printf("RSHIFTEQUAL\n"); }
"&="    { printf("ANDEQUAL\n"); }
"\|="    { printf("OREQUAL\n"); }
"\^="    { printf("XOREQUAL\n"); }
"\+\+"    { printf("PLUSPLUS\n"); }
"--"    { printf("MINUSMINUS\n"); }
"->"    { printf("ARROW\n"); }
"\?"    { printf("CONDOP\n"); }
"\("    { printf("LPAREN\n"); }
"\)"    { printf("RPAREN\n"); }
"\[|<:"    { printf("LBRACKET\n"); }
"\]|:>"    { printf("RBRACKET\n"); }
","    { printf("COMMA\n"); }
"\."    { printf("PERIOD\n"); }
";"    { printf("SEMI\n"); }
":"    { printf("COLON\n"); }
"\.\.\."    { printf("ELLIPSIS\n"); }
"\#\#|%:%:"    { printf("DHASH\n"); }
"\{"    { printf("LBRACE\n"); }
"\}"    { printf("RBRACE\n"); }
%%
int yywrap()
{

}

int main()
{
  yylex();
  return 1;
}
