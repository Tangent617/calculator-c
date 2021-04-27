#include <stdlib.h>
#include <stdio.h>
#include <ctype.h>

#ifdef LEX_SELF
#include "myflex.h"
#else
#include "calculator_lex.h"
#endif

#include "calculator_yacc.h"

#ifndef LEX_MAIN

extern int yyparse (void);

int main(int argc, char *argv[])
{
    yyin = stdin;

    if(argc > 1)
    {
        if((yyin = fopen(argv[1],"r"))==NULL)
        {
            printf("Can't open file %s\n",argv[1]);
            return -1;
        }
    }

    yyparse();

    return 0;
}

#else
int main(int argc, char** argv)
{
    int c;
    FILE *pout;

    yyin = stdin;

    if(argc>1) {
        if((yyin=fopen(argv[1],"r"))==NULL) {
            printf("Can't open file %s\n",argv[1]); 
            exit(0);
        }
    }

    pout=fopen("result.dat","w");
    while(c=yylex()) {
        static int i=0;
        fprintf(pout,"(%4d,  %s)\t", c, yytext); i++;
        if( i==i/4*4) fprintf(pout,"\n");
    }
    fprintf(pout,"\n");
    fclose(pout);

    return 0;
}
#endif
