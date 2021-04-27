#ifndef __MYLEX_H__
#define __MYLEX_H__

#include <stdio.h>

extern int line_no;
extern FILE * yyin;

int yylex (void);

#endif
