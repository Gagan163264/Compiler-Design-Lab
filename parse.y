%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>

	void yyerror(const char*); // error handling function
	int yylex(); // declare the function performing lexical analysis
	extern int yylineno; // track the line number
	extern char* yytext;
	int err = 0;
%}

%token AUTO BREAK CASE CHAR CONST CONTINUE DEFAULT DO DOUBLE ELSE ENUM EXTERN FLOAT FOR GOTO IF
%token INLINE INT LONG REGISTER RESTRICT RETURN SHORT SIGNED SIZEOF STATIC STRUCT SWITCH TYPEDEF UNION UNSIGNED VOID VOLATILE WHILE BOOL CMPLX IMGRY

%token ID CONSTANT
%token PLUS MINUS TIMES DIVIDE MOD PLUSPLUS MINUSMINUS
%token EQUALS TIMESEQUAL DIVEQUAL MODEQUAL PLUSEQUAL MINUSEQUAL LSHIFTEQUAL RSHIFTEQUAL ANDEQUAL XOREQUAL OREQUAL
%token OR AND NOT XOR LSHIFT RSHIFT LOR LAND LNOT LT LE GT GE EQ NE
%token LPAREN RPAREN LBRACKET RBRACKET LBRACE RBRACE
%token COMMA PERIOD SEMI COLON ARROW
%token CONDOP ELLIPSIS UNARY STRING PREPROCESSOR_TOKEN DHASH
%token COMMENT

%start START
%%

START : translation_unit { if(err==0) {printf("Valid syntax\n"); YYACCEPT;} }
                    ;

primary_expression : ID
                    | CONSTANT
                    | STRING
                    | LPAREN expression RPAREN
                    ;

postfix_expression : primary_expression
                    | postfix_expression LBRACKET expression RBRACKET
                    | postfix_expression LPAREN RPAREN
                    | postfix_expression LPAREN argument_expression_list RPAREN
                    | postfix_expression PERIOD ID
                    | postfix_expression ARROW ID
                    | postfix_expression PLUSPLUS
                    | postfix_expression MINUSMINUS
                    ;

argument_expression_list : assignment_expression
                  	| argument_expression_list COMMA assignment_expression
                    ;

unary_expression : postfix_expression
                  	| PLUSPLUS unary_expression
                  	| MINUSMINUS unary_expression
                  	| unary_operator cast_expression
                  	| SIZEOF unary_expression
                  	| SIZEOF LPAREN type_name RPAREN
                    ;

unary_operator : AND
                    | TIMES
                    | PLUS
                    | MINUS
                    | NOT
                    | LNOT
                    ;

cast_expression : unary_expression
                  	| LPAREN type_name RPAREN cast_expression
                    ;

multiplicative_expression : cast_expression
                  	| multiplicative_expression TIMES cast_expression
                  	| multiplicative_expression DIVIDE cast_expression
                  	| multiplicative_expression MOD cast_expression
                    ;

additive_expression : multiplicative_expression
                  	| additive_expression PLUS multiplicative_expression
                  	| additive_expression MINUS multiplicative_expression
                    ;

shift_expression : additive_expression
                  	| shift_expression LSHIFT additive_expression
                  	| shift_expression RSHIFT additive_expression
                    ;

relational_expression : shift_expression
                  	| relational_expression LT shift_expression
                  	| relational_expression GT shift_expression
                  	| relational_expression LE shift_expression
                  	| relational_expression GE shift_expression
                    ;

equality_expression : relational_expression
                  	| equality_expression EQ relational_expression
                  	| equality_expression NE relational_expression
                    ;

and_expression : equality_expression
                  	| and_expression AND equality_expression
                    ;

exclusive_or_expression : and_expression
                  	| exclusive_or_expression XOR and_expression
                    ;

inclusive_or_expression : exclusive_or_expression
                  	| inclusive_or_expression OR exclusive_or_expression
                    ;

logical_and_expression : inclusive_or_expression
                  	| logical_and_expression LAND inclusive_or_expression
                    ;

logical_or_expression : logical_and_expression
                  	| logical_or_expression LOR logical_and_expression
                    ;

conditional_expression : logical_or_expression
                  	| logical_or_expression CONDOP expression COLON conditional_expression
                    ;

assignment_expression : conditional_expression
                  	| unary_expression assignment_operator assignment_expression
                    ;

assignment_operator : EQUALS
                  	| TIMESEQUAL
                  	| DIVEQUAL
                  	| MODEQUAL
                  	| PLUSEQUAL
                  	| MINUSEQUAL
                  	| LSHIFTEQUAL
                  	| RSHIFTEQUAL
                  	| ANDEQUAL
                  	| XOREQUAL
                  	| OREQUAL
                    ;

expression : assignment_expression
                  	| expression COMMA assignment_expression
                    ;

constant_expression : conditional_expression
                    ;

declaration : declaration_specifiers SEMI
                  	| declaration_specifiers init_declarator_list SEMI
                    ;

declaration_specifiers : storage_class_specifier
                  	| storage_class_specifier declaration_specifiers
                  	| type_specifier
                  	| type_specifier declaration_specifiers
                  	| type_qualifier
                  	| type_qualifier declaration_specifiers
                    ;

init_declarator_list : init_declarator
                  	| init_declarator_list COMMA init_declarator
                    ;

init_declarator : declarator
                  	| declarator EQUALS initializer
                    ;

