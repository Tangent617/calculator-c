%{
#include <stdio.h>
#include <ctype.h>
#include <string.h>

#include "calculator_yacc.h"

#define		ERRORCHAR	600

int line_no=1;
%}
/************************************
*	MACRO DEFINITION	*
*************************************/
letter		[A-Za-z]
alnum		[A-Za-z0-9]
d			[0-9]
white		[\t\040]
white_line  [\n]

integer     [1-9][0-9]*|0
float       [0-9]*\.[0-9]+
science     ({float}|{integer})[Ee][+-]?[0-9]+

/*****************************************
*	RECOGNIION RULES	         *
*****************************************/
%%
{d}+		{
                ECHO;
                yylval.number = (int)strtol(yytext, (char **)NULL, 10);
                return DIGIT;
            }
{float}|{science}   {
                ECHO;
                yylval.number = strtod(yytext, (char **)NULL);
                return DIGIT;
            }

"("			{ECHO;return '(';}
")"			{ECHO;return ')';}

"\."        {ECHO;return '.';}
"*"			{ECHO;return '*';}
"+"			{ECHO;return '+';}
"-"			{ECHO;return '-';}
"/"			{ECHO;return '/';}
"%"			{ECHO;return '%';}

{white}+		{/* ECHO; */}
{white_line}    {
                    line_no++;
                    return '\n';
                }

.			{
                printf("Invalid char %s\n",yytext);
                return ERRORCHAR;
            }

%%

#ifndef yywrap
int yywrap()
{
    /*
     * 1) returns 1 to quit parsing
     * 2) set yyin to another file and returns 0 to continues parsing the newly added file.
     */
    return 1;
}
#endif
