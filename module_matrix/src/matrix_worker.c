/*
 * Matrix op worker threads
 *
 * Copyright (C) 2011 Steve Kerrison <github@stevekerrison.com>
 *
 * This software is freely distributable under a derivative of the
 * University of Illinois/NCSA Open Source License posted in
 * LICENSE.txt and at <http://github.xcore.com/>
 */

#include "matrix_worker.h"


#include <stdio.h>

void matrix_mul_worker(int ptA, int ptDimA, int ptB, int ptDimB, int ptC,
	int ptOps, char nThreads, char offset)
{
	int *A = (int *)ptA, *B = (int *)ptB, *C = (int *)ptC,
		*ops = (int *)ptOps;
	short *dimA = (short *)ptDimA, *dimB = (short *)ptDimB;
	int p,r,c;
	ops += offset;
	*ops = 0;
	int rlim = dimA[0], clim = dimB[1], plim = dimA[1];
	for (r = 0; r < rlim; r++)
	{
		for (c = offset; c < clim; c += nThreads)
		{
			C[r * rlim + c] = 0;
			for (p = 0; p < plim; p += 1)
			{
				C[r * rlim + c] += A[r * plim + p] * B[p * clim + c];
				*ops += 1;
			}
		}
	}
	return;
}

void matrix_arr_worker(enum matrix_arrops op, int ptA, int ptDimA, int ptB, int ptDimB, int ptC,
	int ptOps, char nThreads, char offset)
{
	int *A = (int *)ptA, *B = (int *)ptB, *C = (int *)ptC,
		*ops = (int *)ptOps;
	short *dimA = (short *)ptDimA, *dimB = (short *)ptDimB;
	int r,c;
	ops += offset;
	*ops = 0;
	int rlim = dimA[0], clim = dimB[1];
	for (r = 0; r < rlim; r++)
	{
		for (c = offset; c < clim; c += nThreads)
		{
			switch (op)
			{
			case ADD:
				C[r * rlim + c] = A[r * rlim + c] + B[r * rlim + c];
				break;
			case SUB:
				C[r * rlim + c] = A[r * rlim + c] - B[r * rlim + c];
				break;
			case MUL:
				C[r * rlim + c] = A[r * rlim + c] * B[r * rlim + c];
				break;
			case DIV:
				C[r * rlim + c] = A[r * rlim + c] / B[r * rlim + c];
				break;
			default:
				break;	
			}
			*ops += 1;
		}
	}
	return;
}

void matrix_sca_mul_worker(int ptA, int ptDimA, int S, int ptC,
	int ptOps, char nThreads, char offset)
{
	int *A = (int *)ptA, *C = (int *)ptC,
		*ops = (int *)ptOps;
	short *dimA = (short *)ptDimA;
	int r,c;
	ops += offset;
	*ops = 0;
	int rlim = dimA[0], clim = dimA[1];
	for (r = 0; r < rlim; r++)
	{
		for (c = offset; c < clim; c += nThreads)
		{
			C[r * rlim + c] = A[r * rlim + c] * S;
			*ops += 1;
		}
	}
	return;
}