storage_class_specifier : TYPEDEF
                  	| EXTERN
                  	| STATIC
                  	| AUTO
                  	| REGISTER
                    ;

type_specifier : VOID
                  	| CHAR
                  	| SHORT
                  	| INT
                  	| LONG
                  	| FLOAT
                  	| DOUBLE
                  	| SIGNED
                  	| UNSIGNED
                  	| struct_or_union_specifier
                    ;

struct_or_union_specifier : struct_or_union ID LBRACE struct_declaration_list RBRACE
                  	| struct_or_union LBRACE struct_declaration_list RBRACE
                  	| struct_or_union ID
                    ;

struct_or_union : STRUCT
                  	| UNION
                    ;

struct_declaration_list : struct_declaration
                  	| struct_declaration_list struct_declaration
                    ;

struct_declaration : specifier_qualifier_list struct_declarator_list SEMI
                    ;

specifier_qualifier_list : type_specifier specifier_qualifier_list
                  	| type_specifier
                  	| type_qualifier specifier_qualifier_list
                  	| type_qualifier
                    ;

struct_declarator_list : struct_declarator
                  	| struct_declarator_list COMMA struct_declarator
                    ;

struct_declarator : declarator
                  	| COLON constant_expression
                  	| declarator COLON constant_expression
                    ;

type_qualifier : CONST
                  	| VOLATILE
                    ;

declarator : pointer direct_declarator
                  	| direct_declarator
                    ;

direct_declarator : ID
                  	| LPAREN declarator RPAREN
                  	| direct_declarator LBRACKET constant_expression RBRACKET
                  	| direct_declarator LBRACKET RBRACKET
                  	| direct_declarator LPAREN parameter_type_list RPAREN
                  	| direct_declarator LPAREN ID_list RPAREN
                  	| direct_declarator LPAREN RPAREN
                    ;

pointer : TIMES
                  	| TIMES type_qualifier_list
                  	| TIMES pointer
                  	| TIMES type_qualifier_list pointer
                    ;

type_qualifier_list : type_qualifier
                  	| type_qualifier_list type_qualifier
                    ;

parameter_type_list : parameter_list
                  	| parameter_list COMMA ELLIPSIS
                    ;

parameter_list : parameter_declaration
                  	| parameter_list COMMA parameter_declaration
                    ;

parameter_declaration : declaration_specifiers declarator
                  	| declaration_specifiers abstract_declarator
                  	| declaration_specifiers
                    ;

ID_list : ID
                  	| ID_list COMMA ID
                    ;

type_name : specifier_qualifier_list
                  	| specifier_qualifier_list abstract_declarator
                    ;

abstract_declarator : pointer
                  	| direct_abstract_declarator
                  	| pointer direct_abstract_declarator
                    ;

direct_abstract_declarator : LPAREN abstract_declarator RPAREN
                  	| LBRACKET RBRACKET
                  	| LBRACKET constant_expression RBRACKET
                  	| direct_abstract_declarator LBRACKET RBRACKET
                  	| direct_abstract_declarator LBRACKET constant_expression RBRACKET
                  	| LPAREN RPAREN
                  	| LPAREN parameter_type_list RPAREN
                  	| direct_abstract_declarator LPAREN RPAREN
                  	| direct_abstract_declarator LPAREN parameter_type_list RPAREN
                    ;

initializer : assignment_expression
                  	| LBRACE initializer_list RBRACE
                  	| LBRACE initializer_list COMMA RBRACE
                    ;

initializer_list : initializer
                  	| initializer_list COMMA initializer
                    ;

statement : labeled_statement
                  	| compound_statement
                  	| expression_statement
                  	| selection_statement
                  	| iteration_statement
                  	| jump_statement
                    ;

labeled_statement : ID COLON statement
                  	| CASE constant_expression COLON statement
                  	| DEFAULT COLON statement
                    ;

compound_statement : LBRACE RBRACE
                  	| LBRACE statement_list RBRACE
                  	| LBRACE declaration_list RBRACE
                  	| LBRACE declaration_list statement_list RBRACE
                    ;

declaration_list : declaration
                  	| declaration_list declaration
                    ;

statement_list : statement
                  	| statement_list statement
                    ;

expression_statement : SEMI
                  	| expression SEMI
                    ;

selection_statement : IF LPAREN expression RPAREN statement
                  	| IF LPAREN expression RPAREN statement ELSE statement
                  	| SWITCH LPAREN expression RPAREN statement
                    ;

iteration_statement : WHILE LPAREN expression RPAREN statement
                  	| DO statement WHILE LPAREN expression RPAREN SEMI
                  	| FOR LPAREN expression_statement expression_statement RPAREN statement
                  	| FOR LPAREN expression_statement expression_statement expression RPAREN statement
                    ;

jump_statement : GOTO ID SEMI
                  	| CONTINUE SEMI
                  	| BREAK SEMI
                  	| RETURN SEMI
                  	| RETURN expression SEMI
                    ;

translation_unit : external_declaration
                  	| translation_unit external_declaration
                    ;

external_declaration : function_definition
                  	| declaration
                    ;

function_definition : declaration_specifiers declarator declaration_list compound_statement
                  	| declaration_specifiers declarator compound_statement
                  	| declarator declaration_list compound_statement
                  	| declarator compound_statement
                    ;
%%

void yyerror(const char* s)
{
	printf("Error: %s,line number: %d,token: %s\n",s,yylineno,yytext);
	err = 1; // An error has occurred
}

int main() {
    yyparse();
    return 0;
}
