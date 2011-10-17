/*
 * Matrix manipulation operations
 *
 * Copyright (C) 2011 Steve Kerrison <github@stevekerrison.com>
 *
 * This software is freely distributable under a derivative of the
 * University of Illinois/NCSA Open Source License posted in
 * LICENSE.txt and at <http://github.xcore.com/>
 */

#include <stdio.h> //For matrix_print
#include "matrix.h"
#include "matrix_worker.h"
#include "xs1.h"

int matrix_redim(short dims[4],short rows, short columns)
{
	if (dims[2] > rows || dims[3] > columns)
	{
		return -1; //Larger than initial size
	}
	dims[0] = rows;
	dims[1] = columns;
	return rows * columns;
}

int matrix_arr_mul(int A[], short dimA[2], int B[], short dimB[2],
	int ? C[], short ? dimC[2], char nThreads)
{
	int retval[8] = {0,0,0,0,0,0,0,0}, i;
	int ptA = pointer_int(A), ptB = pointer_int(B), ptC = pointer_int(C),
		ptDimA = pointer_short(dimA), ptDimB = pointer_short(dimB),
		ptRetval = pointer_int(retval);
	/* First do some sanity checks... */
	if (dimA[0] != dimB[0] || dimA[1] != dimB[1]) return -2; //Invalid dimensions
	if (isnull(C))
	{
		//No checks yet
	}
	else
	{
		if (dimC[1] < dimB[1])
		{
			return -4; //Not enough columns in destination matrix
		}
		if (dimC[0] < dimA[0])
		{
			return -5; //Not enough rows in destination matrix
		}
	}
	if (isnull(C))
	{
		//FIXME - Use a thread-safe strategy for in-place results
		return -1; //In-place result not supported at the moment
	}
	par (int t = 0; t < NTHREADS; t++)
	{
		matrix_arr_mul_worker(ptA,ptDimA,ptB,ptDimB,ptC,ptRetval,
			NTHREADS, t);
	}
	for (i = 1; i < 8; i++)
	{
		retval[0] += retval[i];
	}
	return retval[0];
}

int matrix_mul(int A[], short dimA[2], int B[], short dimB[2],
	int ? C[], short ? dimC[2], char nThreads)
{
	int retval[8] = {0,0,0,0,0,0,0,0}, i;
	int ptA = pointer_int(A), ptB = pointer_int(B), ptC = pointer_int(C),
		ptDimA = pointer_short(dimA), ptDimB = pointer_short(dimB),
		ptRetval = pointer_int(retval);
	/* First do some sanity checks... */
	if (dimA[1] != dimB[0]) return -2; //Matrices cannot be multiplied
	if (isnull(C))
	{
		if (dimA[1] < dimB[1])
			return -3; //Inline result cannot fit in matrix A.
	}
	else
	{
		if (dimC[1] < dimB[1])
		{
			return -4; //Not enough columns in destination matrix
		}
		if (dimC[0] < dimA[0])
		{
			return -5; //Not enough rows in destination matrix
		}
	}
	if (isnull(C))
	{
		//FIXME - Use a thread-safe strategy for in-place results
		return -1; //In-place result not supported at the moment
	}
	par (int t = 0; t < NTHREADS; t++)
	{
		matrix_mul_worker(ptA,ptDimA,ptB,ptDimB,ptC,ptRetval,
			NTHREADS, t);
	}
	for (i = 1; i < 8; i++)
	{
		retval[0] += retval[i];
	}
	return retval[0];
}

void matrix_print(char name[], int M[], short dimM[2])
{
	int r,c,s = dimM[0] * dimM[1];
	printf("Matrix %s =\n", name);
	for (r = 0; r < s; r += dimM[1])
	{
		printf(" ");
		for (c = 0; c < dimM[1]; c++)
		{
			printf(" %d ",M[r + c]);
		}
		printf("\n");
	}
	printf("\n");
}
