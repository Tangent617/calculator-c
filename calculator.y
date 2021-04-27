%{
#include <stdlib.h>
#include <stdio.h>
#include <ctype.h>
#include <string.h>

#include "expr.h"

#ifdef LEX_SELF
#include "myflex.h"
#else
#include "calculator_lex.h"
#endif
#include "calculator_yacc.h"

void yyerror(char * msg);

extern int line_no;

%}

%union
{
    struct expr * exp;
    //int number;
    double number;
};

%start  Input

%left '+'
%left '-'
%left '*'
%left '/'

%token  DIGIT

%type <number> DIGIT
%type <exp> Expr
%type <exp> Term
%type <exp> Factor

%%
Input   : /* empty line */
        | Input Line; /* multi lines */

Line   : '\n'
        | Expr '\n'
            {
                expr_print($1);
            };

Expr   :  Term
            {
                /* Expr = Term */
                $$ = $1;
            }
        |  Expr '+' Term
            {   /* Expr = Expr + Term */
                expr_add($1, $3, $$);
            }
        |  Expr '-' Term
            {   /* Expr = Expr - Term */
                expr_sub($1, $3, $$);
            };

Term   :  Factor
            {
                /* Term = Factor */
                $$ = $1;
            }
        |  Term '*' Factor
            {
                /* Term = Term * Factor */
                expr_mult($1, $3, $$);
            }
        |  Term '/' Factor
            {
                /* Term = Term / Factor */
                expr_div($1, $3, $$);
            }

Factor :  '(' Expr ')'
            {
                /* Factor=Expr */
                $$ = $2;
            }
       |  DIGIT
            {
                struct expr *tmp_node;

                tmp_node = expr_alloc(INT_TYPE, $1);
                if(NULL == tmp_node) {
                    printf("memory alloc failed\n");
                    exit(-1);
                }

                $$ = tmp_node;
            };
%%

void yyerror(char * msg)
{
    printf("Line(%d): %s\n", line_no, msg);
}
