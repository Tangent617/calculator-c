#include "expr.h"

#include <stdlib.h>
#include <stdio.h>
#include <ctype.h>
#include <string.h>

// expression allocate
//struct expr * expr_alloc(int type, int val)
struct expr * expr_alloc(int type, double val)
{
    struct expr *tmp_node = NULL;

    tmp_node = (struct expr*)malloc(sizeof(struct expr));
    if(NULL == tmp_node) {
        printf("memory alloc failed\n");
        return NULL;
    }

    tmp_node->type = type;
    tmp_node->val = val;

    return tmp_node;
}

// expression print
void expr_print(struct expr * obj)
{
    if(INT_TYPE == obj->type) {
        //printf("=%d\n", obj->val);
        printf("=%g\n", obj->val);
    }
}

// expresion add
int expr_add(struct expr * src1, struct expr *src2, struct expr * result)
{
    // TODO real number add
    result->type = src1->type;
    result->val = src1->val + src2->val;

    // Success
    return 0;
}

// expresion substraction
int expr_sub(struct expr * src1, struct expr *src2, struct expr * result)
{
    // TODO real number add
    result->type = src1->type;
    result->val = src1->val - src2->val;

    // Success
    return 0;
}

// expresion multiply
int expr_mult(struct expr * src1, struct expr *src2, struct expr * result)
{
    // TODO real number add
    result->type = src1->type;
    result->val = src1->val * src2->val;

    // Success
    return 0;
}

// expresion division
int expr_div(struct expr * src1, struct expr *src2, struct expr * result)
{
    // TODO real number add
    result->type = src1->type;
    result->val = src1->val / src2->val;

    // Success
    return 0;
}

