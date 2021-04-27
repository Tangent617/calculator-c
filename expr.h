
#ifndef __EXPR_H__
#define __EXPR_H__

#define INT_TYPE    0
#define REAL_TYPE   1

typedef struct expr
{
    int type;
    //int val;
    double val;
} expr;

struct expr * expr_alloc();

void expr_print(struct expr * obj);

int expr_add(struct expr * src1, struct expr *src2, struct expr * result);
int expr_sub(struct expr * src1, struct expr *src2, struct expr * result);
int expr_mult(struct expr * src1, struct expr *src2, struct expr * result);
int expr_div(struct expr * src1, struct expr *src2, struct expr * result);

#endif
