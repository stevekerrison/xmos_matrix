/*
 * Parallel matrix operations XC demo
 *
 * Copyright (C) 2011 Steve Kerrison <github@stevekerrison.com>
 *
 * This software is freely distributable under a derivative of the
 * University of Illinois/NCSA Open Source License posted in
 * LICENSE.txt and at <http://github.xcore.com/>
 */
 
#include <stdio.h>
#include "matrix.h"

int main(void)
{
	MATRIX_CREATE(A,8,8,	1, 4, 3, 1, 5, 1, 2, 1,
				1, 0, 3, 1, 3, 3, 3, 5,
				4, 4, 4, 0, 2, 2, 2, 3,
				3, 4, 3, 2, 2, 1, 0, 2,
				2, 3, 3, 2, 2, 0, 1, 4,
				4, 2, 2, 2, 4, 4, 3, 0,
				3, 4, 2, 5, 0, 4, 2, 5,
				4, 2, 1, 0, 1, 2, 4, 0	);
		
	MATRIX_CREATE(B,8,8,	3, 3, 5, 4, 2, 4, 1, 1,
				4, 4, 4, 3, 5, 4, 2, 4,
				2, 1, 2, 2, 4, 2, 3, 1,
				2, 2, 5, 2, 3, 4, 2, 3,
				2, 1, 1, 4, 2, 4, 3, 2,
				4, 1, 3, 2, 2, 4, 3, 5,
				4, 4, 4, 5, 2, 1, 2, 1,
				4, 1, 3, 4, 4, 4, 4, 3	);
	MATRIX_CREATE(C,8,8,0);
	timer t;
	unsigned int tvA, tvB;
	int ops = 0;
	
	/* Time the operation in case we want to do some benchmarks :) */
	t :> tvA;
	/* In-place scalar multiplication */
	ops += matrix_sca_op(MUL,MATRIX_REF(A),11023,MATRIX_NULL(),0);
	ops += matrix_sca_op(MUL,MATRIX_REF(B),1798,MATRIX_NULL(),0);
	/* Matrix-multiplication into destination matrix */
	ops += matrix_mul(MATRIX_REF(A),MATRIX_REF(B),MATRIX_REF(C),0);
	ops += matrix_arr_op(ADD,MATRIX_REF(A),MATRIX_REF(B),MATRIX_NULL(),0);
	t :> tvB;
	MATRIX_PRINT("A",A);
	MATRIX_PRINT("B",B);
	MATRIX_PRINT("C",C);
	printf("Ticks: %u, Ops: %u\n",tvB - tvA, ops);
	return 0;
}
