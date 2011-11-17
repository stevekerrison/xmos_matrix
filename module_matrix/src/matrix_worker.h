/*
 * Matrix op worker threads
 *
 * Copyright (C) 2011 Steve Kerrison <github@stevekerrison.com>
 *
 * This software is freely distributable under a derivative of the
 * University of Illinois/NCSA Open Source License posted in
 * LICENSE.txt and at <http://github.xcore.com/>
 */

#ifndef MATRIX_WORKER_H_
#define MATRIX_WORKER_H_

#include "matrix.h"

void matrix_mul_worker(int ptA, int ptDimA, int ptB, int ptDimB, int ptC,
	int ptOps, char nThreads, char offset);
	
void matrix_arr_worker(enum matrix_ops op, int ptA, int ptDimA, int ptB, int ptDimB, int ptC,
	int ptOps, char nThreads, char offset);
	
void matrix_sca_worker(enum matrix_ops op, int ptA, int ptDimA, int S, int ptC,
	int ptOps, char nThreads, char offset);

#endif /* MATRIX_WORKER_H_ */
